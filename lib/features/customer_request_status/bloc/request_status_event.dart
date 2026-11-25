import 'package:equatable/equatable.dart';
import 'package:final_depi/features/jobs/job_model.dart';

abstract class RequestStatusEvent extends Equatable {
  const RequestStatusEvent();

  @override
  List<Object?> get props => [];
}

// Load the latest maintenance request.
class LoadLatestRequest extends RequestStatusEvent {
  const LoadLatestRequest();
}

// Load a specific maintenance request by its ID.
class LoadRequestById extends RequestStatusEvent {
  final String jobId;

  const LoadRequestById(this.jobId);

  @override
  List<Object?> get props => [jobId];
}

// Receive real-time updates from Firestore.
class LatestRequestUpdated extends RequestStatusEvent {
  final JobModel? job;

  const LatestRequestUpdated(this.job);

  @override
  List<Object?> get props => [job];
}

// Receive real-time updates for a specific request.
class RequestByIdUpdated extends RequestStatusEvent {
  final JobModel? job;

  const RequestByIdUpdated(this.job);

  @override
  List<Object?> get props => [job];
}

// Delete the current maintenance request.
class CancelRequest extends RequestStatusEvent {
  const CancelRequest();
}

class RequestStatusLoadFailed extends RequestStatusEvent {
  final String message;

  const RequestStatusLoadFailed(this.message);

  @override
  List<Object?> get props => [message];
}
