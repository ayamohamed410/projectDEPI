import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../common/section_card.dart';
import '../common/status_badge.dart';

class BookingReferenceSection extends StatelessWidget {
  const BookingReferenceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'BOOKING REFERENCE',
                  style: TextStyle(
                    fontSize: 9,
                    color: ColorsApp.secondaryText,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const StatusBadge(
                text: 'Completed',
                icon: Icons.check_circle,
                foregroundColor: ColorsApp.accentBlue,
                backgroundColor: ColorsApp.blueColor,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  '#7H-9482',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: ColorsApp.primaryColor,
                  ),
                ),
              ),
              Text(
                'Oct 24, 2024 • 11:25 AM',
                style: TextStyle(fontSize: 9, color: ColorsApp.secondaryText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
