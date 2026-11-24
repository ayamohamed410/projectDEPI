import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/jobs/job_model.dart';
import 'package:flutter/material.dart';

class RequestInfoCard extends StatelessWidget {
  final JobModel job;

  const RequestInfoCard({super.key, required this.job});

  String _getStatusText(String status) {
    switch (status) {
      case JobStatus.pending:
        return 'Pending';
      case JobStatus.accepted:
        return 'Accepted';
      case JobStatus.onWay:
        return 'On the Way';
      case JobStatus.arrived:
        return 'Arrived';
      case JobStatus.inProgress:
        return 'In Progress';
      case JobStatus.completed:
        return 'Completed';
      case JobStatus.cancelled:
        return 'Cancelled';
      case JobStatus.disputed:
        return 'Disputed';
      default:
        return status;
    }
  }

  String _getFormattedDate(DateTime? date) {
    if (date == null) return 'Date unavailable';

    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${date.day}/${date.month}/${date.year} • $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final requestNumber = job.requestNumber.isNotEmpty
        ? job.requestNumber
        : job.id;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorsApp.whiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'REQUEST ID ',
                style: TextStyle(fontSize: 9, color: ColorsApp.primaryColor),
              ),
              Expanded(
                child: Text(
                  '#$requestNumber',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.primaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: ColorsApp.blueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 8, color: Color(0xFF0054D8)),
                    const SizedBox(width: 5),
                    Text(
                      _getStatusText(job.status),
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF0054D8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 12,
                color: ColorsApp.greyColor,
              ),
              const SizedBox(width: 5),
              Text(
                _getFormattedDate(job.createdAt),
                style: const TextStyle(
                  fontSize: 10,
                  color: ColorsApp.greyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
