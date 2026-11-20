import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '/core/theme/app_styles.dart';
import '../../../../app/routes/route_screen_name.dart';
import '../../../jobs/job_model.dart';
import '../../../jobs/jobs_repository.dart';
import '../bloc/active_job/active_job_bloc.dart';
import '../bloc/active_job/active_job_event.dart';
import '../widgets/container.dart';
import '../widgets/custom_card_container.dart';
import '../widgets/timelinestep.dart';
import 'TechnicianChat .dart';

String _money(double v) =>
    v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(2);

String _time(DateTime? t) =>
    t == null ? '--:--' : DateFormat('hh:mm a').format(t);

String _statusLabel(String status) {
  switch (status) {
    case JobStatus.pending:
      return 'PENDING';
    case JobStatus.accepted:
      return 'ACCEPTED';
    case JobStatus.onWay:
      return 'ON THE WAY';
    case JobStatus.arrived:
      return 'ARRIVED';
    case JobStatus.inProgress:
      return 'ACTIVE IN PROGRESS';
    case JobStatus.completed:
      return 'COMPLETED';
    case JobStatus.cancelled:
      return 'CANCELLED';
    case JobStatus.disputed:
      return 'DISPUTED';
    default:
      return status.toUpperCase();
  }
}

class TechnicianActiveJob extends StatelessWidget {
  final String? jobId;
  const TechnicianActiveJob({super.key, this.jobId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ActiveJobBloc(JobsRepository())..add(LoadActiveJob(jobId)),
      child: const _ActiveJobView(),
    );
  }
}

class _ActiveJobView extends StatelessWidget {
  const _ActiveJobView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: const Text(
          'Technician Active Job',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ActiveJobBloc, ActiveJobState>(
        listenWhen: (p, c) =>
            (c.message != null && p.message != c.message) ||
            (!p.completed && c.completed),
        listener: (context, state) {
          final msg = state.message;
          if (msg != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg)));
            context.read<ActiveJobBloc>().add(const MessageShown());
          }
          if (state.completed) {
            Navigator.of(context)
                .pushReplacementNamed(RouteScreenName.jobsHistory);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case ActiveJobStatus.initial:
            case ActiveJobStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ActiveJobStatus.empty:
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'No active job right now',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              );
            case ActiveJobStatus.error:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.errorMessage ?? 'Something went wrong',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context
                            .read<ActiveJobBloc>()
                            .add(const RetryPressed()),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            case ActiveJobStatus.loaded:
              return _ActiveJobBody(state: state);
          }
        },
      ),
    );
  }
}

class _ActiveJobBody extends StatelessWidget {
  final ActiveJobState state;
  const _ActiveJobBody({required this.state});

  JobModel get job => state.job!;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerBar(),
          const SizedBox(height: 16),
          _customerCard(context),
          const SizedBox(height: 16),
          _progressionAndTimeline(context),
          const SizedBox(height: 16),
          _detailsCard(context),
          const SizedBox(height: 8),
          _completeSection(context),
          _reportButton(context),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.sync, size: 12, color: Colors.blue),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Manual status updates sync automatically to customer in real-time without GPS.',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _headerBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.circle, color: Colors.blue, size: 10),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Request ${job.requestNumber}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF334155),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 12,
                  color: Colors.orangeAccent,
                ),
                const SizedBox(width: 4),
                Text(
                  _statusLabel(state.jobStatus),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customerCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: const [
                  CircleAvatar(radius: 28, child: Icon(Icons.person)),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Icon(Icons.verified, size: 18, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.customerName.isEmpty ? 'Customer' : job.customerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      job.customerPhone.isEmpty
                          ? 'Phone not provided'
                          : job.customerPhone,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    job.customerArea.isEmpty
                        ? 'Address not provided'
                        : job.customerArea,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ChatButton(
                  jobId: job.id,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TechnicianChat(jobId: job.id),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _progressionAndTimeline(BuildContext context) {
    return buildCustomContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'MANUAL STATUS PROGRESSION',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              buildCustomContainer(
                cardColor: AppColors.bluenewcontainer,
                child: const Text(
                  'No GPS Required',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _stepButton(context, 1, '1. On Way',
                    Icons.check_circle_outline),
                const SizedBox(width: 6),
                _stepButton(context, 2, '2. Arrived',
                    Icons.check_circle_outline),
                const SizedBox(width: 6),
                _stepButton(context, 3, '3. In Progress',
                    Icons.play_arrow_rounded),
                const SizedBox(width: 6),
                _stepButton(context, 4, '4. Complete',
                    Icons.hourglass_empty),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.sync, size: 12, color: Colors.blue),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Manual status updates sync automatically to customer in real-time without GPS.',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(
            color: Color.fromARGB(255, 218, 231, 249),
            thickness: 1,
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Service Timeline', style: AppTextStyles.sectionHeader),
              buildCustomContainer(
                cardColor: AppColors.bluenewcontainer,
                child: Text(
                  state.jobStatus == JobStatus.completed
                      ? 'Step 5 of 5'
                      : 'Step ${state.currentStep} of 5',
                  style: const TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
          Column(children: _timelineSteps()),
        ],
      ),
    );
  }

  Widget _stepButton(
    BuildContext context,
    int index,
    String label,
    IconData icon,
  ) {
    final current = state.flowIndex;
    final isDone = index < current;
    final isCurrent = index == current;
    final isNext = index == current + 1;
    final enabled = state.isEditable && !state.isUpdating && isNext;

    final Color bg = isCurrent
        ? AppColors.primary
        : (isDone ? Colors.grey.shade200 : AppColors.bluenewcontainer);
    final Color textColor = isCurrent ? Colors.white : Colors.black;
    final Color iconColor = isCurrent
        ? Colors.white
        : (isDone ? Colors.grey : AppColors.primary);

    return ElevatedButton(
      onPressed: !enabled
          ? null
          : () {
              if (index == 4) {
                _handleComplete(context);
              } else {
                context.read<ActiveJobBloc>().add(const AdvanceStatus());
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        disabledBackgroundColor: bg,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(isDone ? Icons.check_circle_outline : icon,
                size: 24, color: iconColor),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: textColor)),
          ],
        ),
      ),
    );
  }

  List<Widget> _timelineSteps() {
    const titles = [
      'Accepted',
      'On the Way',
      'Arrived',
      'In Progress',
      'Completed',
    ];
    final c = state.jobStatus == JobStatus.completed ? 5 : state.flowIndex;

    final widgets = <Widget>[];
    for (var i = 0; i < JobStatus.flow.length; i++) {
      final status = JobStatus.flow[i];
      final done = i < c;
      final current = i == c;
      final isLast = i == JobStatus.flow.length - 1;
      final at = job.timeOf(status);

      String subtitle;
      if (!done && !current) {
        subtitle = isLast ? 'Awaiting completion sign-off' : 'Pending';
      } else {
        switch (i) {
          case 0:
            subtitle = 'Confirmed at ${_time(at)}';
            break;
          case 1:
            subtitle = 'Dispatched at ${_time(at)}';
            break;
          case 2:
            subtitle = 'Marked at ${_time(at)}';
            break;
          case 3:
            subtitle = current
                ? 'Started ${_time(at)} • Work underway'
                : 'Started ${_time(at)}';
            break;
          default:
            subtitle = 'Completed at ${_time(at ?? job.closedAt)}';
        }
      }

      if (done) {
        widgets.add(Timelinestep(
          title: titles[i],
          subtitle: subtitle,
          icon: isLast ? Icons.flag : Icons.check,
          lineColor: isLast ? Colors.transparent : AppColors.primary,
        ));
      } else if (current) {
        widgets.add(Timelinestep(
          title: i == 3 ? 'In Progress (Active)' : titles[i],
          subtitle: subtitle,
          icon: Icons.hourglass_bottom,
          lineColor: const Color(0xFFE3E6EB),
          titleColor: const Color(0xFF1456E0),
          badgeText: i == 3 ? '${state.minutesInProgress} mins' : null,
        ));
      } else {
        widgets.add(Timelinestep(
          title: titles[i],
          subtitle: subtitle,
          circleColor: const Color(0xFFE3E6EB),
          icon: isLast ? Icons.flag_outlined : Icons.schedule,
          lineColor: isLast ? Colors.transparent : const Color(0xFFE3E6EB),
          titleColor: const Color(0xFF6B7280),
        ));
      }
    }
    return widgets;
  }

  Widget _detailsCard(BuildContext context) {
    return CustomCardContainer(
      child: Column(
        children: [
          _diagnosisBox(),
          _partsHeader(context),
          const SizedBox(height: 12),
          if (job.parts.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No parts logged yet',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            )
          else
            ...job.parts.map(_partTile),
          const SizedBox(height: 20),
          _photosHeader(),
          const SizedBox(height: 12),
          _photosRow(context),
          _billingBox(),
        ],
      ),
    );
  }

  Widget _diagnosisBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF5FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.build_outlined, size: 16, color: Colors.blue),
              SizedBox(width: 6),
              Text(
                'DIAGNOSIS & SCOPE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            job.diagnosisTitle.isEmpty ? 'No diagnosis yet' : job.diagnosisTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          if (job.problemDescription.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              job.problemDescription,
              style: const TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ],
        ],
      ),
    );
  }

  Widget _partsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: Text(
            'Logged Parts & Hardware',
            style: AppTextStyles.sectionHeader,
          ),
        ),
        InkWell(
          onTap: state.isEditable && !state.isUpdating
              ? () => _addPart(context)
              : null,
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                size: 18,
                color: state.isEditable ? AppColors.primary : Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                'Add Item',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: state.isEditable
                      ? const Color(0xFF1456E0)
                      : Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _partTile(JobPart part) {
    final note = (part.note ?? '').trim();
    return buildCustomContainer(
      cardColor: AppColors.bluenewcontainer,
      child: Row(
        children: [
          const Icon(Icons.settings_outlined, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(part.name, style: AppTextStyles.cardTitle),
                const SizedBox(height: 2),
                Text(
                  'Qty: ${part.qty}${note.isEmpty ? '' : ' • $note'}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text('+ EGP ${_money(part.price)}', style: AppTextStyles.cardTitle),
        ],
      ),
    );
  }

  Future<void> _addPart(BuildContext context) async {
    final bloc = context.read<ActiveJobBloc>();
    final part = await showModalBottomSheet<JobPart>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _AddPartSheet(),
    );
    if (part != null) bloc.add(AddPartRequested(part));
  }

  Widget _photosHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Photo Verification', style: AppTextStyles.sectionHeader),
        Row(
          children: [
            Icon(
              state.photosCount == 2 ? Icons.check_circle : Icons.info_outline,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 4),
            Text(
              '${state.photosCount} of 2 Required',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1456E0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _photosRow(BuildContext context) {
    return Row(
      children: [
        _PhotoSlot(
          label: 'Before Fix',
          url: job.beforePhotoUrl,
          uploading: state.uploadingBefore,
          enabled: state.isEditable,
          onTap: () => _pickPhoto(context, true),
        ),
        const SizedBox(width: 12),
        _PhotoSlot(
          label: 'After Fix',
          url: job.afterPhotoUrl,
          uploading: state.uploadingAfter,
          enabled: state.isEditable,
          onTap: () => _pickPhoto(context, false),
        ),
      ],
    );
  }

  Future<void> _pickPhoto(BuildContext context, bool isBefore) async {
    final bloc = context.read<ActiveJobBloc>();
    final messenger = ScaffoldMessenger.of(context);

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Take a photo'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    try {
      final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        imageQuality: 60,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      bloc.add(PhotoPicked(isBefore: isBefore, bytes: bytes));
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not pick the photo: $e')),
      );
    }
  }

  Widget _billingBox() {
    return buildCustomContainer(
      cardColor: AppColors.bluenewcontainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Base Inspection & Labor',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'EGP ${_money(job.baseAmount)}',
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Logged Extra Parts',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '+EGP ${_money(job.partsAmount)}',
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Final Billing Amount',
                      style: AppTextStyles.sectionHeader,
                    ),
                    Text(
                      'Verified against labor guideline tier',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                width: 150,
                child: CustomCardContainer(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    'EGP\n${_money(job.totalAmount)}',
                    maxLines: 2,
                    style: const TextStyle(
                      height: 1.1,
                      fontSize: 24,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _completeSection(BuildContext context) {
    final hint = state.completeHint;
    return Column(
      children: [
        if (hint != null && state.isEditable)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              hint,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.redAccent),
            ),
          ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A),
              disabledBackgroundColor: const Color(0xFF94A3B8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: state.canComplete ? () => _handleComplete(context) : null,
            child: state.isCompleting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Complete Service & Generate Receipt',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Future<void> _handleComplete(BuildContext context) async {
    final bloc = context.read<ActiveJobBloc>();
    final messenger = ScaffoldMessenger.of(context);

    if (!state.canComplete) {
      messenger.showSnackBar(
        SnackBar(content: Text(state.completeHint ?? 'Cannot complete yet.')),
      );
      return;
    }

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Complete service?'),
        content: Text(
          'Final amount: EGP ${_money(job.totalAmount)}.\nThis will close the job and generate the receipt.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Complete'),
          ),
        ],
      ),
    );
    if (ok == true) bloc.add(const CompletePressed());
  }

  Widget _reportButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFF1F5F9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => _reportIssue(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 18),
            SizedBox(width: 6),
            Text(
              'Report Issue / Delay',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reportIssue(BuildContext context) async {
    final bloc = context.read<ActiveJobBloc>();
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => const _ReportDialog(),
    );
    if (reason != null) bloc.add(ReportIssueRequested(reason));
  }
}

class _ChatButton extends StatefulWidget {
  final String jobId;
  final VoidCallback onPressed;
  const _ChatButton({required this.jobId, required this.onPressed});

  @override
  State<_ChatButton> createState() => _ChatButtonState();
}

class _ChatButtonState extends State<_ChatButton> {
  late final Stream<int> _unread;

  @override
  void initState() {
    super.initState();
    Stream<int> stream;
    try {
      stream = JobsRepository().watchUnreadCount(widget.jobId);
    } catch (_) {
      stream = Stream<int>.value(0);
    }
    _unread = stream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _unread,
      initialData: 0,
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.bluenewcontainer,
            elevation: 0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.chat, size: 24, color: AppColors.primary),
                    if (count > 0)
                      Positioned(
                        right: -8,
                        top: -8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text('Chat', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PhotoSlot extends StatelessWidget {
  final String label;
  final String? url;
  final bool uploading;
  final bool enabled;
  final VoidCallback onTap;

  const _PhotoSlot({
    required this.label,
    required this.url,
    required this.uploading,
    required this.enabled,
    required this.onTap,
  });

  static final Map<String, Uint8List> _cache = {};

  bool get _hasPhoto => (url ?? '').isNotEmpty;

  Widget _image() {
    final value = url ?? '';
    if (value.isEmpty) {
      return Container(
        color: const Color(0xFFE2E8F0),
        child: const Icon(
          Icons.add_a_photo_outlined,
          color: Colors.grey,
          size: 32,
        ),
      );
    }
    Widget broken() => Container(
          color: const Color(0xFFE2E8F0),
          child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
        );

    if (value.startsWith('data:image')) {
      try {
        final bytes = _cache.putIfAbsent(
          value,
          () => base64Decode(value.substring(value.indexOf(',') + 1)),
        );
        return Image.memory(
          bytes,
          fit: BoxFit.cover,
          gaplessPlayback: true,
          errorBuilder: (_, __, ___) => broken(),
        );
      } catch (_) {
        return broken();
      }
    }
    return Image.network(
      value,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => broken(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: enabled && !uploading ? onTap : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _image(),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 8,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 8,
                  child: uploading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          _hasPhoto ? Icons.check_circle : Icons.add_circle,
                          size: 18,
                          color: const Color(0xFF1456E0),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddPartSheet extends StatefulWidget {
  const _AddPartSheet();

  @override
  State<_AddPartSheet> createState() => _AddPartSheetState();
}

class _AddPartSheetState extends State<_AddPartSheet> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _qty = TextEditingController(text: '1');
  final _price = TextEditingController();
  final _note = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _qty.dispose();
    _price.dispose();
    _note.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final note = _note.text.trim();
    Navigator.pop(
      context,
      JobPart(
        name: _name.text.trim(),
        qty: int.parse(_qty.text.trim()),
        price: double.parse(_price.text.trim()),
        note: note.isEmpty ? null : note,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Item', style: AppTextStyles.sectionHeader),
              const SizedBox(height: 12),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Part name'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Enter the part name'
                    : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _qty,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Qty'),
                      validator: (v) {
                        final n = int.tryParse((v ?? '').trim());
                        return (n == null || n < 1) ? 'Qty >= 1' : null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _price,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Total price (EGP)',
                      ),
                      validator: (v) {
                        final n = double.tryParse((v ?? '').trim());
                        return (n == null || n <= 0)
                            ? 'Enter a valid price'
                            : null;
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _note,
                decoration: const InputDecoration(
                  labelText: 'Note (optional)',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportDialog extends StatefulWidget {
  const _ReportDialog();

  @override
  State<_ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<_ReportDialog> {
  static const _options = [
    'Customer not available',
    'Delay',
    'Wrong address',
    'Other',
  ];

  String _selected = _options.first;
  final _other = TextEditingController();

  @override
  void dispose() {
    _other.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Report Issue / Delay'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final option in _options)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: Icon(
                  _selected == option
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: AppColors.primary,
                ),
                title: Text(option),
                onTap: () => setState(() => _selected = option),
              ),
            if (_selected == 'Other')
              TextField(
                controller: _other,
                decoration: const InputDecoration(
                  hintText: 'Describe the issue',
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final text = _other.text.trim();
            if (_selected == 'Other' && text.isEmpty) return;
            Navigator.pop(
              context,
              _selected == 'Other' ? 'Other: $text' : _selected,
            );
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}
