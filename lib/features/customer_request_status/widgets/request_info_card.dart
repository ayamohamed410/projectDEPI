import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RequestInfoCard extends StatelessWidget {
  const RequestInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorsApp.whiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'REQUEST ID ',
                style: TextStyle(fontSize: 9, color: ColorsApp.primaryColor),
              ),

              const Text(
                '#7H-9482',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.primaryColor,
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: ColorsApp.blueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: Color(0xFF0054D8)),
                    SizedBox(width: 5),
                    Text(
                      'On the Way',
                      style: TextStyle(fontSize: 9, color: Color(0xFF0054D8)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 12,
                color: ColorsApp.greyColor,
              ),
              SizedBox(width: 5),
              Text(
                'Oct 24, 2024 • 10:30 AM',
                style: TextStyle(fontSize: 10, color: ColorsApp.greyColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
