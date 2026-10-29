import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TrustNote extends StatelessWidget {
  const TrustNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorsApp.blueColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_outlined,
            color: ColorsApp.primaryColor,
            size: 22,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Your verified review directly influences '
              'Mahmoud’s standing and helps maintain our '
              'elite network standard across the region.',
              style: TextStyle(
                color: ColorsApp.greyColor,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
