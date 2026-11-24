import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_request_status/bloc/request_status_bloc.dart';
import 'package:final_depi/features/customer_request_status/bloc/request_status_state.dart';
import 'package:final_depi/features/customer_request_status/widgets/booking_summary_card.dart';
import 'package:final_depi/features/customer_request_status/widgets/cancel_request_button.dart';
import 'package:final_depi/features/customer_request_status/widgets/request_info_card.dart';
import 'package:final_depi/features/customer_request_status/widgets/service_progress_card.dart';
import 'package:final_depi/features/customer_request_status/widgets/technician_card_status.dart';
import 'package:final_depi/features/jobs/job_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              child: BlocListener<RequestStatusBloc, RequestStatusState>(
                listener: (context, state) {
                  if (state is RequestStatusDeleteSuccess) {
                    onBack?.call();
                  }
                },
                child: BlocBuilder<RequestStatusBloc, RequestStatusState>(
                  builder: (context, state) {
                    if (state is RequestStatusLoading ||
                        state is RequestStatusInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is RequestStatusEmpty) {
                      return const Center(
                        child: Text('No maintenance requests yet'),
                      );
                    }

                    if (state is RequestStatusError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is RequestStatusDeleteSuccess) {
                      return const Center(
                        child: Text('Request deleted successfully'),
                      );
                    }

                    if (state is RequestStatusDeleting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is RequestStatusLoaded) {
                      final JobModel job = state.job;

                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            RequestInfoCard(job: job),
                            const SizedBox(height: 12),
                            TechnicianCardStatus(job: job),
                            const SizedBox(height: 12),
                            ServiceProgressCard(job: job),
                            const SizedBox(height: 12),
                            BookingSummaryCard(job: job),
                            const SizedBox(height: 16),
                            CancelRequestButton(),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
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
