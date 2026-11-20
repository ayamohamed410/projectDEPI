/*


import 'package:flutter/material.dart';

import 'container.dart';
import '/core/theme/app_styles.dart';

class Jobcard extends StatelessWidget {
  Jobcard({
    super.key,
    required this.varid,
    required this.vardateTime,
    required this.varpayout,
    required this.varname,
    required this.varcompleted,
    required this.vartitel,
    required this.varrating,
    required this.varlocation,
    required this.varview,



  });
  String varid;
  DateTime vardateTime;
  String varcompleted;
  String varview;
  String vartitel;
  String varname;
  String varlocation;
  int varpayout;
  int varrating;

  @override
  Widget build(BuildContext context) {
    return buildCustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$varid", style: AppCardStyles.viewOrder),
              Text("$vardateTime", style: AppCardStyles.dateTime),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.bluenewcontainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 16),
                    SizedBox(width: 4),
                    Text("$varcompleted", style: AppCardStyles.viewOrder),
                  ],
                ),
              ),
            ],
          ),
          Text("$vartitel", style: AppCardStyles.jobTitle),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.backgroundLightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.iconbluebg,
                      radius: 20,
                      child: Icon(Icons.person, size: 18),
                    ),
                    SizedBox(width: 12),
                    Column(
                      children: [
                        Text("$varname", style: AppCardStyles.clientName),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "$varlocation",
                              style: AppCardStyles.locationText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.chat_bubble_outline,
                        size: 12,
                        color: AppColors.accentBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.softBlueTint,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rate,
                      size: 18,
                      color: AppColors.activeBadge,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "$varrating",
                      style: TextStyle(
                        color: AppColors.activeBadge,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text("Rating", style: AppCardStyles.payoutLabel),
                  ],
                ),
              ),
              Column(
                children: [
                  Text("Net Payout"),
                  Text("$varpayout", style: AppCardStyles.payoutAmount),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.description_outlined, color: AppColors.accentBlue),
                  Text("$varview", style: AppCardStyles.viewOrder),
                ],
              ),
              Icon(Icons.arrow_back, color: AppColors.textSecondary),
            ],
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../jobs/job_model.dart';

class Jobcard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;
  final VoidCallback? onChatTap;
  final VoidCallback? onViewWorkOrder;
  final VoidCallback? onViewIncidentLog;

  const Jobcard({
    super.key,
    required this.job,
    this.onTap,
    this.onChatTap,
    this.onViewWorkOrder,
    this.onViewIncidentLog,
  });

  @override
  Widget build(BuildContext context) {
    final isCancelled = job.isCancelled;
    final isDisputed = job.isDisputed;
    final isCompleted = job.isCompleted;

    final customerName = job.customerName.isEmpty ? 'Customer' : job.customerName;
    final hasArea = job.customerArea.isNotEmpty;

    final dateToFormat = job.closedAt ?? job.createdAt ?? DateTime.now();
    final formattedDate = DateFormat('MMM d, yyyy • h:mm a').format(dateToFormat);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Request Number & Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  job.requestNumber.isEmpty ? '#7H-0000' : job.requestNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0066FF),
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusBadge(isCompleted, isCancelled, isDisputed),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Diagnosis Title
            Text(
              job.diagnosisTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Middle Container (Customer details or Cancellation box)
            if (isCancelled)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info_outline, size: 18, color: Colors.blueGrey),
                        const SizedBox(width: 8),
                        const Text(
                          'Dispatched cancellation protection',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Fee Credited', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        Text(
                          'EGP ${job.cancellationFee?.toStringAsFixed(0) ?? '0'}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      radius: 20,
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customerName,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          if (hasArea) ...[
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 12, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  job.customerArea,
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (onChatTap != null)
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF0066FF)),
                        onPressed: onChatTap,
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 12),

            // Bottom Row: Rating / Payout & Action Link
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isCancelled)
                  InkWell(
                    onTap: onViewIncidentLog,
                    child: Row(
                      children: const [
                        Icon(Icons.visibility_outlined, size: 16, color: Color(0xFF0066FF)),
                        SizedBox(width: 4),
                        Text(
                          'View Incident Log',
                          style: TextStyle(color: Color(0xFF0066FF), fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  )
                else ...[
                  _buildRatingPill(job),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Net Payout', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Text(
                        'EGP ${job.netPayout.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ],
            ),

            if (!isCancelled) ...[
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onViewWorkOrder,
                    child: Row(
                      children: const [
                        Icon(Icons.description_outlined, size: 16, color: Color(0xFF0066FF)),
                        SizedBox(width: 4),
                        Text(
                          'View Work Order',
                          style: TextStyle(color: Color(0xFF0066FF), fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isCompleted, bool isCancelled, bool isDisputed) {
    if (isCancelled) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Cancelled by Customer',
          style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      );
    }
    if (isDisputed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Disputed',
          style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      );
    }
    if (job.customerSigned) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Completed & Signed',
          style: TextStyle(color: Color(0xFF0066FF), fontSize: 10, fontWeight: FontWeight.bold),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Completed',
        style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRatingPill(JobModel job) {
    if (job.rating == null) return const SizedBox.shrink();
    if (job.customerSigned && job.reviewText != null && job.reviewText!.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.star, size: 14, color: Colors.amber),
            const SizedBox(width: 4),
            Text(
              job.rating!.toStringAsFixed(1),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(width: 4),
            Text(
              '"${job.reviewText}"',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, size: 14, color: Colors.amber),
          const SizedBox(width: 4),
          Text(
            '${job.rating!.toStringAsFixed(1)} Rating',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}