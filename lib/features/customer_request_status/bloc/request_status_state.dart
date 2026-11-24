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

// Deleting the current request.
class RequestStatusDeleting extends RequestStatusState {
  const RequestStatusDeleting();
}

// Request deleted successfully.
class RequestStatusDeleteSuccess extends RequestStatusState {
  const RequestStatusDeleteSuccess();
}

// Something went wrong.
class RequestStatusError extends RequestStatusState {
  final String message;

  const RequestStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
