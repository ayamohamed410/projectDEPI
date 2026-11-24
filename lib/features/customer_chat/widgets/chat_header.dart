import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/customer_request_status/screens/request_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_depi/features/customer_request_status/bloc/request_status_bloc.dart';
import 'package:final_depi/features/customer_request_status/bloc/request_status_event.dart';
import 'package:final_depi/features/jobs/jobs_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_depi/features/jobs/job_model.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key, this.onBack, this.jobId});

  final VoidCallback? onBack;
  final String? jobId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsApp.whiteColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Back',
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 22,
                    color: ColorsApp.primaryColor,
                  ),
                ),
                const SizedBox(width: 22),
                const Expanded(
                  child: Text(
                    'Customer Chat',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: ColorsApp.primaryColor,
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: ColorsApp.primaryColor,
                  child: Icon(
                    Icons.person_outline,
                    color: ColorsApp.whiteColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          StreamBuilder<JobModel?>(
            stream: jobId == null || jobId!.isEmpty
                ? null
                : JobsRepository().watchJob(jobId!),
            builder: (context, snapshot) {
              final job = snapshot.data;

              final hasJobId = jobId != null && jobId!.isNotEmpty;
              final isLoading =
                  hasJobId &&
                  snapshot.connectionState == ConnectionState.waiting;

              final requestText = !hasJobId
                  ? 'No active request'
                  : snapshot.hasError
                  ? 'Unable to load request'
                  : isLoading
                  ? 'Loading request...'
                  : job == null
                  ? 'Request not found'
                  : 'Request #${job.requestNumber} • ${job.diagnosisTitle}';

              final Widget technicianContent;

              if (!hasJobId) {
                technicianContent = const Text(
                  'No technician assigned',
                  style: TextStyle(fontSize: 13),
                );
              } else if (snapshot.hasError) {
                technicianContent = const Text(
                  'Unable to load technician',
                  style: TextStyle(fontSize: 13),
                );
              } else if (isLoading) {
                technicianContent = const Text(
                  'Loading technician...',
                  style: TextStyle(fontSize: 13),
                );
              } else if (job == null) {
                technicianContent = const Text(
                  'Technician not found',
                  style: TextStyle(fontSize: 13),
                );
              } else {
                final technicianId = job.technicianId;

                technicianContent = StreamBuilder<List<Map<String, dynamic>>>(
                  stream: JobsRepository().watchTechnicians(),
                  builder: (context, techniciansSnapshot) {
                    if (techniciansSnapshot.hasError) {
                      return const Text(
                        'Unable to load technician',
                        style: TextStyle(fontSize: 13),
                      );
                    }

                    if (techniciansSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Text(
                        'Loading technician...',
                        style: TextStyle(fontSize: 13),
                      );
                    }

                    final technicians = techniciansSnapshot.data ?? [];

                    Map<String, dynamic>? technician;

                    for (final item in technicians) {
                      if (item['id'] == technicianId) {
                        technician = item;
                        break;
                      }
                    }

                    final technicianName =
                        technician?['name']?.toString() ?? 'Technician';

                    return Row(
                      children: [
                        Flexible(
                          child: Text(
                            technicianName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.verified,
                          size: 15,
                          color: Color(0xFF1262E8),
                        ),
                      ],
                    );
                  },
                );
              }

              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsApp.blueColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.support_agent,
                          size: 17,
                          color: Color(0xFF1262E8),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            requestText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            if (!hasJobId) return;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (_) =>
                                      RequestStatusBloc(JobsRepository())
                                        ..add(LoadRequestById(jobId!)),
                                  child: RequestStatusScreen(
                                    onBack: () => Navigator.of(context).pop(),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0EAFF),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'View Status →',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF1262E8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 21,
                          backgroundColor: ColorsApp.blueColor,
                          child: Icon(
                            Icons.person,
                            color: ColorsApp.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: technicianContent),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
