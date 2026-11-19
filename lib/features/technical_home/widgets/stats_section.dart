import 'package:final_depi/features/technical_home/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: const [
        StatCard(
          title: 'Completed Today',
          value: '3 Jobs',
          subtitle: '100% on-time arrival',
          icon: Icons.check_circle_outline,
          iconColor: Color(0xFF0052CC),
        ),
        StatCard(
          title: 'In Progress',
          value: '1 Active',
          subtitle: '● Dispatched',
          icon: Icons.timelapse,
          iconColor: Color(0xFF0052CC),
          subtitleColor: Color(0xFF0052CC),
        ),
        StatCard(
          title: 'Rating Score',
          value: '4.9 ⭐',
          subtitle: '184 reviews',
          icon: Icons.star_border,
          iconColor: Color(0xFFCE8500),
        ),
      ],
    );
  }
}
