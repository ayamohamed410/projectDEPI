import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_service_details/screens/customer_service_details_screen.dart';
import 'package:final_depi/features/jobs/job_model.dart';
import 'package:flutter/material.dart';

class BookingSummaryCard extends StatelessWidget {
  final JobModel job;

  const BookingSummaryCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final issueTitle = job.diagnosisTitle.isNotEmpty
        ? job.diagnosisTitle
        : 'No issue title provided';

    final issueDescription = job.problemDescription.isNotEmpty
        ? job.problemDescription
        : 'No additional description';

    final serviceAddress = job.customerArea.isNotEmpty
        ? job.customerArea
        : 'Address not provided';

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
                'Booking Summary',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.primaryColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerServiceDetailsScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View Service Details',
                  style: TextStyle(fontSize: 10, color: Color(0xFF0054D8)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildSummaryItem(
            icon: Icons.build,
            title: 'Issue Reported',
            content: issueTitle,
            subtitle: issueDescription,
          ),
          const SizedBox(height: 7),
          _buildSummaryItem(
            icon: Icons.location_on_outlined,
            title: 'Service Address',
            content: serviceAddress,
            subtitle: 'Customer service location',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String title,
    required String content,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: ColorsApp.blueColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Container(
            width: 29,
            height: 29,
            decoration: BoxDecoration(
              color: const Color(0xFFD8E6FF),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(icon, size: 16, color: const Color(0xFF0054D8)),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 9,
                    color: ColorsApp.primaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ColorsApp.primaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 9,
                    color: ColorsApp.greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
