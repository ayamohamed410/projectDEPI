import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_depi/features/jobs/job_model.dart';
import 'package:final_depi/features/jobs/jobs_repository.dart';

import 'request_status_event.dart';
import 'request_status_state.dart';

class RequestStatusBloc extends Bloc<RequestStatusEvent, RequestStatusState> {
  final JobsRepository _repository;

  StreamSubscription<List<JobModel>>? _requestsSubscription;
  StreamSubscription<JobModel?>? _jobSubscription;

  JobModel? _currentJob;

  RequestStatusBloc(this._repository) : super(const RequestStatusInitial()) {
    on<LoadLatestRequest>(_onLoadLatestRequest);
    on<LatestRequestUpdated>(_onLatestRequestUpdated);
    on<LoadRequestById>(_onLoadRequestById);
    on<RequestByIdUpdated>(_onRequestByIdUpdated);
    on<DeleteRequest>(_onDeleteRequest);
    on<RequestStatusLoadFailed>(_onLoadFailed);
  }

  // Load the customer's requests and listen for real-time updates.
  Future<void> _onLoadLatestRequest(
    LoadLatestRequest event,
    Emitter<RequestStatusState> emit,
  ) async {
    emit(const RequestStatusLoading());

    await _requestsSubscription?.cancel();

    try {
      _requestsSubscription = _repository.watchCustomerJobs().listen(
        (jobs) {
          final latestJob = jobs.isNotEmpty ? jobs.first : null;
          add(LatestRequestUpdated(latestJob));
        },
        onError: (error) {
          add(RequestStatusLoadFailed(error.toString()));
        },
      );
    } catch (e) {
      emit(RequestStatusError(e.toString()));
    }
  }

  // Load a specific request and listen for real-time updates.
  Future<void> _onLoadRequestById(
    LoadRequestById event,
    Emitter<RequestStatusState> emit,
  ) async {
    emit(const RequestStatusLoading());

    await _jobSubscription?.cancel();

    try {
      _jobSubscription = _repository
          .watchJob(event.jobId)
          .listen(
            (job) {
              add(RequestByIdUpdated(job));
            },
            onError: (error) {
              add(RequestStatusLoadFailed(error.toString()));
            },
          );
    } catch (e) {
      emit(RequestStatusError(e.toString()));
    }
  }

  // Update the screen with the latest request.
  void _onLatestRequestUpdated(
    LatestRequestUpdated event,
    Emitter<RequestStatusState> emit,
  ) {
    _currentJob = event.job;

    if (_currentJob == null) {
      emit(const RequestStatusEmpty());
      return;
    }

    emit(RequestStatusLoaded(_currentJob!));
  }

  // Update the screen with the specific request.
  void _onRequestByIdUpdated(
    RequestByIdUpdated event,
    Emitter<RequestStatusState> emit,
  ) {
    _currentJob = event.job;

    if (_currentJob == null) {
      emit(const RequestStatusEmpty());
      return;
    }

    emit(RequestStatusLoaded(_currentJob!));
  }

  void _onLoadFailed(
    RequestStatusLoadFailed event,
    Emitter<RequestStatusState> emit,
  ) {
    emit(RequestStatusError(event.message));
  }

  // Delete the request and its chat messages.
  Future<void> _onDeleteRequest(
    DeleteRequest event,
    Emitter<RequestStatusState> emit,
  ) async {
    final job = _currentJob;

    if (job == null) return;

    emit(const RequestStatusDeleting());

    await _requestsSubscription?.cancel();
    _requestsSubscription = null;

    try {
      await _repository.deleteCustomerRequest(job.id);

      _currentJob = null;
      emit(const RequestStatusDeleteSuccess());
    } catch (e) {
      emit(RequestStatusError(e.toString()));

      _requestsSubscription = _repository.watchCustomerJobs().listen(
        (jobs) {
          final latestJob = jobs.isNotEmpty ? jobs.first : null;
          add(LatestRequestUpdated(latestJob));
        },
        onError: (error) {
          add(RequestStatusLoadFailed(error.toString()));
        },
      );
    }
  }

  @override
  Future<void> close() {
    _requestsSubscription?.cancel();
    _jobSubscription?.cancel();
    return super.close();
  }
}
