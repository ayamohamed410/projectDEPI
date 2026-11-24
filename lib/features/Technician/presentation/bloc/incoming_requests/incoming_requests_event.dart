part of 'incoming_requests_bloc.dart';

abstract class IncomingRequestsEvent extends Equatable {
  const IncomingRequestsEvent();

  @override
  List<Object?> get props => [];
}

class LoadIncomingRequests extends IncomingRequestsEvent {
  const LoadIncomingRequests();
}

class IncomingRequestsUpdated extends IncomingRequestsEvent {
  final List<JobModel> requests;

  const IncomingRequestsUpdated(this.requests);

  @override
  List<Object?> get props => [requests];
}

class RetryIncomingRequests extends IncomingRequestsEvent {
  const RetryIncomingRequests();
}

class IncomingRequestsFailed extends IncomingRequestsEvent {
  final String message;

  const IncomingRequestsFailed(this.message);

  @override
  List<Object?> get props => [message];
}
