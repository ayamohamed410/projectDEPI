import 'package:flutter/material.dart';
import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_settings/screens/customer_settings_screens.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.home, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              'Client Home',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black87,
              ),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications are not available yet.')),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (_) => const CustomerSettingsScreen(),
                )),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: ColorsApp.primaryColor,
                  child: Icon(Icons.person, color: ColorsApp.whiteColor, size: 20),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
