import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../jobs/job_model.dart';
import '../../../../jobs/jobs_repository.dart';

part 'incoming_requests_event.dart';
part 'incoming_requests_state.dart';

class IncomingRequestsBloc
    extends Bloc<IncomingRequestsEvent, IncomingRequestsState> {
  final JobsRepository _jobsRepository;

  StreamSubscription<List<JobModel>>? _requestsSubscription;

  IncomingRequestsBloc(this._jobsRepository)
    : super(const IncomingRequestsState()) {
    on<LoadIncomingRequests>(_onLoadIncomingRequests);
    on<IncomingRequestsUpdated>(_onIncomingRequestsUpdated);
    on<RetryIncomingRequests>(_onRetryIncomingRequests);
    on<IncomingRequestsFailed>(_onIncomingRequestsFailed);
  }

  // ******************************
  Future<void> _onLoadIncomingRequests(
    LoadIncomingRequests event,
    Emitter<IncomingRequestsState> emit,
  ) async {
    emit(
      state.copyWith(status: IncomingRequestsStatus.loading, clearError: true),
    );

    await _requestsSubscription?.cancel();

    _requestsSubscription = _jobsRepository.watchIncomingRequests().listen(
      (requests) {
        add(IncomingRequestsUpdated(requests));
      },
      onError: (error) {
        add(IncomingRequestsFailed(error.toString()));
      },
    );
  }

  // ******************************
  void _onIncomingRequestsUpdated(
    IncomingRequestsUpdated event,
    Emitter<IncomingRequestsState> emit,
  ) {
    emit(
      state.copyWith(
        status: event.requests.isEmpty
            ? IncomingRequestsStatus.empty
            : IncomingRequestsStatus.loaded,
        requests: event.requests,
        clearError: true,
      ),
    );
  }

  void _onRetryIncomingRequests(
    RetryIncomingRequests event,
    Emitter<IncomingRequestsState> emit,
  ) {
    add(const LoadIncomingRequests());
  }

  //***************************8 */
  void _onIncomingRequestsFailed(
    IncomingRequestsFailed event,
    Emitter<IncomingRequestsState> emit,
  ) {
    emit(
      state.copyWith(
        status: IncomingRequestsStatus.error,
        errorMessage: event.message,
      ),
    );
  }

  // Cancel
  @override
  Future<void> close() async {
    await _requestsSubscription?.cancel();
    return super.close();
  }
}
