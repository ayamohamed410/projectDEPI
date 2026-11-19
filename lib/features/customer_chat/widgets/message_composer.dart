import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageComposer extends StatelessWidget {
  const MessageComposer({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onPickImage,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final ValueChanged<ImageSource> onPickImage;

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  onPickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  onPickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsApp.whiteColor,
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _QuickReply(
                  text: 'I am waiting downstairs',
                  onTap: () {
                    controller.text = 'I am waiting downstairs';
                    controller.selection = TextSelection.collapsed(
                      offset: controller.text.length,
                    );
                  },
                ),
                const SizedBox(width: 8),
                _QuickReply(
                  text: 'Please call when outside',
                  onTap: () {
                    controller.text = 'Please call when outside';
                    controller.selection = TextSelection.collapsed(
                      offset: controller.text.length,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: ColorsApp.whiteColor,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: const Color(0xFFF0F1F5)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => _showAttachmentOptions(context),
                        tooltip: 'Attach image',
                        icon: const Icon(Icons.attach_file),
                      ),
                      IconButton(
                        onPressed: () => onPickImage(ImageSource.camera),
                        tooltip: 'Take a photo',
                        icon: const Icon(Icons.camera_alt_outlined),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => onSend(),
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(
                              color: Color(0xFF858994),
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: onSend,
                  style: IconButton.styleFrom(
                    backgroundColor: ColorsApp.primaryColor,
                    foregroundColor: ColorsApp.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.send, size: 23),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickReply extends StatelessWidget {
  const _QuickReply({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsApp.blueColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Text(
            text,
            style: const TextStyle(
              color: ColorsApp.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
