part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final bool isLoading;
  final JobModel? job;
  final Map<String, dynamic>? customerData;
  final List<ChatMessage> messages;
  final bool isSending;
  final String? error;

  const ChatState({
    this.isLoading = true,
    this.job,
    this.customerData,
    this.messages = const [],
    this.isSending = false,
    this.error,
  });

  ChatState copyWith({
    bool? isLoading,
    JobModel? job,
    Map<String, dynamic>? customerData,
    List<ChatMessage>? messages, // أضفنا ? هنا
    bool? isSending,
    String? error,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      job: job ?? this.job,
      customerData: customerData ?? this.customerData,
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, job, customerData, messages, isSending, error];
}