import 'package:equatable/equatable.dart';
import 'package:final_depi/features/jobs/job_model.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChatDataEvent extends ChatEvent {
  final String? jobId;
  const LoadChatDataEvent(this.jobId);

  @override
  List<Object?> get props => [jobId];
}

class SendMessageEvent extends ChatEvent {
  final String jobId;
  final String text;
  const SendMessageEvent({required this.jobId, required this.text});

  @override
  List<Object?> get props => [jobId, text];
}

class MarkMessagesReadEvent extends ChatEvent {
  final String jobId;
  const MarkMessagesReadEvent(this.jobId);

  @override
  List<Object?> get props => [jobId];
}

class MessagesUpdatedEvent extends ChatEvent {
  final List<ChatMessage> messages;
  const MessagesUpdatedEvent(this.messages);

  @override
  List<Object?> get props => [messages];
}

class JobUpdatedEvent extends ChatEvent {
  final JobModel? job;
  const JobUpdatedEvent(this.job);

  @override
  List<Object?> get props => [job];
}
