import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/home/presentation/widgets/details_card.dart';
import 'package:final_depi/features/home/presentation/widgets/section_row_title.dart';
import 'package:flutter/material.dart';

const Color detailsBlue = Color(0xff17233F);
const Color detailsBackground = Color(0xffF5F7FC);

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: detailsBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 18),
        ),
        title: const Text(
          'Request Details',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: detailsBlue,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: detailsBlue,
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Request status
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xffFFF4DC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xffF1D99C)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.access_time, color: Color(0xffA66A00)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Accept within 01:44:30 to secure this job',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xff8A5A00),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Request information
            DetailsCard(
              color: Colors.white,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Water Heater Element Sparking & Rapid Cutoff',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: detailsBlue,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: [
                      DetailsTag(label: 'Plumbing'),
                      DetailsTag(label: 'Water Heaters'),
                      DetailsTag(label: 'High Urgency'),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Row(
                    children: [
                      Icon(Icons.person_outline, size: 17),
                      SizedBox(width: 6),
                      Text(
                        'Customer: Fatima Hassan',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  const Row(
                    children: [
                      Icon(Icons.access_time, size: 17),
                      SizedBox(width: 6),
                      Text(
                        'Requested Today • ASAP',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Customer description
            const DetailsCard(
              color: ColorsApp.blue,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    icon: Icons.description_outlined,
                    title: 'Customer Description',
                  ),
                  SizedBox(height: 10),
                  Text(
                    '"The electric water heater in the master bathroom '
                    'clicked loudly, sparked near the bottom heating '
                    'flange, and tripped the circuit breaker. Needs '
                    'urgent inspection and replacement if necessary."',
                    style: TextStyle(fontSize: 12, height: 1.6),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Customer photos
            DetailsCard(
              color: Colors.white,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    icon: Icons.photo_library_outlined,
                    title: 'Customer Photos (2 Attached)',
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset("assets/images/damadge2.png"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Image.asset("assets/images/damadge1.png"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // *******************Location*************************
            DetailsCard(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    icon: Icons.location_on_outlined,
                    title: 'Location & Proximity',
                  ),
                  const SizedBox(height: 10),

                  //********************map******************** */
                  Container(
                    height: 145,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffE5EAD9),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Icon(
                      Icons.map_outlined,
                      size: 75,
                      color: Color(0xffA7B49A),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Fifth Settlement, District 3, New Cairo',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Requested Immediately • Today (ASAP)',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Payment estimate
            DetailsCard(
              color: ColorsApp.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    icon: Icons.payments_outlined,
                    title: 'Payout Estimate',
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Estimated Technician Earnings',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'EGP 450 – 700',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: detailsBlue,
                    ),
                  ),

                  const Divider(height: 22),

                  const PaymentRow(
                    title: 'Standard Diagnostic & Labor Fee',
                    amount: 'EGP 300',
                  ),

                  const SizedBox(height: 9),

                  const PaymentRow(
                    title: 'Estimated Parts / Materials',
                    amount: 'EGP 150 – 400',
                  ),

                  const SizedBox(height: 9),

                  const PaymentRow(
                    title: 'Customer Budget',
                    amount: 'EGP 450 – 700',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),

      // Accept button
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                //*******************اظهار رساله  */
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Request accepted successfully!'),
                  ),
                );
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text(
                'Accept Request & Claim Job',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: detailsBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Tags
class DetailsTag extends StatelessWidget {
  final String label;

  const DetailsTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xffEDF3FC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, color: detailsBlue),
      ),
    );
  }
}

// Photo placeholder
class PhotoPlaceholder extends StatelessWidget {
  final IconData icon;
  final String label;

  const PhotoPlaceholder({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xffE9EDF4),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: Colors.blueGrey),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}

// Payment row
class PaymentRow extends StatelessWidget {
  final String title;
  final String amount;

  const PaymentRow({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: detailsBlue,
          ),
        ),
      ],
    );
  }
}
