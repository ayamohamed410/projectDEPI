import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_chat/model/chat_message_model.dart';
import 'package:final_depi/features/customer_chat/widgets/chat_header.dart';
import 'package:final_depi/features/customer_chat/widgets/customer_chat_message.dart';
import 'package:final_depi/features/customer_chat/widgets/message_composer.dart';
import 'package:final_depi/features/customer_chat/widgets/protected_communication.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_depi/features/customer_chat/bloc/customer_chat_bloc.dart';
import 'package:final_depi/features/customer_chat/bloc/customer_chat_event.dart';
import 'package:final_depi/features/jobs/jobs_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_depi/features/customer_chat/bloc/customer_chat_state.dart';
import 'package:final_depi/features/jobs/job_model.dart';

class CustomerChatScreen extends StatefulWidget {
  const CustomerChatScreen({super.key, this.onBack, this.jobId});

  final VoidCallback? onBack;
  final String? jobId;

  @override
  State<CustomerChatScreen> createState() => _CustomerChatScreenState();
}

class _CustomerChatScreenState extends State<CustomerChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  late final Stream<List<JobModel>> _customerJobsStream = JobsRepository()
      .watchCustomerJobs();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    context.read<CustomerChatBloc>().add(CustomerChatSendMessage(text));

    _messageController.clear();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (image == null || !mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image selected. Upload feature is coming next.'),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to select the image. Try again.')),
      );
    }
  }

  String _formatMessageTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final jobId = widget.jobId;

    // If a specific job ID was passed, open its chat directly.
    if (jobId != null && jobId.isNotEmpty) {
      return _buildChatForJob(jobId);
    }

    // Otherwise, find the customer's latest maintenance request.
    return StreamBuilder<List<JobModel>>(
      stream: _customerJobsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: ColorsApp.background,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: ColorsApp.background,
            body: Center(
              child: Text('Something went wrong: ${snapshot.error}'),
            ),
          );
        }

        final jobs = snapshot.data ?? [];

        if (jobs.isEmpty) {
          return Scaffold(
            backgroundColor: ColorsApp.background,
            body: SafeArea(
              child: Column(
                children: [
                  ChatHeader(onBack: widget.onBack),
                  const Expanded(
                    child: Center(
                      child: Text('You have no conversations yet.'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Jobs are already sorted from newest to oldest.
        return _buildChatForJob(jobs.first.id);
      },
    );
  }

  Widget _buildChatForJob(String jobId) {
    return BlocProvider(
      create: (_) =>
          CustomerChatBloc(JobsRepository())..add(LoadCustomerChat(jobId)),
      child: Scaffold(
        backgroundColor: ColorsApp.background,
        body: SafeArea(
          child: Column(
            children: [
              ChatHeader(onBack: widget.onBack, jobId: jobId),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  children: [
                    const ProtectedCommunication(),
                    const SizedBox(height: 20),
                    // _DateDivider(date: DateTime.now()),
                    // const SizedBox(height: 20),
                    BlocBuilder<CustomerChatBloc, CustomerChatState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state.error != null) {
                          return Center(child: Text(state.error!));
                        }

                        final currentUserId =
                            FirebaseAuth.instance.currentUser?.uid;

                        final textMessages = state.messages
                            .where((message) => message.text.trim().isNotEmpty)
                            .toList();

                        return Column(
                          children: [
                            for (
                              var index = 0;
                              index < textMessages.length;
                              index++
                            ) ...[
                              if (index == 0 ||
                                  textMessages[index].createdAt.year !=
                                      textMessages[index - 1].createdAt.year ||
                                  textMessages[index].createdAt.month !=
                                      textMessages[index - 1].createdAt.month ||
                                  textMessages[index].createdAt.day !=
                                      textMessages[index - 1]
                                          .createdAt
                                          .day) ...[
                                _DateDivider(
                                  date: textMessages[index].createdAt,
                                ),
                                const SizedBox(height: 20),
                              ],

                              CustomerChatMessage(
                                key: ValueKey(textMessages[index].id),
                                message: ChatMessageModel(
                                  text: textMessages[index].text,
                                  isSentByMe:
                                      textMessages[index].senderId ==
                                      currentUserId,
                                  time: _formatMessageTime(
                                    textMessages[index].createdAt,
                                  ),
                                  status: textMessages[index].readAt != null
                                      ? 'Read'
                                      : null,
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              MessageComposer(
                controller: _messageController,
                onSend: _sendMessage,
                onPickImage: _pickImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateDivider extends StatelessWidget {
  const _DateDivider({required this.date});

  final DateTime date;

  String _formatDate() {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (messageDate == today) {
      return 'Today';
    }

    if (messageDate == yesterday) {
      return 'Yesterday';
    }

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFE4EDFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          _formatDate(),
          style: const TextStyle(fontSize: 12, color: Color(0xFF414B5A)),
        ),
      ),
    );
  }
}
