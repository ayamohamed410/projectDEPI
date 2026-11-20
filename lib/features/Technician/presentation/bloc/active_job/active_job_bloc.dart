import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../jobs/job_model.dart';
import '../../../../jobs/jobs_repository.dart';
import 'active_job_event.dart';

part 'active_job_state.dart';

class ActiveJobBloc extends Bloc<ActiveJobEvent, ActiveJobState> {
  /// TODO: confirm the platform fee with the team (design: 420 -> 370).
  static const double platformFee = 50;

  /// Max size of a photo saved inside the Firestore document (limit is 1 MB).
  static const int maxPhotoChars = 700 * 1024;

  final JobsRepository _repository;
  StreamSubscription<JobModel?>? _jobSubscription;
  Timer? _timer;
  String? _requestedJobId;

  ActiveJobBloc(this._repository) : super(const ActiveJobState()) {
    on<LoadActiveJob>(_onLoad);
    on<RetryPressed>(_onRetry);
    on<JobUpdated>(_onJobUpdated);
    on<AdvanceStatus>(_onAdvanceStatus);
    on<AddPartRequested>(_onAddPart);
    on<PhotoPicked>(_onPhotoPicked);
    on<CompletePressed>(_onComplete);
    on<ReportIssueRequested>(_onReportIssue);
    on<TimerTicked>(_onTimerTicked);
    on<MessageShown>(_onMessageShown);
  }

  // ---------------------------------------------------------------- load

  Future<void> _onLoad(LoadActiveJob event, Emitter<ActiveJobState> emit) async {
    _requestedJobId = event.jobId;
    emit(state.copyWith(status: ActiveJobStatus.loading, clearError: true));
    try {
      JobModel? job;
      final id = event.jobId;
      if (id != null && id.isNotEmpty) {
        job = await _repository.watchJob(id).first;
      } else {
        job = await _repository.getActiveJobForTechnician();
      }

      if (job == null) {
        emit(state.copyWith(status: ActiveJobStatus.empty));
        return;
      }

      emit(state.copyWith(
        status: ActiveJobStatus.loaded,
        job: job,
        minutesInProgress: _minutesOf(job),
      ));

      await _jobSubscription?.cancel();
      _jobSubscription = _repository.watchJob(job.id).listen(
            (updated) => add(JobUpdated(updated)),
            onError: (_) {},
          );

      _timer?.cancel();
      _timer = Timer.periodic(
        const Duration(seconds: 30),
        (_) => add(const TimerTicked()),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ActiveJobStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onRetry(RetryPressed event, Emitter<ActiveJobState> emit) {
    add(LoadActiveJob(_requestedJobId));
  }

  void _onJobUpdated(JobUpdated event, Emitter<ActiveJobState> emit) {
    final job = event.job;
    if (job == null) {
      emit(state.copyWith(status: ActiveJobStatus.empty));
      return;
    }
    emit(state.copyWith(
      status: ActiveJobStatus.loaded,
      job: job,
      minutesInProgress: _minutesOf(job),
    ));
  }

  void _onTimerTicked(TimerTicked event, Emitter<ActiveJobState> emit) {
    final job = state.job;
    if (job == null) return;
    emit(state.copyWith(minutesInProgress: _minutesOf(job)));
  }

  int _minutesOf(JobModel job) {
    final start = job.timeOf(JobStatus.inProgress);
    if (start == null) return 0;
    final minutes = DateTime.now().difference(start).inMinutes;
    return minutes < 0 ? 0 : minutes;
  }

  // -------------------------------------------------------------- status

  Future<void> _onAdvanceStatus(
    AdvanceStatus event,
    Emitter<ActiveJobState> emit,
  ) async {
    final job = state.job;
    if (job == null || state.isUpdating) return;

    final next = JobStatus.next(state.jobStatus);
    if (next == null) {
      emit(state.copyWith(message: 'Accept the request first.'));
      return;
    }
    if (next == JobStatus.completed) {
      emit(state.copyWith(
        message: 'Use "Complete Service & Generate Receipt" to finish.',
      ));
      return;
    }

    emit(state.copyWith(isUpdating: true));
    try {
      await _repository.updateStatus(job.id, next);
      emit(state.copyWith(isUpdating: false));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        message: 'Could not update the status: $e',
      ));
    }
  }

  // --------------------------------------------------------------- parts

  Future<void> _onAddPart(
    AddPartRequested event,
    Emitter<ActiveJobState> emit,
  ) async {
    final job = state.job;
    if (job == null || !state.isEditable) return;

    emit(state.copyWith(isUpdating: true));
    try {
      await _repository.addPart(job.id, event.part);
      emit(state.copyWith(isUpdating: false, message: 'Part added.'));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        message: 'Could not add the part: $e',
      ));
    }
  }

  // -------------------------------------------------------------- photos

  Future<void> _onPhotoPicked(
    PhotoPicked event,
    Emitter<ActiveJobState> emit,
  ) async {
    final job = state.job;
    if (job == null || !state.isEditable) return;

    final dataUri = 'data:image/jpeg;base64,${base64Encode(event.bytes)}';
    if (dataUri.length > maxPhotoChars) {
      emit(state.copyWith(
        message: 'The photo is too large. Please take a smaller one.',
      ));
      return;
    }

    emit(event.isBefore
        ? state.copyWith(uploadingBefore: true)
        : state.copyWith(uploadingAfter: true));
    try {
      await _repository.setPhotoUrl(
        job.id,
        before: event.isBefore,
        url: dataUri,
      );
      emit(event.isBefore
          ? state.copyWith(uploadingBefore: false)
          : state.copyWith(uploadingAfter: false));
    } catch (e) {
      emit(event.isBefore
          ? state.copyWith(
              uploadingBefore: false,
              message: 'Could not save the photo: $e',
            )
          : state.copyWith(
              uploadingAfter: false,
              message: 'Could not save the photo: $e',
            ));
    }
  }

  // ------------------------------------------------------------ complete

  Future<void> _onComplete(
    CompletePressed event,
    Emitter<ActiveJobState> emit,
  ) async {
    final job = state.job;
    if (job == null || !state.canComplete) return;

    // Never let the fee make the payout negative (e.g. total still 0).
    final fee = job.totalAmount > platformFee ? platformFee : 0.0;

    emit(state.copyWith(isCompleting: true));
    try {
      await _repository.completeJob(job.id, platformFee: fee);
      emit(state.copyWith(
        isCompleting: false,
        completed: true,
        message: 'Service completed. Receipt generated.',
      ));
    } catch (e) {
      emit(state.copyWith(
        isCompleting: false,
        message: 'Could not complete the service: $e',
      ));
    }
  }

  // -------------------------------------------------------------- report

  Future<void> _onReportIssue(
    ReportIssueRequested event,
    Emitter<ActiveJobState> emit,
  ) async {
    final job = state.job;
    if (job == null) return;

    try {
      await _repository.reportIssue(job.id, event.reason);
      emit(state.copyWith(message: 'Issue reported. Thank you.'));
    } catch (e) {
      emit(state.copyWith(message: 'Could not report the issue: $e'));
    }
  }

  void _onMessageShown(MessageShown event, Emitter<ActiveJobState> emit) {
    emit(state.copyWith(clearMessage: true));
  }

  @override
  Future<void> close() {
    _jobSubscription?.cancel();
    _timer?.cancel();
    return super.close();
  }
}
