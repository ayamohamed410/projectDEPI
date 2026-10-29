class ChatMessageModel {
  const ChatMessageModel({
    this.text,
    this.imagePath,
    required this.isSentByMe,
    required this.time,
    this.status,
  }) : assert(
         text != null || imagePath != null,
         'A message must contain text or an image.',
       );

  final String? text;
  final String? imagePath;
  final bool isSentByMe;
  final String time;
  final String? status;

  bool get hasImage => imagePath != null;
}
