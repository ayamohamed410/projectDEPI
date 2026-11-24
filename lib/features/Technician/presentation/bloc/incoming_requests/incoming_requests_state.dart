
part of 'incoming_requests_bloc.dart';

enum IncomingRequestsStatus {
  initial,
  loading,
  loaded,
  empty,
  error,
}

class IncomingRequestsState extends Equatable {
  final IncomingRequestsStatus status;
  final List<JobModel> requests;
  final String? errorMessage;

  const IncomingRequestsState({
    this.status = IncomingRequestsStatus.initial,
    this.requests = const [],//القائمة اللي هنحط فيها الطلبات اللى جايه من الفايربيز
    this.errorMessage,
  });

  IncomingRequestsState copyWith({// copyWith: بستخدمها علسان اغير حالة معينة واكون محتفظه بباقي البيانات
    IncomingRequestsStatus? status,
    List<JobModel>? requests,
    String? errorMessage,
    bool clearError = false,
  }) {
    return IncomingRequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      errorMessage: clearError
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        requests,
        errorMessage,
      ];
}
