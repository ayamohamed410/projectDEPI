

  import 'dart:async';
import 'package:final_depi/features/Technician/presentation/pages/technician_active_job.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../jobs/jobs_repository.dart';
import '../../dev/seed_jobs.dart';
import '../bloc/jobs_history_bloc.dart';
import '../widgets/JobCard.dart';
import 'TechnicianChat .dart';
import '../../../../app/routes/route_screen_name.dart';
import '../../../home/presentation/screens/incoming_requests_screen.dart';

import '../widgets/container.dart';
import '../widgets/custom_card_container.dart';
import '/core/theme/app_styles.dart';

class jobsHistory extends StatelessWidget {
  const jobsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobsHistoryBloc(JobsRepository())..add(LoadJobsHistory()),
      child: const JobsHistoryView(),
    );
  }
}

class JobsHistoryView extends StatefulWidget {
  const JobsHistoryView({super.key});

  @override
  State<JobsHistoryView> createState() => _JobsHistoryViewState();
}

class _JobsHistoryViewState extends State<JobsHistoryView> {
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<JobsHistoryBloc>().add(SearchJobsEvent(query));
    });
  }

  void _showWorkOrderDetails(BuildContext context, dynamic job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    job.requestNumber ?? 'Request',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  Chip(
                    label: Text(job.status ?? 'Completed'),
                    backgroundColor: Colors.blue.withOpacity(0.1),
                  ),
                ],
              ),
              const Divider(height: 24),
              Text('Service: ${job.diagnosisTitle ?? "-"}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Customer: ${job.customerName ?? "-"}', style: const TextStyle(fontSize: 14, color: Colors.black87)),
              const SizedBox(height: 8),
              Text('Net Payout: EGP ${job.netPayout ?? 0}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('إغلاق', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sort Jobs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.new_releases_outlined, color: Color(0xFF0066FF)),
                title: const Text('Newest First'),
                onTap: () {
                  context.read<JobsHistoryBloc>().add(const SortJobsEvent('newest'));
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.history, color: Color(0xFF0066FF)),
                title: const Text('Oldest First'),
                onTap: () {
                  context.read<JobsHistoryBloc>().add(const SortJobsEvent('oldest'));
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money, color: Color(0xFF0066FF)),
                title: const Text('Highest Payout'),
                onTap: () {
                  context.read<JobsHistoryBloc>().add(const SortJobsEvent('payout'));
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMonthPicker(BuildContext context, DateTime currentMonth) {
    final blocContext = context;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Billing Period', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final now = DateTime.now();
                    final monthDate = DateTime(now.year, now.month - index, 1);
                    final formatted = DateFormat('MMMM yyyy').format(monthDate);
                    return ListTile(
                      title: Text(formatted),
                      trailing: monthDate.month == currentMonth.month && monthDate.year == currentMonth.year
                          ? const Icon(Icons.check, color: Color(0xFF0066FF))
                          : null,
                      onTap: () {
                        blocContext.read<JobsHistoryBloc>().add(ChangeMonthEvent(monthDate));
                        Navigator.pop(ctx);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GestureDetector(
            onLongPress: () async {
              if (kDebugMode) {
                await SeedJobs.seed();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Seed data written successfully! Remove before delivery.')),
                );
                context.read<JobsHistoryBloc>().add(LoadJobsHistory());
              }
            },
            child: Row(
              children: [
                if (kDebugMode)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      try {
                        await SeedJobs.seed();
                        if (context.mounted) {
                          context.read<JobsHistoryBloc>().add(LoadJobsHistory());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Seed data written successfully!')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      }
                    },
                    child: const Text('تحميل البيانات التجريبية', style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 62, 131, 215),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Jobs History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                buildCustomContainer(
                  cardColor: AppColors.colorbluew,
                  child: Row(
                    children: [
                      Icon(Icons.verified_outlined, size: 20, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        'PRO',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: const Icon(Icons.person_outline, color: Colors.white, size: 18),
                    onPressed: () => Navigator.pushReplacementNamed(context, RouteScreenName.technicianProfile),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocConsumer<JobsHistoryBloc, JobsHistoryState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF0066FF)));
          }

          final jobs = state.filteredAndSortedJobs;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<JobsHistoryBloc>().add(LoadJobsHistory());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        const activeStatuses = [
                          'accepted',
                          'on_way',
                          'arrived',
                          'in_progress',
                        ];
                        final active = state.allJobs
                            .where((j) => activeStatuses.contains(j.status.trim()))
                            .toList();

                        if (active.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'No active job found. Jobs loaded: ${state.allJobs.length}',
                              ),
                            ),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                TechnicianActiveJob(jobId: active.first.id),
                          ),
                        );
                      },
                      child: const Text('Open Active Job'),
                    ),
                    const SizedBox(height: 12),
                    // Search Bar & Filter icon
                    CustomCardContainer(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (q) => _onSearchChanged(q, context),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                hintText: 'Search by customer, service, or request ID',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.tune, color: Colors.grey),
                            onPressed: () => _showSortBottomSheet(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Billing Period & Net Invoiced Card
                    CustomCardContainer(
                      cardcolor: AppColors.colorbluew,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, size: 40, color: Colors.lightBlue),
                              const SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Billing Period', style: AppTextStyles.cardTitle),
                                  const SizedBox(height: 2),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => _showMonthPicker(context, state.selectedMonth),
                                      child: Row(
                                        children: [
                                          Text(
                                            DateFormat('MMMM yyyy').format(state.selectedMonth),
                                            style: AppTextStyles.cardTitle,
                                          ),
                                          const Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Net Invoiced', style: AppTextStyles.cardTitle),
                              const SizedBox(height: 2),
                              Text(
                                'EGP ${NumberFormat('#,##0').format(state.netInvoiced)}',
                                style: AppTextStyles.cardTitle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tabs Row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => context.read<JobsHistoryBloc>().add(const ChangeTabEvent(0)),
                            child: buildCustomContainer(
                              child: Text("All (${state.countAll})", style: AppTextStyles.cardTitle),
                              cardColor: state.selectedTab == 0 ? Colors.black : AppColors.colorbluew,
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () => context.read<JobsHistoryBloc>().add(const ChangeTabEvent(1)),
                            child: buildCustomContainer(
                              child: Text(
                                "Completed (${state.countCompleted})",
                                style: TextStyle(color: state.selectedTab == 1 ? Colors.white : Colors.black87),
                              ),
                              cardColor: state.selectedTab == 1 ? Colors.black : AppColors.colorbluew,
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () => context.read<JobsHistoryBloc>().add(const ChangeTabEvent(2)),
                            child: buildCustomContainer(
                              child: Text("Cancelled (${state.countCancelled})", style: AppTextStyles.cardTitle),
                              cardColor: state.selectedTab == 2 ? Colors.black : AppColors.colorbluew,
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () => context.read<JobsHistoryBloc>().add(const ChangeTabEvent(3)),
                            child: buildCustomContainer(
                              child: Text("Disputed (${state.countDisputed})", style: AppTextStyles.cardTitle),
                              cardColor: state.selectedTab == 3 ? Colors.black : AppColors.colorbluew,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Jobs Cards List
                    CustomCardContainer(
                      child: jobs.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Center(
                                child: Text(
                                  'No jobs found for this period.',
                                  style: TextStyle(color: Colors.grey, fontSize: 13),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: jobs.length,
                              itemBuilder: (context, index) {
                                final job = jobs[index];
                                return Jobcard(
                                  job: job,
                                  onChatTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => TechnicianChat(jobId: job.id)),
                                    );
                                  },
                                  onViewWorkOrder: () {
                                    // ربط زرار أمر العمل بعرض التفاصيل
                                    _showWorkOrderDetails(context, job);
                                  },
                                  onViewIncidentLog: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Incident log feature coming soon')),
                                    );
                                  },
                                  onTap: () {
                                    
                                    _showWorkOrderDetails(context, job);
                                  },
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 12),

                    // Escrow Notice Footer
                    buildCustomContainer(
                      cardColor: AppColors.bluenewcontainer,
                      child: Row(
                        children: [
                          Icon(Icons.verified_user_rounded, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'All logged records are secured & escrow-cleared',
                              style: AppTextStyles.cardTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: AppColors.textSecondary,
        currentIndex: 2,
        onTap: (val) {
          if (val == 0) {
            Navigator.pushReplacementNamed(context, RouteScreenName.technicianDashboard);
          } else if (val == 1) {
            try {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const IncomingRequestsScreen()),
              );
            } catch (_) {}
          } else if (val == 2) {
            // Already here
          } else if (val == 3) {
            Navigator.pushReplacementNamed(context, RouteScreenName.technicianProfile);
          }
        },
        items: const [



          
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_email_read_outlined),
            label: "Requests",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_history_outlined),
            label: "Jobs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            label: "Profile",
          ),
        ],
      ),

    
 );
  }
}