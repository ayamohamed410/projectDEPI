import 'package:final_depi/features/customer_settings/widgets/settings_divider.dart';
import 'package:final_depi/features/customer_settings/widgets/settings_section.dart';
import 'package:final_depi/features/customer_settings/widgets/settings_switch.dart';
import 'package:final_depi/features/customer_settings/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

class NotificationsSection extends StatelessWidget {
  const NotificationsSection({
    super.key,
    required this.emailEnabled,
    required this.pushEnabled,
    required this.smsEnabled,
    required this.onEmailChanged,
    required this.onPushChanged,
    required this.onSmsChanged,
  });

  final bool emailEnabled;
  final bool pushEnabled;
  final bool smsEnabled;

  final ValueChanged<bool> onEmailChanged;
  final ValueChanged<bool> onPushChanged;
  final ValueChanged<bool> onSmsChanged;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Notifications',
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.email_outlined,
            title: 'Email Notifications',
            subtitle: 'Updates and offers via email',
            trailing: SettingsSwitch(
              value: emailEnabled,
              onChanged: onEmailChanged,
            ),
          ),
          const SettingsDivider(),
          SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            subtitle: 'Order updates and reminders',
            trailing: SettingsSwitch(
              value: pushEnabled,
              onChanged: onPushChanged,
            ),
          ),
          const SettingsDivider(),
          SettingsTile(
            icon: Icons.sms_outlined,
            title: 'SMS Notifications',
            subtitle: 'Important updates by text',
            trailing: SettingsSwitch(
              value: smsEnabled,
              onChanged: onSmsChanged,
            ),
          ),
        ],
      ),
    );
  }
}
