/*

import 'parse_utils.dart';

/// One document of `jobs/{jobId}/messages`.
class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime? readAt;

  const ChatMessage({
    required this.id,
    required this.senderId,
    this.text = '',
    this.imageUrl,
    required this.createdAt,
    this.readAt,
  });

  factory ChatMessage.fromMap(String id, Map<String, dynamic> m) => ChatMessage(
        id: id,
        senderId: asString(m['senderId']),
        text: asString(m['text']),
        imageUrl: m['imageUrl'] as String?,
        // A just-sent message has no server timestamp yet; show it as "now".
        createdAt: asDate(m['createdAt']) ?? DateTime.now(),
        readAt: asDate(m['readAt']),
      );
}*/