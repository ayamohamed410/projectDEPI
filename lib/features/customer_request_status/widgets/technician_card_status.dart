import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_chat/screens/customer_chat_screen.dart';
import 'package:final_depi/features/customer_request_status/data/technician_status_repository.dart';
import 'package:final_depi/features/jobs/job_model.dart';
import 'package:flutter/material.dart';

class TechnicianCardStatus extends StatelessWidget {
  TechnicianCardStatus({super.key, required this.job});

  final JobModel job;
  final TechnicianStatusRepository _repository = TechnicianStatusRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorsApp.whiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: FutureBuilder<TechnicianStatusInfo?>(
        future: _repository.fetchTechnicianById(job.technicianId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Text('Could not load technician information');
          }

          final technician = snapshot.data;

          if (technician == null) {
            return const Text('Technician information not available');
          }

          return Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: ColorsApp.blueColor,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: ColorsApp.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          technician.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorsApp.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${technician.specialization} • ${technician.experience} experience',
                          style: const TextStyle(
                            fontSize: 10,
                            color: ColorsApp.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 36,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerChatScreen(jobId: job.id),
                      ),
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_outline, size: 14),
                  label: const Text('Chat', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0054D8),
                    foregroundColor: ColorsApp.whiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
