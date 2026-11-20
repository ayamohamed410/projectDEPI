import 'package:flutter/material.dart';
import 'package:final_depi/core/theme/app_colors.dart';

/// Navigation UI only. CustomerShell controls the selected tab and its content.
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    const items = <({IconData icon, String label})>[
      (icon: Icons.home_outlined, label: 'Home'),
      (icon: Icons.description_outlined, label: 'Requests'),
      (icon: Icons.chat_bubble_outline, label: 'Messages'),
      (icon: Icons.settings_outlined, label: 'Settings'),
    ];

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: ColorsApp.whiteColor,
          border: Border(top: BorderSide(color: ColorsApp.borderColor)),
        ),
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: InkWell(
                  onTap: () => onSelected(i),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(items[i].icon,
                          color: selectedIndex == i
                              ? ColorsApp.accentBlue : ColorsApp.secondaryText,
                          size: 22),
                        const SizedBox(height: 3),
                        Text(items[i].label, style: TextStyle(
                          color: selectedIndex == i
                              ? ColorsApp.accentBlue : ColorsApp.secondaryText,
                          fontSize: 11,
                          fontWeight: selectedIndex == i
                              ? FontWeight.bold : FontWeight.normal,
                        )),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
