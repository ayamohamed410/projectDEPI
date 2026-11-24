import 'package:equatable/equatable.dart';
import 'package:final_depi/features/jobs/job_model.dart';

class CustomerChatState extends Equatable {
  final bool isLoading;
  final List<ChatMessage> messages;
  final bool isSending;
  final String? error;

  const CustomerChatState({
    this.isLoading = true,
    this.messages = const [],
    this.isSending = false,
    this.error,
  });

  CustomerChatState copyWith({
    bool? isLoading,
    List<ChatMessage>? messages,
    bool? isSending,
    String? error,
  }) {
    return CustomerChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, messages, isSending, error];
}
