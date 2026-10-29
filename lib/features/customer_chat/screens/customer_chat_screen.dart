import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_chat/model/chat_message_model.dart';
import 'package:final_depi/features/customer_chat/widgets/chat_header.dart';
import 'package:final_depi/features/customer_chat/widgets/chat_message.dart';
import 'package:final_depi/features/customer_chat/widgets/message_composer.dart';
import 'package:final_depi/features/customer_chat/widgets/protected_communication.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomerChatScreen extends StatefulWidget {
  const CustomerChatScreen({super.key});

  @override
  State<CustomerChatScreen> createState() => _CustomerChatScreenState();
}

class _CustomerChatScreenState extends State<CustomerChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  final List<ChatMessageModel> _messages = [
    const ChatMessageModel(
      text:
          'Hello Mr. Tarek, I have accepted your request and I am en route with the replacement compression valves.',
      isSentByMe: false,
      time: '10:34 AM',
      status: 'Delivered',
    ),
    const ChatMessageModel(
      text:
          'Thanks Mahmoud! Please note the building elevator is on the right side of the main lobby.',
      isSentByMe: true,
      time: '10:36 AM',
    ),
    const ChatMessageModel(
      text: 'I have the standard brass joints ready. Arriving in ~15 minutes.',
      isSentByMe: false,
      time: '10:41 AM',
      status: 'Delivered',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessageModel(text: text, isSentByMe: true, time: _currentTime()),
      );
    });

    _messageController.clear();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (image == null || !mounted) return;

      setState(() {
        _messages.add(
          ChatMessageModel(
            imagePath: image.path,
            isSentByMe: true,
            time: _currentTime(),
          ),
        );
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to select the image. Try again.')),
      );
    }
  }

  String _currentTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.background,
      body: SafeArea(
        child: Column(
          children: [
            const ChatHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                children: [
                  const ProtectedCommunication(),
                  const SizedBox(height: 20),
                  const _DateDivider(),
                  const SizedBox(height: 20),
                  for (final message in _messages)
                    ChatMessage(key: ObjectKey(message), message: message),
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
    );
  }
}

class _DateDivider extends StatelessWidget {
  const _DateDivider();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFE4EDFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Today, October 24',
          style: TextStyle(fontSize: 12, color: Color(0xFF414B5A)),
        ),
      ),
    );
  }
}
