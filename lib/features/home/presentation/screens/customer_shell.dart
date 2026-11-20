import 'package:flutter/material.dart';
import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_chat/screens/customer_chat_screen.dart';
import 'package:final_depi/features/customer_request_status/screens/request_status_screen.dart';
import 'package:final_depi/features/customer_settings/screens/customer_settings_screens.dart';
import 'customer_home_screen.dart';
import '../widgets/custom_bottom_nav.dart';

/// Keeps the four primary customer tabs alive and shows one persistent navbar.
/// Detail screens (e.g. AI diagnosis and technician lists) are normal routes.
class CustomerShell extends StatefulWidget {
  const CustomerShell({super.key});

  @override
  State<CustomerShell> createState() => _CustomerShellState();
}

class _CustomerShellState extends State<CustomerShell> {
  int _index = 0;

  void _select(int index) {
    if (index == _index) return;
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _index != 0) _select(0);
      },
      child: Scaffold(
        backgroundColor: ColorsApp.background,
        body: IndexedStack(
          index: _index,
          children: [
            const CustomerHomeScreen(),
            RequestStatusScreen(onBack: () => _select(0)),
            CustomerChatScreen(onBack: () => _select(0)),
            CustomerSettingsScreen(onBack: () => _select(0)),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _index,
          onSelected: _select,
        ),
      ),
    );
  }
}
