import 'package:final_depi/features/customer_settings/widgets/settings_divider.dart';
import 'package:final_depi/features/customer_settings/widgets/settings_section.dart';
import 'package:final_depi/features/customer_settings/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({
    super.key,
    required this.onAccountTap,
    required this.onAddressTap,
  });

  final VoidCallback onAccountTap;
  final VoidCallback onAddressTap;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Account',
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.person_outline,
            title: 'Personal Information',
            subtitle: 'Manage your account details',
            onTap: onAccountTap,
          ),
          const SettingsDivider(),
          SettingsTile(
            icon: Icons.location_on_outlined,
            title: 'Addresses',
            subtitle: 'Manage your saved addresses',
            onTap: onAddressTap,
          ),
        ],
      ),
    );
  }
}
