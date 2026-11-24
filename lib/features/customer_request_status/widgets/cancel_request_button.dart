import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_request_status/bloc/request_status_bloc.dart';
import 'package:final_depi/features/customer_request_status/bloc/request_status_event.dart';
import 'package:final_depi/features/customer_request_status/bloc/request_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_depi/features/jobs/job_model.dart';

class CancelRequestButton extends StatelessWidget {
  const CancelRequestButton({super.key});

  Future<void> _confirmCancellation(BuildContext context) async {
    final state = context.read<RequestStatusBloc>().state;

    if (state is! RequestStatusLoaded) return;

    final status = state.job.status;

    const cancellableStatuses = [
      JobStatus.pending,
      JobStatus.accepted,
      JobStatus.onWay,
    ];

    if (!cancellableStatuses.contains(status)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This request can no longer be cancelled.'),
        ),
      );

      return;
    }

    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Cancel Request'),
          content: const Text(
            'Are you sure you want to cancel this maintenance request?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Keep Request'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text(
                'Yes, Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (shouldCancel == true && context.mounted) {
      context.read<RequestStatusBloc>().add(const DeleteRequest());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 12, color: ColorsApp.greyColor),
            SizedBox(width: 5),
            Text(
              'Cancellation is free before technician arrival.',
              style: TextStyle(fontSize: 9, color: ColorsApp.greyColor),
            ),
          ],
        ),
        const SizedBox(height: 9),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () => _confirmCancellation(context),
            icon: const Icon(Icons.cancel_outlined, size: 15),
            label: const Text('Cancel Request', style: TextStyle(fontSize: 12)),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsApp.blueColor,
              foregroundColor: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
