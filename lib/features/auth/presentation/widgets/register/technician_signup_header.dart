
import 'package:final_depi/core/constants/assets_app.dart';
import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TechnicianSignupHeader extends StatelessWidget {
  const TechnicianSignupHeader({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Image.asset(
               AssetsApp.logoSplash,
                height: 76,
                width: 76,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.home_repair_service_rounded,
                    size: 70,
                    color: ColorsApp.primaryColor,
                  );
                },
              ),
              const SizedBox(height: 6),
              const Text(
                '7elhaly',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Join as a Technician',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: ColorsApp.primaryColor,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Showcase your skills and connect with customers.',
          style: TextStyle(
            fontSize: 15,
            color: ColorsApp.greyColor,
          ),
        ),
      ],
    );
  }
}
