import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_service_details/widgets/sections/booking_reference_section.dart';
import 'package:final_depi/features/customer_service_details/widgets/sections/customer_action_section.dart';
import 'package:final_depi/features/customer_service_details/widgets/sections/digital_receipt_section.dart';
import 'package:final_depi/features/customer_service_details/widgets/sections/job_visual_evidence_section.dart';
import 'package:final_depi/features/customer_service_details/widgets/sections/scope_diagnosis_section.dart';
import 'package:final_depi/features/customer_service_details/widgets/sections/service_timline_section.dart';
import 'package:final_depi/features/customer_service_details/widgets/sections/technical_section.dart';
import 'package:flutter/material.dart';

class CustomerServiceDetailsScreen extends StatelessWidget {
  const CustomerServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.background,
      appBar: AppBar(
        backgroundColor: ColorsApp.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
          color: ColorsApp.primaryColor,
        ),
        title: const Text(
          'Customer Service Details',
          style: TextStyle(
            color: ColorsApp.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 13,
              backgroundColor: ColorsApp.primaryColor,
              child: Icon(Icons.person, size: 17, color: ColorsApp.whiteColor),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: const [
            BookingReferenceSection(),
            SizedBox(height: 12),
            TechnicianSection(),
            SizedBox(height: 12),
            ScopeDiagnosisSection(),
            SizedBox(height: 12),
            JobVisualEvidenceSection(),
            SizedBox(height: 12),
            ServiceTimelineSection(),
            SizedBox(height: 12),
            DigitalReceiptSection(),
            SizedBox(height: 16),
            CustomerActionsSection(),
          ],
        ),
      ),
    );
  }
}
