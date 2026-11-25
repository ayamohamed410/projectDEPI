import 'package:final_depi/app/routes/route_screen_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_depi/features/jobs/job_model.dart';
import 'package:final_depi/features/Technician/presentation/bloc/incoming_requests/incoming_requests_bloc.dart';

const Color primaryBlue = Color(0xff17233F);
const Color lightBackground = Color(0xffF5F7FC);

class IncomingRequestsScreen extends StatelessWidget {
  const IncomingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          color: primaryBlue,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Incoming Requests',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: primaryBlue,
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
      body: BlocBuilder<IncomingRequestsBloc, IncomingRequestsState>(
        builder: (context, state) {
          if (state.status == IncomingRequestsStatus.initial ||
              state.status == IncomingRequestsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: primaryBlue),
            );
          }

          if (state.status == IncomingRequestsStatus.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 40),
                  const SizedBox(height: 12),
                  Text(state.errorMessage ?? 'Something went wrong'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<IncomingRequestsBloc>().add(
                        const RetryIncomingRequests(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final requests = state.requests;

          if (state.status == IncomingRequestsStatus.empty ||
              requests.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.inbox_outlined, size: 55, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'No incoming requests yet',
                    style: TextStyle(
                      color: primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'New requests assigned to you will appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          'New (${requests.length})',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'All Requests',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              ...requests.map(
                (job) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RequestCard(job: job),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final JobModel job;

  const RequestCard({super.key, required this.job});

  String _formatDate(DateTime? date) {
    if (date == null) return 'Recently';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.circle, size: 8, color: Colors.orange),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'NEW REQUEST',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
              const Icon(Icons.calendar_today_outlined, size: 12),
              const SizedBox(width: 4),
              Text(
                _formatDate(job.createdAt),
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: lightBackground,
                child: Icon(Icons.person, color: primaryBlue),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.diagnosisTitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      job.customerName.isEmpty ? 'Customer' : job.customerName,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      job.customerArea.isEmpty
                          ? 'Location not provided'
                          : job.customerArea,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (job.problemDescription.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: lightBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                job.problemDescription,
                style: const TextStyle(fontSize: 11, color: primaryBlue),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteScreenName.requestDetailsScreen,
                  arguments: job,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('View Request Details'),
            ),
          ),
        ],
      ),
    );
  }
}
