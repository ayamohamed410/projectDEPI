import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_depi/features/Technician/presentation/bloc/chat/chat_event.dart';
import '../../../../jobs/jobs_repository.dart';
import '../../../../jobs/job_model.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final JobsRepository _jobsRepository;
  StreamSubscription? _jobSubscription;
  StreamSubscription? _messagesSubscription;

  ChatBloc(this._jobsRepository) : super(const ChatState()) {
    on<LoadChatDataEvent>(_onLoadChatData);
    on<SendMessageEvent>(_onSendMessage);
    on<MarkMessagesReadEvent>(_onMarkMessagesRead);
    on<MessagesUpdatedEvent>(_onMessagesUpdated);
    on<JobUpdatedEvent>(_onJobUpdated);
  }

  Future<void> _onLoadChatData(LoadChatDataEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      JobModel? targetJob;
      final id = event.jobId;
      if (id != null && id.isNotEmpty) {
        // A specific job was requested: load exactly that one.
        targetJob = await _jobsRepository.watchJob(id).first;
      } else {
        // Nobody passed a job: fall back to the technician's active job.
        targetJob = await _jobsRepository.getActiveJobForTechnician();
      }

      if (targetJob == null) {
        emit(state.copyWith(
          isLoading: false,
          error: event.jobId != null && event.jobId!.isNotEmpty
              ? 'Job not found: ${event.jobId}'
              : null,
        ));
        return;
      }

      Map<String, dynamic>? customerData;
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(targetJob.customerId)
            .get();
        customerData = userDoc.data();
      } catch (_) {}

      emit(state.copyWith(
        isLoading: false,
        job: targetJob,
        customerData: customerData,
      ));

      _jobSubscription?.cancel();
      _jobSubscription = _jobsRepository.watchJob(targetJob.id).listen(
        (job) => add(JobUpdatedEvent(job)),
        onError: (_) {},
      );

      _messagesSubscription?.cancel();
      _messagesSubscription = _jobsRepository.watchMessages(targetJob.id).listen(
        (messages) => add(MessagesUpdatedEvent(messages)),
        onError: (_) {},
      );

      add(MarkMessagesReadEvent(targetJob.id));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onJobUpdated(JobUpdatedEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(job: event.job));
  }

  void _onMessagesUpdated(MessagesUpdatedEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(messages: event.messages));
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    if (event.text.trim().isEmpty) return;
    emit(state.copyWith(isSending: true));
    try {
      await _jobsRepository.sendMessage(event.jobId, event.text.trim());
      emit(state.copyWith(isSending: false));
    } catch (e) {
      emit(state.copyWith(isSending: false, error: 'Failed to send message: ${e.toString()}'));
    }
  }

  Future<void> _onMarkMessagesRead(MarkMessagesReadEvent event, Emitter<ChatState> emit) async {
    try {
      await _jobsRepository.markMessagesRead(event.jobId);
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _jobSubscription?.cancel();
    _messagesSubscription?.cancel();
    return super.close();
  }
}