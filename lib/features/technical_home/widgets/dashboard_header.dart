import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/technical_home/widgets/profile_header.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 15),
        Row(
          children: [
            Icon(Icons.circle, color: Color(0xFF0052CC), size: 14),
            SizedBox(width: 7),
            Text(
              'Technician Home',
              style: TextStyle(
                color: ColorsApp.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            CircleAvatar(
              radius: 17,
              backgroundColor: ColorsApp.primaryColor,
              child: Icon(
                Icons.person_outline,
                color: ColorsApp.whiteColor,
                size: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 22),
        ProfileHeader(),
      ],
    );
  }
}
