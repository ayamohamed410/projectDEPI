import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TechnicianCardStatus extends StatelessWidget {
  const TechnicianCardStatus({super.key});

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
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: ColorsApp.blueColor,

                    child:
                        // هغيرها ل photoimage
                        Icon(
                          Icons.person,
                          size: 30,
                          color: ColorsApp.primaryColor,
                        ),
                  ),

                  Positioned(
                    right: -4,
                    bottom: -4,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: const Color(0xFF0054D8),
                      child: const Icon(
                        Icons.verified,
                        color: ColorsApp.whiteColor,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mahmoud El-Sayed',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.primaryColor,
                      ),
                    ),

                    const Text(
                      'Master Plumber • 12 yrs exp',
                      style: TextStyle(
                        fontSize: 10,
                        color: ColorsApp.greyColor,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Row(
                      children: [
                        const Icon(
                          Icons.verified,
                          color: Color(0xFF0054D8),
                          size: 12,
                        ),
                        const SizedBox(width: 3),
                        const Text(
                          'Elite Verified',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF0054D8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFA500),
                          size: 13,
                        ),
                        const SizedBox(width: 3),
                        const Text(
                          '4.9 (184)',
                          style: TextStyle(
                            fontSize: 10,
                            color: ColorsApp.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  title: 'Chat',
                  icon: Icons.chat_bubble_outline,
                  backgroundColor: const Color(0xFF0054D8),
                  foregroundColor: ColorsApp.whiteColor,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required Color foregroundColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 36,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 14),
        label: Text(title, style: const TextStyle(fontSize: 11)),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
      ),
    );
  }
}
