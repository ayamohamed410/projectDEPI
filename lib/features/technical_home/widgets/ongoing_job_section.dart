import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/technical_home/widgets/ongoing_job_card.dart';
import 'package:flutter/material.dart';

class OngoingJobSection extends StatelessWidget {
  const OngoingJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Row(
          children: [
            Icon(Icons.circle, color: ColorsApp.primaryColor, size: 11),
            SizedBox(width: 7),
            Text(
              'ONGOING JOB • DISPATCHED',
              style: TextStyle(
                color: ColorsApp.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Text(
              '#7H-9482',
              style: TextStyle(color: ColorsApp.greyColor, fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 9),
        OngoingJobCard(),
      ],
    );
  }
}
