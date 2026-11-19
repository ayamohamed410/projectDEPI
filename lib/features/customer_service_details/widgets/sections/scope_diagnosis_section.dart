import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../common/info_tag.dart';
import '../common/section_card.dart';
import '../common/section_heading.dart';

class ScopeDiagnosisSection extends StatelessWidget {
  const ScopeDiagnosisSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            icon: Icons.build_outlined,
            title: 'SCOPE & DIAGNOSIS',
          ),
          const SizedBox(height: 9),
          const Text(
            'Kitchen Sink High Pressure Pipe Leak',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ColorsApp.primaryColor,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Replaced deteriorated brass compression valve and '
            'applied high-grade Teflon sealing tape across the '
            'cold water intake line. Tested under 4.2 bar water '
            'pressure with zero seepage.',
            style: TextStyle(
              fontSize: 10,
              height: 1.5,
              color: ColorsApp.secondaryText,
            ),
          ),
          const SizedBox(height: 10),
          const Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              InfoTag(label: 'Plumbing & Pipes'),
              InfoTag(label: 'Kitchen Fixtures'),
              InfoTag(label: 'Teflon Seal Grade-A'),
            ],
          ),
        ],
      ),
    );
  }
}
