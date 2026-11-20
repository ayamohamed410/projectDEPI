import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_request_status/widgets/booking_summary_card.dart';
import 'package:final_depi/features/customer_request_status/widgets/cancel_request_button.dart';
import 'package:final_depi/features/customer_request_status/widgets/request_info_card.dart';
import 'package:final_depi/features/customer_request_status/widgets/service_progress_card.dart';
import 'package:final_depi/features/customer_request_status/widgets/technician_card_status.dart';
import 'package:flutter/material.dart';

class RequestStatusScreen extends StatelessWidget {
  const RequestStatusScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    RequestInfoCard(),
                    SizedBox(height: 12),

                    TechnicianCardStatus(),
                    SizedBox(height: 12),

                    ServiceProgressCard(),
                    SizedBox(height: 12),

                    BookingSummaryCard(),
                    SizedBox(height: 16),

                    CancelRequestButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Appbar
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_ios_new),
            iconSize: 20,
            color: ColorsApp.primaryColor,
          ),

          const Expanded(
            child: Text(
              'Request Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorsApp.primaryColor,
              ),
            ),
          ),

          const CircleAvatar(
            radius: 17,
            backgroundColor: ColorsApp.primaryColor,
            child: Icon(
              Icons.person_outline,
              color: ColorsApp.whiteColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
