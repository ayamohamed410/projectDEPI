import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardBottomNav extends StatefulWidget {
  const DashboardBottomNav({super.key});

  @override
  State<DashboardBottomNav> createState() => _DashboardBottomNavState();
}

class _DashboardBottomNavState extends State<DashboardBottomNav> {
  int selectedIndex = 0;

  final List<IconData> icons = [
    Icons.grid_view_outlined,
    Icons.mark_email_unread_outlined,
    Icons.work_outline,
    Icons.badge_outlined,
  ];

  final List<String> labels = ['Dashboard', 'Requests', 'Jobs', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsApp.whiteColor,
        boxShadow: [
          BoxShadow(
            color: ColorsApp.greyColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 65,
          child: Row(
            children: List.generate(icons.length, (index) {
              final isSelected = selectedIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        size: 23,
                        color: isSelected
                            ? ColorsApp.primaryColor
                            : ColorsApp.greyColor,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        labels[index],
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected
                              ? ColorsApp.primaryColor
                              : ColorsApp.greyColor,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
