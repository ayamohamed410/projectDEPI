import 'package:final_depi/features/customer_chat/screens/customer_chat_screen.dart';
import 'package:final_depi/features/customer_request_status/screens/request_status_screen.dart';
import 'package:final_depi/features/customer_settings/screens/customer_settings_screens.dart';
import 'package:final_depi/features/home/presentation/screens/customer_home_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar(NavBarItem navBarItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(icon: Icons.home, label: 'Home', isSelected: true),

          NavBarItem(
            icon: Icons.description_outlined,
            label: 'Requests',
            isSelected: false,
            // ***** Mohamed ******
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RequestStatusScreen()),
              );
            },
          ),
          NavBarItem(
            icon: Icons.chat_bubble_outline,
            label: 'Messages',
            isSelected: false,
            // ***** Mohamed ******
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerChatScreen()),
              );
            },
          ),
          NavBarItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            isSelected: false,

            // ***** Mohamed ******
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerSettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Mohamed Makes this  widget to be clickable by using GestureDetector
class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  // ****** Mohamed ******
  final VoidCallback? onTap;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    // *******Mohamed ******
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.blue : Colors.grey;
    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
