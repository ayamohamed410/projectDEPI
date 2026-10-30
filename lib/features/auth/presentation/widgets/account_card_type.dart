
import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AccountTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const AccountTypeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFEAF1FF)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ?  ColorsApp.BlueColor

                :  ColorsApp.whiteColor,
            width: isSelected ? 2.3 : 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color:  ColorsApp.primaryColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorsApp.greyColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              color: ColorsApp.BlueColor,
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
            ),
          ],
        ),
      ),
    );
  }
}
