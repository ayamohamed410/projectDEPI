import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ReviewHighlight {
  const ReviewHighlight(this.title, this.icon);

  final String title;
  final IconData icon;
}

class HighlightsSection extends StatelessWidget {
  const HighlightsSection({
    super.key,
    required this.highlights,
    required this.selectedHighlights,
    required this.onToggle,
  });

  final List<ReviewHighlight> highlights;
  final Set<String> selectedHighlights;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(
              child: Text(
                'What stood out the most?',
                style: TextStyle(
                  color: ColorsApp.primaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              'Tap to toggle',
              style: TextStyle(color: ColorsApp.greyColor, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: highlights.map((highlight) {
            final selected = selectedHighlights.contains(highlight.title);

            return InkWell(
              onTap: () => onToggle(highlight.title),
              borderRadius: BorderRadius.circular(24),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? ColorsApp.primaryColor
                      : ColorsApp.blueColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      highlight.icon,
                      size: 16,
                      color: selected
                          ? ColorsApp.whiteColor
                          : ColorsApp.greyColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      highlight.title,
                      style: TextStyle(
                        color: selected
                            ? ColorsApp.whiteColor
                            : ColorsApp.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
