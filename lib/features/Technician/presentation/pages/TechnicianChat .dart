
import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:final_depi/features/Technician/presentation/bloc/chat/chat_bloc.dart';
import 'package:final_depi/features/Technician/presentation/bloc/chat/chat_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:url_launcher/url_launcher.dart';

import '/core/theme/app_styles.dart';
import '../../../jobs/job_model.dart';
import '../../../jobs/jobs_repository.dart';
import '../../dev/seed_chat.dart';
import '../widgets/container.dart';

class TechnicianChat extends StatelessWidget {
  final String? jobId;
  const TechnicianChat({super.key, this.jobId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatBloc(JobsRepository())..add(LoadChatDataEvent(jobId)),
      child: _TechnicianChatView(jobId: jobId),
    );
  }
}

class _TechnicianChatView extends StatefulWidget {
  final String? jobId;
  const _TechnicianChatView({this.jobId});

  @override
  State<_TechnicianChatView> createState() => _TechnicianChatViewState();
}

class _TechnicianChatViewState extends State<_TechnicianChatView> {
  static const String _imgTag = '[img]';
  static const String _fileTag = '[file]';

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;
  bool _isUploading = false;

  @override
  void dispose() {
    _speech.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showSnack(String message, {Color? color}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  // ===================== الكاميرا / المعرض (بنفس أسلوب Active Job) =====================

  Future<void> _pickChatPhoto(String jobId) async {
    if (_isUploading) return;

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Take a photo'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    try {
      if (!mounted) return;
      setState(() => _isUploading = true);

      final XFile? file = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        imageQuality: 60,
      );
      if (file == null) return;

      final Uint8List bytes = await file.readAsBytes();
      if (bytes.isEmpty) {
        throw Exception('Empty image bytes');
      }

      if (!mounted) return;
      final String encoded = base64Encode(bytes);
      context.read<ChatBloc>().add(
            SendMessageEvent(
              jobId: jobId,
              text: '$_imgTag$encoded',
            ),
          );
      _scrollToBottom();
    } catch (e) {
      _showSnack('Could not pick the photo: $e', color: Colors.red);
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  // ===================== إرفاق الملفات (بنفس أسلوب قراءة bytes الآمن) =====================

  Future<void> _pickChatFile(String jobId) async {
    if (_isUploading) return;

    try {
      if (!mounted) return;
      setState(() => _isUploading = true);

      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;

      final PlatformFile pickedFile = result.files.first;
      final Uint8List? bytes = pickedFile.bytes;
      if (bytes == null || bytes.isEmpty) {
        throw Exception('File bytes are unavailable');
      }

      if (!mounted) return;
      final String encoded = base64Encode(bytes);
      final String safeName = pickedFile.name.replaceAll('|', '_');

      context.read<ChatBloc>().add(
            SendMessageEvent(
              jobId: jobId,
              text: '$_fileTag$safeName|$encoded',
            ),
          );
      _scrollToBottom();
    } catch (e) {
      _showSnack('Could not pick the file: $e', color: Colors.red);
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  // ===================== تحويل الصوت لنص =====================

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _speech.stop();
      if (mounted) setState(() => _isListening = false);
      return;
    }

    try {
      final available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            if (mounted) setState(() => _isListening = false);
          }
        },
        onError: (_) {
          if (mounted) setState(() => _isListening = false);
        },
      );

      if (!available) {
        _showSnack('Speech recognition is not available');
        return;
      }

      setState(() => _isListening = true);
      await _speech.listen(
        onResult: (result) {
          if (!mounted) return;
          setState(() {
            _messageController.text = result.recognizedWords;
            _messageController.selection = TextSelection.fromPosition(
              TextPosition(offset: _messageController.text.length),
            );
          });
        },
      );
    } catch (e) {
      if (mounted) setState(() => _isListening = false);
      _showSnack('Microphone error: $e', color: Colors.red);
    }
  }

  // ===================== الاتصال وتفاصيل الأوردر =====================

  void _showCallDialog(String? phone) {
    final p = phone ?? '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Customer Phone'),
        content: Text(p.isNotEmpty ? p : 'No phone number available'),
        actions: [
          if (p.isNotEmpty) ...[
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: p));
                Navigator.pop(ctx);
                _showSnack('Phone number copied to clipboard');
              },
              child: const Text('Copy'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(ctx);
                var ok = false;
                try {
                  ok = await launchUrl(Uri(scheme: 'tel', path: p));
                } catch (_) {}
                if (!ok && mounted) {
                  _showSnack('Cannot open the dialer on this device');
                }
              },
              child: const Text('Call'),
            ),
          ],
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showJobDetails(JobModel job) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.requestNumber,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              job.diagnosisTitle,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            if (job.problemDescription.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(job.problemDescription),
            ],
            const SizedBox(height: 12),
            Text('Status: ${job.status.replaceAll('_', ' ')}'),
            if (job.customerArea.isNotEmpty) Text('Location: ${job.customerArea}'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ===================== عرض محتوى الرسالة =====================

  Widget _buildMessageContent(dynamic msg, bool isMe) {
    final String rawText = (msg.text ?? '').toString();
    final Color textColor = isMe ? Colors.white : Colors.black87;

    if (rawText.startsWith(_imgTag)) {
      final payload = rawText.replaceFirst(_imgTag, '').trim();
      final isUrl =
          payload.startsWith('http://') || payload.startsWith('https://');

      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: isUrl
            ? Image.network(
                payload,
                height: 160,
                width: 230,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Text(
                  'Failed to load image',
                  style: TextStyle(color: isMe ? Colors.redAccent : Colors.red),
                ),
              )
            : Image.memory(
                base64Decode(payload),
                height: 160,
                width: 230,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Text(
                  'Failed to load image',
                  style: TextStyle(color: isMe ? Colors.redAccent : Colors.red),
                ),
              ),
      );
    }

    if (rawText.startsWith(_fileTag)) {
      final payload = rawText.replaceFirst(_fileTag, '');
      final sepIndex = payload.indexOf('|');
      final fileName =
          sepIndex != -1 ? payload.substring(0, sepIndex) : 'Attached File';
      final encodedData =
          sepIndex != -1 ? payload.substring(sepIndex + 1) : '';

      return InkWell(
        onTap: () {
          if (encodedData.isEmpty) {
            _showSnack('File data unavailable');
            return;
          }
          try {
            final Uint8List fileBytes = base64Decode(encodedData);
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(fileName),
                content: Text('File size: ${fileBytes.length} bytes'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } catch (_) {
            _showSnack('Could not read attached file');
          }
        },
        child: Container(
          width: 230,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMe ? Colors.white12 : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.insert_drive_file,
                color: isMe ? Colors.white : Colors.blue,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  fileName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (msg.imageUrl != null && msg.imageUrl!.toString().isNotEmpty) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              msg.imageUrl!.toString(),
              height: 150,
              width: 250,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Text(
                'Failed to load image',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          width: 230,
          child: Text(
            rawText,
            style: TextStyle(color: textColor, fontSize: 14),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state.error != null) {
          _showSnack(state.error!, color: Colors.red);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              title: const Text(
                'Technician Chat',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.job == null) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              title: GestureDetector(
                onLongPress: kDebugMode
                    ? () async {
                        await SeedChat.seed();
                        if (context.mounted) {
                          context
                              .read<ChatBloc>()
                              .add(const LoadChatDataEvent(null));
                          _showSnack('Chat Seed Data Loaded Successfully!');
                        }
                      }
                    : null,
                child: const Text(
                  'Technician Chat',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No active job to chat about',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Long press on the "Technician Chat" title above to seed test data (Debug Mode).',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context
                          .read<ChatBloc>()
                          .add(LoadChatDataEvent(widget.jobId)),
                      child: const Text('Retry / Refresh'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final job = state.job!;
        final customerName = state.customerData?['name'] ?? job.customerName;
        final customerPhone = job.customerPhone.isNotEmpty
            ? job.customerPhone
            : state.customerData?['phone'] as String?;
        final currentUid = FirebaseAuth.instance.currentUser?.uid;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 20,
              ),
            ),
            title: GestureDetector(
              onLongPress: kDebugMode
                  ? () async {
                      await SeedChat.seed();
                      if (context.mounted) {
                        context
                            .read<ChatBloc>()
                            .add(LoadChatDataEvent(job.id));
                        _showSnack('Chat Seed Data Loaded Successfully!');
                      }
                    }
                  : null,
              child: const Text(
                'Technician Chat',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              if (_isUploading) const LinearProgressIndicator(minHeight: 2),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      buildCustomContainer(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.person, size: 50),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              customerName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            buildCustomContainer(
                                              cardColor: AppColors.iconbluebg,
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.verified,
                                                    size: 12,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Client',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${job.customerArea} • Active Job',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.blue.shade50,
                                  radius: 22,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.phone_outlined,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                    onPressed: () =>
                                        _showCallDialog(customerPhone),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            buildCustomContainer(
                              cardColor: AppColors.bluenewcontainer,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildCustomContainer(
                                    cardColor: AppColors.iconbluebg,
                                    child: const Icon(
                                      Icons.handyman,
                                      size: 30,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              job.requestNumber,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              job.status
                                                  .replaceAll('_', ' ')
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          job.diagnosisTitle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () => _showJobDetails(job),
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                    ),
                                    child: const Text(
                                      'Job Details →',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildCustomContainer(
                        cardColor: AppColors.bluenewcontainer,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.shield_outlined,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Official 7elhaly chat channel. Retain all service updates here for warranty validation & job documentation.',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      state.messages.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 32.0),
                              child: Text(
                                'No messages yet, say hello',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.messages.length,
                              itemBuilder: (context, index) {
                                final msg = state.messages[index];
                                final isMe = msg.senderId == currentUid;
                                final timeStr = intl.DateFormat('h:mm a')
                                    .format(msg.createdAt);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Align(
                                    alignment: isMe
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (!isMe) ...[
                                          const Icon(Icons.person, size: 32),
                                          const SizedBox(width: 6),
                                        ],
                                        Flexible(
                                          child: buildCustomContainer(
                                            cardColor: isMe
                                                ? Colors.black
                                                : Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _buildMessageContent(msg, isMe),
                                                const SizedBox(height: 4),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      timeStr,
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    if (isMe) ...[
                                                      const SizedBox(width: 4),
                                                      Icon(
                                                        Icons.done_all,
                                                        color: msg.readAt != null
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Row(
                                children: [
                                  Icon(
                                    Icons.flash_on,
                                    size: 16,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'QUICK STATUS UPDATES',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Tap to send',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ActionChip(
                                  avatar: const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.blue,
                                  ),
                                  label: const Text(
                                    'I have arrived at the building',
                                  ),
                                  backgroundColor: AppColors.bluenewcontainer,
                                  onPressed: () {
                                    context.read<ChatBloc>().add(
                                          SendMessageEvent(
                                            jobId: job.id,
                                            text:
                                                'I have arrived at the building',
                                          ),
                                        );
                                  },
                                ),
                                const SizedBox(width: 8),
                                ActionChip(
                                  avatar: const Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: Colors.blue,
                                  ),
                                  label: const Text('Work completed'),
                                  backgroundColor: AppColors.bluenewcontainer,
                                  onPressed: () {
                                    context.read<ChatBloc>().add(
                                          SendMessageEvent(
                                            jobId: job.id,
                                            text: 'Work completed',
                                          ),
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              buildCustomContainer(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: _isUploading
                          ? null
                          : () => _pickChatPhoto(job.id),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.insert_drive_file_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: _isUploading
                          ? null
                          : () => _pickChatFile(job.id),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Reply to $customerName',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColors.bluenewcontainer,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isListening ? Icons.mic : Icons.mic_none,
                              color: _isListening ? Colors.red : Colors.grey,
                            ),
                            onPressed: _toggleListening,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 22,
                      child: IconButton(
                        icon: state.isSending
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 18,
                              ),
                        onPressed: state.isSending
                            ? null
                            : () {
                                final text = _messageController.text.trim();
                                if (text.isNotEmpty) {
                                  context.read<ChatBloc>().add(
                                        SendMessageEvent(
                                          jobId: job.id,
                                          text: text,
                                        ),
                                      );
                                  _messageController.clear();
                                  _scrollToBottom();
                                }
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
