import 'package:equatable/equatable.dart';
import 'package:final_depi/features/jobs/job_model.dart';

abstract class CustomerChatEvent extends Equatable {
  const CustomerChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadCustomerChat extends CustomerChatEvent {
  final String jobId;

  const LoadCustomerChat(this.jobId);

  @override
  List<Object?> get props => [jobId];
}

class CustomerChatMessagesUpdated extends CustomerChatEvent {
  final List<ChatMessage> messages;

  const CustomerChatMessagesUpdated(this.messages);

  @override
  List<Object?> get props => [messages];
}

class CustomerChatSendMessage extends CustomerChatEvent {
  final String text;

  const CustomerChatSendMessage(this.text);

  @override
  List<Object?> get props => [text];
}

class CustomerChatMarkMessagesRead extends CustomerChatEvent {
  const CustomerChatMarkMessagesRead();
}

class CustomerChatErrorOccurred extends CustomerChatEvent {
  final String message;

  const CustomerChatErrorOccurred(this.message);

  @override
  List<Object?> get props => [message];
}
