import 'package:final_depi/features/customer_settings/widgets/settings_section.dart';
import 'package:final_depi/features/customer_settings/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({
    super.key,
    required this.onSecurityTap,
    required this.onLogoutTap,
  });

  final VoidCallback onSecurityTap;
  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Security',
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.lock_outline,
            title: 'Password & Security',
            subtitle: 'Manage your account security',
            onTap: onSecurityTap,
          ),
          SettingsTile(
            icon: Icons.logout,
            title: 'Log Out',
            subtitle: 'Sign out of your account',
            iconColor: Colors.red,
            iconBackground: const Color(0xFFFFEEEE),
            onTap: onLogoutTap,
          ),
        ],
      ),
    );
  }
}
