import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../common/section_card.dart';
import '../common/status_badge.dart';

class TechnicianSection extends StatelessWidget {
  const TechnicianSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: ColorsApp.blueColor,
            child: Icon(Icons.person, color: ColorsApp.primaryColor, size: 25),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mahmoud El-Sayed',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ColorsApp.primaryColor,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Master Plumber • 7.1 yearly Certified',
                  style: TextStyle(fontSize: 9, color: ColorsApp.secondaryText),
                ),
                SizedBox(height: 5),
                StatusBadge(
                  text: 'Elite Concierge Pro',
                  icon: Icons.workspace_premium,
                  foregroundColor: ColorsApp.primaryColor,
                  backgroundColor: ColorsApp.blueColor,
                ),
              ],
            ),
          ),
          // const SizedBox(width: 6),
          // CircleAvatar(
          //   radius: 16,
          //   backgroundColor: ColorsApp.blueColor,
          //   child: Icon(
          //     Icons.phone_in_talk_outlined,
          //     color: ColorsApp.accentBlue,
          //     size: 17,
          //   ),
          // ),
        ],
      ),
    );
  }
}
