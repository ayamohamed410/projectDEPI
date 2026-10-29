import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FeedbackSection extends StatelessWidget {
  const FeedbackSection({
    super.key,
    required this.controller,
    required this.maxCharacters,
  });

  final TextEditingController controller;
  final int maxCharacters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Written Feedback',
                style: TextStyle(
                  color: ColorsApp.primaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                return Text(
                  '${value.text.length}/$maxCharacters characters',
                  style: const TextStyle(
                    color: ColorsApp.greyColor,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: ColorsApp.whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: controller,
            maxLength: maxCharacters,
            maxLines: 5,
            minLines: 4,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'Tell us about your experience...',
              hintStyle: TextStyle(color: ColorsApp.greyColor, fontSize: 14),
              contentPadding: EdgeInsets.all(14),
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }
}
