import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProtectedCommunication extends StatelessWidget {
  const ProtectedCommunication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsApp.blueColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 17,
            backgroundColor: Color(0xFFDCE8FF),
            child: Icon(
              Icons.shield_outlined,
              color: Color(0xFF1262E8),
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Protected Communication',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorsApp.primaryColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'For your security, keep all communications and payments within 7elhaly. Official dispatch verified.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.65,
                    color: Color(0xFF505765),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
