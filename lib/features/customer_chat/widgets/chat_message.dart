import 'dart:io';

import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_chat/model/chat_message_model.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.message});

  final ChatMessageModel message;

  @override
  Widget build(BuildContext context) {
    final isSentByMe = message.isSentByMe;

    return Column(
      crossAxisAlignment: isSentByMe
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Align(
          alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.75,
            ),
            margin: EdgeInsets.only(
              left: isSentByMe ? 35 : 0,
              right: isSentByMe ? 0 : 35,
              bottom: 5,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSentByMe ? ColorsApp.primaryColor : ColorsApp.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(17),
                topRight: const Radius.circular(17),
                bottomLeft: Radius.circular(isSentByMe ? 17 : 5),
                bottomRight: Radius.circular(isSentByMe ? 5 : 17),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.hasImage)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(message.imagePath!),
                      width: 250,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          width: 250,
                          height: 100,
                          child: Center(
                            child: Icon(Icons.broken_image_outlined, size: 35),
                          ),
                        );
                      },
                    ),
                  ),
                if (message.text != null) ...[
                  if (message.hasImage) const SizedBox(height: 8),
                  Text(
                    message.text!,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: isSentByMe
                          ? ColorsApp.whiteColor
                          : ColorsApp.primaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: isSentByMe ? 0 : 5,
            right: isSentByMe ? 2 : 0,
            bottom: 18,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.time,
                style: const TextStyle(
                  fontSize: 11,
                  color: ColorsApp.greyColor,
                ),
              ),
              if (message.status != null) ...[
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4EDFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    message.status!,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF505765),
                    ),
                  ),
                ),
              ],
              if (isSentByMe) ...[
                const SizedBox(width: 4),
                const Icon(Icons.done_all, color: Color(0xFF2878FF), size: 16),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
