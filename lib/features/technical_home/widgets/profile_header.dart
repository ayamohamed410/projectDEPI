import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 29,
              backgroundColor: ColorsApp.blueColor,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 13,
                height: 13,
                decoration: const BoxDecoration(
                  color: Color(0xFF0052CC),
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(
                    BorderSide(color: ColorsApp.whiteColor, width: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.primaryColor,
                ),
              ),
              Text(
                'Mahmoud',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.primaryColor,
                ),
              ),
              Text(
                'Master Plumber',
                style: TextStyle(fontSize: 12, color: ColorsApp.greyColor),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.handyman_outlined,
          color: ColorsApp.greyColor,
          size: 19,
        ),
        const SizedBox(width: 12),
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: ColorsApp.blueColor,
              child: Icon(
                Icons.notifications_none,
                color: ColorsApp.primaryColor,
                size: 25,
              ),
            ),
            Positioned(
              top: -3,
              right: -2,
              child: CircleAvatar(
                radius: 9,
                backgroundColor: Color(0xFF0052CC),
                child: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 11,
                    color: ColorsApp.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
