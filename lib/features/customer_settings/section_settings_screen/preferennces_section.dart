import 'package:final_depi/features/customer_settings/widgets/settings_divider.dart';
import 'package:final_depi/features/customer_settings/widgets/settings_section.dart';
import 'package:final_depi/features/customer_settings/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({
    super.key,
    required this.language,
    required this.darkMode,
    required this.onLanguageTap,
    required this.onAppearanceTap,
  });

  final String language;
  final bool darkMode;
  final VoidCallback onLanguageTap;
  final VoidCallback onAppearanceTap;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Preferences',
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.language,
            title: 'Language',
            subtitle: language,
            onTap: onLanguageTap,
          ),
          const SettingsDivider(),
          SettingsTile(
            icon: Icons.palette_outlined,
            title: 'Appearance',
            subtitle: darkMode ? 'Dark mode' : 'Light mode',
            onTap: onAppearanceTap,
          ),
        ],
      ),
    );
  }
}
