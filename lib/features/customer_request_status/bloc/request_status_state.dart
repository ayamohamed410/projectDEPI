import 'package:equatable/equatable.dart';
import 'package:final_depi/features/jobs/job_model.dart';

abstract class RequestStatusState extends Equatable {
  const RequestStatusState();

  @override
  List<Object?> get props => [];
}

// Initial state.
class RequestStatusInitial extends RequestStatusState {
  const RequestStatusInitial();
}

// Loading the customer's latest request.
class RequestStatusLoading extends RequestStatusState {
  const RequestStatusLoading();
}

// A request exists.
class RequestStatusLoaded extends RequestStatusState {
  final JobModel job;

  const RequestStatusLoaded(this.job);

  @override
  List<Object?> get props => [job];
}

// The customer has no requests.
class RequestStatusEmpty extends RequestStatusState {
  const RequestStatusEmpty();
}

// Cancelling the current request.
class RequestStatusCancelling extends RequestStatusState {
  const RequestStatusCancelling();
}

// Request cancelled successfully.
class RequestStatusCancelSuccess extends RequestStatusState {
  const RequestStatusCancelSuccess();
}

// Something went wrong.
class RequestStatusError extends RequestStatusState {
  final String message;

  const RequestStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
