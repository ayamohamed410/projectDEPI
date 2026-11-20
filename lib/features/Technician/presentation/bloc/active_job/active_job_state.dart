part of 'active_job_bloc.dart';

enum ActiveJobStatus { initial, loading, loaded, empty, error }

class ActiveJobState extends Equatable {
  final ActiveJobStatus status;
  final JobModel? job;
  final bool isUpdating;
  final bool uploadingBefore;
  final bool uploadingAfter;
  final bool isCompleting;
  final int minutesInProgress;
  final String? errorMessage;


  final String? message;

  /// Becomes true after the job was completed successfully (screen navigates).
  final bool completed;

  const ActiveJobState({
    this.status = ActiveJobStatus.initial,
    this.job,
    this.isUpdating = false,
    this.uploadingBefore = false,
    this.uploadingAfter = false,
    this.isCompleting = false,
    this.minutesInProgress = 0,
    this.errorMessage,
    this.message,
    this.completed = false,
  });

  ActiveJobState copyWith({
    ActiveJobStatus? status,
    JobModel? job,
    bool? isUpdating,
    bool? uploadingBefore,
    bool? uploadingAfter,
    bool? isCompleting,
    int? minutesInProgress,
    String? errorMessage,
    bool clearError = false,
    String? message,
    bool clearMessage = false,
    bool? completed,
  }) {
    return ActiveJobState(
      status: status ?? this.status,
      job: job ?? this.job,
      isUpdating: isUpdating ?? this.isUpdating,
      uploadingBefore: uploadingBefore ?? this.uploadingBefore,
      uploadingAfter: uploadingAfter ?? this.uploadingAfter,
      isCompleting: isCompleting ?? this.isCompleting,
      minutesInProgress: minutesInProgress ?? this.minutesInProgress,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      message: clearMessage ? null : (message ?? this.message),
      completed: completed ?? this.completed,
    );
  }

  // ------------------------------------------------------------- getters

  /// The job status without stray spaces (e.g. "accepted " -> "accepted").
  String get jobStatus => (job?.status ?? '').trim();

  /// Index of the current status in [JobStatus.flow]; -1 if not on the flow.
  int get flowIndex => JobStatus.flow.indexOf(jobStatus);

  /// 1-based step shown in "Step X of 5" (0 = not started yet).
  int get currentStep => flowIndex + 1;

  bool get hasBeforePhoto => (job?.beforePhotoUrl ?? '').isNotEmpty;
  bool get hasAfterPhoto => (job?.afterPhotoUrl ?? '').isNotEmpty;
  int get photosCount => (hasBeforePhoto ? 1 : 0) + (hasAfterPhoto ? 1 : 0);


  bool get isEditable => JobStatus.active.contains(jobStatus);

  bool get canComplete =>
      jobStatus == JobStatus.inProgress &&
      photosCount == 2 &&
      !isUpdating &&
      !isCompleting;

  /// Why the "Complete" button is disabled (null when it is enabled).
  String? get completeHint {
    if (jobStatus != JobStatus.inProgress) {
      return 'Set the status to "In Progress" before completing.';
    }
    if (photosCount < 2) {
      return 'Add both Before and After photos ($photosCount of 2).';
    }
    return null;
  }

  @override
  List<Object?> get props => [
        status,
        job,
        isUpdating,
        uploadingBefore,
        uploadingAfter,
        isCompleting,
        minutesInProgress,
        errorMessage,
        message,
        completed,
      ];
}
