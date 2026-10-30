import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomerInfoCard extends StatelessWidget {
  const CustomerInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      decoration: BoxDecoration(
        color: ColorsApp.blueColor,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 19,
            backgroundColor: ColorsApp.background,
            child: Text(
              'TM',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: ColorsApp.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 9),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tarek Mansour',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ColorsApp.primaryColor,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Apt 402, South Teseen St, New Cairo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: ColorsApp.greyColor),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 17,
            backgroundColor: ColorsApp.whiteColor,
            child: Icon(
              Icons.phone_outlined,
              color: ColorsApp.primaryColor,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
