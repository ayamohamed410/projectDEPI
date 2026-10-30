import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/technical_home/widgets/dashboard_bottom_nav.dart';
import 'package:final_depi/features/technical_home/widgets/dashboard_header.dart';
import 'package:final_depi/features/technical_home/widgets/incoming_requests_section.dart';
import 'package:final_depi/features/technical_home/widgets/ongoing_job_section.dart';
import 'package:final_depi/features/technical_home/widgets/quick_action_section.dart';
import 'package:final_depi/features/technical_home/widgets/stats_section.dart';
import 'package:flutter/material.dart';

class TechnicianDashboardScreen extends StatelessWidget {
  const TechnicianDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                DashboardHeader(),
                SizedBox(height: 25),
                StatsSection(),
                SizedBox(height: 28),
                OngoingJobSection(),
                SizedBox(height: 25),
                IncomingRequestsSection(),
                SizedBox(height: 25),
                QuickActionsSection(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const DashboardBottomNav(),
    );
  }
}
