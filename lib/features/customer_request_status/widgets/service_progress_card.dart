import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/jobs/job_model.dart';
import 'package:flutter/material.dart';

class ServiceProgressCard extends StatelessWidget {
  final JobModel job;

  const ServiceProgressCard({super.key, required this.job});

  static const List<Map<String, String>> steps = [
    {
      'status': JobStatus.accepted,
      'title': 'Accepted',
      'description': 'Request accepted by technician',
    },
    {
      'status': JobStatus.onWay,
      'title': 'On the Way',
      'description': 'Technician is on the way',
    },
    {
      'status': JobStatus.arrived,
      'title': 'Arrived',
      'description': 'Technician arrived at your location',
    },
    {
      'status': JobStatus.inProgress,
      'title': 'In Progress',
      'description': 'Technician started the repair work',
    },
    {
      'status': JobStatus.completed,
      'title': 'Completed',
      'description': 'Work finished and verified',
    },
  ];

  String _formatTime(DateTime? date) {
    if (date == null) return '—';

    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = JobStatus.flow.indexOf(job.status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorsApp.whiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Service Progress',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.primaryColor,
                ),
              ),
              Text(
                currentIndex == -1
                    ? 'Not started'
                    : 'Step ${currentIndex + 1} of ${steps.length}',
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFF0054D8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(
            steps.length,
            (index) => _buildProgressStep(index, currentIndex),
          ),
          if (job.isCancelled || job.isDisputed) ...[
            const Divider(),
            Text(
              job.isCancelled ? 'Request Cancelled' : 'Request Disputed',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressStep(int index, int currentIndex) {
    final step = steps[index];
    final isCompleted = currentIndex > index;
    final isActive = currentIndex == index;
    final isLast = index == steps.length - 1;

    final circleColor = isCompleted || isActive
        ? const Color(0xFF0054D8)
        : const Color(0xFFDCE7FA);

    final textColor = isCompleted || isActive
        ? ColorsApp.primaryColor
        : ColorsApp.greyColor;

    final stepTime = job.timeOf(step['status']!);

    return SizedBox(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 19,
                  height: 19,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted
                        ? Icons.check
                        : isActive
                        ? Icons.directions_car
                        : Icons.circle,
                    color: ColorsApp.whiteColor,
                    size: isActive ? 12 : 10,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 1, color: const Color(0xFFB9D0FF)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${index + 1}. ${step['title']}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: textColor,
                      ),
                    ),
                    if (isActive) ...[
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsApp.blueColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(
                            fontSize: 8,
                            color: Color(0xFF0054D8),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  step['description']!,
                  style: TextStyle(
                    fontSize: 9,
                    color: isCompleted || isActive
                        ? ColorsApp.greyColor
                        : const Color(0xFFB8BEC9),
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatTime(stepTime),
            style: TextStyle(
              fontSize: 9,
              color: stepTime != null
                  ? ColorsApp.primaryColor
                  : const Color(0xFFB8BEC9),
            ),
          ),
        ],
      ),
    );
  }
}
