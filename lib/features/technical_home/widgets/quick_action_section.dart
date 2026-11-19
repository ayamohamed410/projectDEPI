import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/technical_home/widgets/quick_action_card.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: ColorsApp.primaryColor,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                title: 'View\nRequests',
                icon: Icons.mark_email_unread_outlined,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: QuickActionCard(
                title: 'Jobs History',
                icon: Icons.pending_actions,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: QuickActionCard(title: 'Update Skills', icon: Icons.tune),
            ),
          ],
        ),
      ],
    );
  }
}
