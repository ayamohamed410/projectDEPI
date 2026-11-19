import 'package:final_depi/features/customer_settings/widgets/settings_divider.dart';
import 'package:final_depi/features/customer_settings/widgets/settings_section.dart';
import 'package:final_depi/features/customer_settings/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({
    super.key,
    required this.onHelpTap,
    required this.onConciergeTap,
    required this.onPrivacyTap,
  });

  final VoidCallback onHelpTap;
  final VoidCallback onConciergeTap;
  final VoidCallback onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Support & Legal',
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            subtitle: 'FAQs and customer support',
            onTap: onHelpTap,
          ),
          const SettingsDivider(),
          SettingsTile(
            icon: Icons.support_agent,
            title: 'Concierge',
            subtitle: 'Get personalized assistance',
            onTap: onConciergeTap,
          ),
          const SettingsDivider(),
          SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy & Terms',
            subtitle: 'Review our policies',
            onTap: onPrivacyTap,
          ),
        ],
      ),
    );
  }
}
