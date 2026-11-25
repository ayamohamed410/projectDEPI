import 'package:flutter/material.dart';

import 'package:final_depi/features/jobs/job_model.dart';
import 'package:final_depi/features/jobs/jobs_repository.dart';

const Color detailsBlue = Color(0xff17233F);
const Color detailsBackground = Color(0xffF5F7FC);

class RequestDetailsScreen extends StatefulWidget {
  final JobModel job;

  const RequestDetailsScreen({super.key, required this.job});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  bool _isAccepting = false;

  Future<void> _acceptRequest() async {
    if (_isAccepting) return;

    setState(() => _isAccepting = true);

    try {
      await JobsRepository().acceptJob(widget.job.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Request accepted successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not accept request: $e'),
          backgroundColor: Colors.red,
        ),
      );

      setState(() => _isAccepting = false);
    }
  }

  String _dateText(DateTime? date) {
    if (date == null) return 'Date not available';
    return '${date.day}/${date.month}/${date.year}';
  }

  String _moneyText(double amount) {
    if (amount <= 0) return 'Not specified';
    return 'EGP ${amount.toStringAsFixed(0)}';
  }

  Future<void> _showDeclineNotice() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Decline action needs a separate rejection status.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.job;

    return Scaffold(
      backgroundColor: detailsBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          color: detailsBlue,
        ),
        title: const Text(
          'Request Details',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: detailsBlue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.diagnosisTitle,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: detailsBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _infoRow(
                    Icons.confirmation_number_outlined,
                    'Request: ${job.requestNumber.isEmpty ? job.id : job.requestNumber}',
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    Icons.person_outline,
                    'Customer: ${job.customerName.isEmpty ? 'Not provided' : job.customerName}',
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    Icons.location_on_outlined,
                    'Location: ${job.customerArea.isEmpty ? 'Not provided' : job.customerArea}',
                  ),
                  const SizedBox(height: 8),
                  _infoRow(
                    Icons.access_time,
                    'Requested: ${_dateText(job.createdAt)}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _infoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Customer Description',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: detailsBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    job.problemDescription.isEmpty
                        ? 'No description provided.'
                        : job.problemDescription,
                    style: const TextStyle(fontSize: 12, height: 1.6),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _infoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payout Estimate',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: detailsBlue,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _paymentRow('Base Amount', _moneyText(job.baseAmount)),
                  const SizedBox(height: 10),
                  _paymentRow('Parts Amount', _moneyText(job.partsAmount)),
                  const Divider(height: 22),
                  _paymentRow(
                    'Customer Budget',
                    _moneyText(job.totalAmount),
                    bold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _infoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Customer Contact',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: detailsBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _infoRow(
                    Icons.phone_outlined,
                    job.customerPhone.isEmpty
                        ? 'Phone number not provided'
                        : job.customerPhone,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isAccepting ? null : _showDeclineNotice,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    minimumSize: const Size(0, 48),
                  ),
                  child: const Text('Decline'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: _isAccepting ? null : _acceptRequest,
                  icon: _isAccepting
                      ? const SizedBox(
                          width: 17,
                          height: 17,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.check_circle_outline),
                  label: Text(_isAccepting ? 'Accepting...' : 'Accept Request'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: detailsBlue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 48),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 17, color: Colors.blueGrey),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
      ],
    );
  }

  Widget _paymentRow(String title, String amount, {bool bold = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 12,
            color: detailsBlue,
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
