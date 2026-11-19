
import 'package:final_depi/app/routes/route_screen_name.dart';
import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/home/presentation/screens/incoming_requests_screen.dart';
import 'package:flutter/material.dart';

class DashboardBottomNav extends StatefulWidget {
  /// 0 = Dashboard, 1 = Requests, 2 = Jobs, 3 = Profile
  final int currentIndex;

  const DashboardBottomNav({super.key, this.currentIndex = 0});

  @override
  State<DashboardBottomNav> createState() => _DashboardBottomNavState();
}

class _DashboardBottomNavState extends State<DashboardBottomNav> {
  late int selectedIndex = widget.currentIndex;

  final List<IconData> icons = [
    Icons.grid_view_outlined,
    Icons.mark_email_unread_outlined,
    Icons.work_outline,
    Icons.badge_outlined,
  ];

  final List<String> labels = ['Dashboard', 'Requests', 'Jobs', 'Profile'];

  void _go(int index) {
    if (index == widget.currentIndex) return;
    final navigator = Navigator.of(context);

    switch (index) {
      case 0:
        navigator.pushReplacementNamed(RouteScreenName.technicianDashboard);
        break;
      case 1:
        navigator.pushReplacement(
          MaterialPageRoute(builder: (_) => const IncomingRequestsScreen()),
        );
        break;
      case 2:
        navigator.pushReplacementNamed(RouteScreenName.jobsHistory);
        break;
      case 3:
        navigator.pushReplacementNamed(RouteScreenName.technicianProfile);
        break;
    }
  }

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
                    _go(index);
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