import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../common/section_card.dart';
import '../common/section_heading.dart';

class JobVisualEvidenceSection extends StatelessWidget {
  const JobVisualEvidenceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        children: [
          const SectionHeading(
            icon: Icons.photo_library_outlined,
            title: 'Job Visual Evidence',
            trailing: Text(
              'Verified by Technician',
              style: TextStyle(fontSize: 9, color: ColorsApp.primaryColor),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: EvidencePlaceholder(label: 'Before')),
              SizedBox(width: 8),
              Expanded(child: EvidencePlaceholder(label: 'After')),
            ],
          ),
          const SizedBox(height: 7),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Before repair',
                  style: TextStyle(fontSize: 9, color: ColorsApp.secondaryText),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'After repair',
                  style: TextStyle(fontSize: 9, color: ColorsApp.secondaryText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EvidencePlaceholder extends StatelessWidget {
  const EvidencePlaceholder({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final isAfter = label == 'After';

    return AspectRatio(
      aspectRatio: 1.35,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsApp.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorsApp.borderColor),
        ),
        child: Stack(
          children: [
            const Center(
              child: Icon(
                Icons.add_photo_alternate_outlined,
                size: 27,
                color: ColorsApp.greyColor,
              ),
            ),
            Positioned(
              top: 6,
              left: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(
                  color: isAfter
                      ? ColorsApp.accentBlue
                      : ColorsApp.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 9,
                    color: ColorsApp.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
