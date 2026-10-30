import 'package:flutter/material.dart';

class CustomBottomNavBarTechnician extends StatefulWidget {
  const CustomBottomNavBarTechnician({super.key});

  @override
  State<CustomBottomNavBarTechnician> createState() =>
      _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBarTechnician> {
  int selectedIndex = 0;

  final List<NavBarItem> items = [
    NavBarItem(icon: Icons.dashboard_outlined, label: 'Dashboard'),
    NavBarItem(icon: Icons.mark_email_unread_outlined, label: 'Requests'),
    NavBarItem(icon: Icons.work_history_outlined, label: 'Jobs'),
    NavBarItem(icon: Icons.badge_outlined, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FD),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(items.length, (index) {
            final isSelected = selectedIndex == index;
            final color = isSelected
                ? const Color(0xff1554B8)
                : const Color(0xff41444B);

            return Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(items[index].icon, color: color, size: 24),
                    const SizedBox(height: 5),
                    Text(
                      items[index].label,
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
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
    );
  }
}

class NavBarItem {
  final IconData icon;
  final String label;

  NavBarItem({required this.icon, required this.label});
}
