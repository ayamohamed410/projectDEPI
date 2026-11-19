import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_settings/section_settings_screen/account_section.dart';
import 'package:final_depi/features/customer_settings/section_settings_screen/notifications_section.dart';
import 'package:final_depi/features/customer_settings/section_settings_screen/preferennces_section.dart';
import 'package:final_depi/features/customer_settings/section_settings_screen/support_section.dart';
import 'package:final_depi/features/customer_settings/widgets/security_section.dart';
import 'package:flutter/material.dart';
import '../widgets/settings_profile_card.dart';

class CustomerSettingsScreen extends StatefulWidget {
  const CustomerSettingsScreen({super.key});

  @override
  State<CustomerSettingsScreen> createState() => _CustomerSettingsScreenState();
}

class _CustomerSettingsScreenState extends State<CustomerSettingsScreen> {
  bool _emailEnabled = true;
  bool _pushEnabled = true;
  bool _smsEnabled = false;
  bool _darkMode = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.background,

      appBar: AppBar(
        backgroundColor: ColorsApp.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios, color: ColorsApp.primaryColor),
        ),
        title: const Text(
          'Customer Settings',
          style: TextStyle(
            color: ColorsApp.primaryColor,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SettingsProfileCard(
            name: 'Tarek Mansour',
            email: 'tarek.mansour@example.com',
            phone: '+20 100 123 4567',
            onEdit: () => _showMessage('Edit profile tapped'),
          ),

          const SizedBox(height: 28),

          AccountSection(
            onAccountTap: () => _showMessage('Personal information tapped'),
            onAddressTap: () => _showMessage('Addresses tapped'),
          ),

          const SizedBox(height: 24),

          NotificationsSection(
            emailEnabled: _emailEnabled,
            pushEnabled: _pushEnabled,
            smsEnabled: _smsEnabled,
            onEmailChanged: (value) {
              setState(() => _emailEnabled = value);
            },
            onPushChanged: (value) {
              setState(() => _pushEnabled = value);
            },
            onSmsChanged: (value) {
              setState(() => _smsEnabled = value);
            },
          ),

          const SizedBox(height: 24),

          PreferencesSection(
            language: 'English',
            darkMode: _darkMode,
            onLanguageTap: () => _showMessage('Language settings tapped'),
            onAppearanceTap: () {
              setState(() => _darkMode = !_darkMode);
            },
          ),

          const SizedBox(height: 24),

          SupportSection(
            onHelpTap: () => _showMessage('Help Center tapped'),
            onConciergeTap: () => _showMessage('Concierge tapped'),
            onPrivacyTap: () => _showMessage('Privacy & Terms tapped'),
          ),

          const SizedBox(height: 24),

          SecuritySection(
            onSecurityTap: () => _showMessage('Security settings tapped'),
            onLogoutTap: () => _showMessage('Log Out tapped'),
          ),

          const SizedBox(height: 28),

          const Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: ColorsApp.greyColor, fontSize: 12),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
