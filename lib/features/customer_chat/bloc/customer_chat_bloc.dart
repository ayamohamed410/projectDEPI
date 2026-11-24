import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_depi/features/jobs/jobs_repository.dart';

import 'customer_chat_event.dart';
import 'customer_chat_state.dart';

class CustomerChatBloc extends Bloc<CustomerChatEvent, CustomerChatState> {
  final JobsRepository _repository;

  StreamSubscription? _messagesSubscription;
  String? _jobId;

  CustomerChatBloc(this._repository) : super(const CustomerChatState()) {
    on<LoadCustomerChat>(_onLoadCustomerChat);
    on<CustomerChatMessagesUpdated>(_onMessagesUpdated);
    on<CustomerChatSendMessage>(_onSendMessage);
    on<CustomerChatMarkMessagesRead>(_onMarkMessagesRead);
    on<CustomerChatErrorOccurred>(_onErrorOccurred);
  }

  Future<void> _onLoadCustomerChat(
    LoadCustomerChat event,
    Emitter<CustomerChatState> emit,
  ) async {
    _jobId = event.jobId;

    emit(state.copyWith(isLoading: true, error: null));

    await _messagesSubscription?.cancel();

    try {
      _messagesSubscription = _repository
          .watchMessages(event.jobId)
          .listen(
            (messages) {
              add(CustomerChatMessagesUpdated(messages));
            },
            onError: (error) {
              add(CustomerChatErrorOccurred(error.toString()));
            },
          );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onMessagesUpdated(
    CustomerChatMessagesUpdated event,
    Emitter<CustomerChatState> emit,
  ) {
    emit(
      state.copyWith(isLoading: false, messages: event.messages, error: null),
    );

    add(const CustomerChatMarkMessagesRead());
  }

  Future<void> _onSendMessage(
    CustomerChatSendMessage event,
    Emitter<CustomerChatState> emit,
  ) async {
    final jobId = _jobId;
    final message = event.text.trim();

    if (jobId == null || message.isEmpty) return;

    emit(state.copyWith(isSending: true, error: null));

    try {
      await _repository.sendMessage(jobId, message);

      emit(state.copyWith(isSending: false));
    } catch (e) {
      emit(state.copyWith(isSending: false, error: e.toString()));
    }
  }

  Future<void> _onMarkMessagesRead(
    CustomerChatMarkMessagesRead event,
    Emitter<CustomerChatState> emit,
  ) async {
    final jobId = _jobId;
    if (jobId == null) return;

    try {
      await _repository.markMessagesRead(jobId);
    } catch (e) {
      add(CustomerChatErrorOccurred(e.toString()));
    }
  }

  void _onErrorOccurred(
    CustomerChatErrorOccurred event,
    Emitter<CustomerChatState> emit,
  ) {
    emit(
      state.copyWith(isLoading: false, isSending: false, error: event.message),
    );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
