import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProviderCard extends StatelessWidget {
  const ProviderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsApp.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsApp.blueColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'REF: #7H-9482',
                  style: TextStyle(
                    color: ColorsApp.greyColor,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: ColorsApp.blueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: ColorsApp.primaryColor,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Completed Oct 24',
                      style: TextStyle(
                        color: ColorsApp.primaryColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: ColorsApp.blueColor,
                child: Icon(Icons.person, size: 34, color: ColorsApp.greyColor),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mahmoud El-Sayed',
                      style: TextStyle(
                        color: ColorsApp.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Master Plumber • Elite Concierge',
                      style: TextStyle(
                        color: ColorsApp.greyColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: ColorsApp.primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '4.98',
                          style: TextStyle(
                            color: ColorsApp.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(142 verified jobs)',
                          style: TextStyle(
                            color: ColorsApp.greyColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
