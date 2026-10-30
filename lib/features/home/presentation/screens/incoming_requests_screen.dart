import 'package:flutter/material.dart';
import 'request_details_screen.dart';

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
        leading: const Icon(Icons.arrow_back_ios, size: 18),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // New / All filter
            Container(
              padding: const EdgeInsets.all(4),
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
                      child: const Text(
                        'New (3)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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

            // Filters
            const Wrap(
              spacing: 7,
              runSpacing: 8,
              children: [
                RequestFilter(label: 'Plumbing Specialty'),
                RequestFilter(label: 'Urgency: High'),
                RequestFilter(label: 'Urgency: Medium'),
              ],
            ),

            const SizedBox(height: 16),

            const RequestCard(
              status: 'URGENT DISPATCH • 4H AGO',
              distance: '1.8 km',
              title: 'Water Heater Element Sparking & Shutoff',
              category: 'Plumbing / Water Heaters',
              customer: 'Fatima Hassan, District 3',
              time: 'Estimated You: ASAP',
              price: 'EGP 450 – 700',
              isUrgent: true,
            ),

            const SizedBox(height: 12),

            const RequestCard(
              status: 'STANDARD • 12H AGO',
              distance: '3.2 km',
              title: 'Bathroom Mixer Tap Seepage & Low Pressure',
              category: 'Plumbing / Fixtures',
              customer: 'Youssef Salah, Cairo',
              time: 'Scheduled: Tomorrow',
              price: 'EGP 300 – 480',
              isUrgent: false,
            ),

            const SizedBox(height: 12),

            Opacity(
              opacity: 0.55,
              child: const RequestCard(
                status: 'CLAIMED BY ANOTHER PRO',
                distance: '5.1 km',
                title: 'Main Drainage Pipe Blockage',
                category: 'Plumbing / Drainage',
                customer: 'Mohamed Ali, New Cairo',
                time: 'Request already assigned',
                price: 'EGP 350 – 500',
                isUrgent: false,
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'You are all caught up!',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Filter chip
class RequestFilter extends StatelessWidget {
  final String label;

  const RequestFilter({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, color: primaryBlue),
      ),
    );
  }
}

// Request card
class RequestCard extends StatelessWidget {
  final String status;
  final String distance;
  final String title;
  final String category;
  final String customer;
  final String time;
  final String price;
  final bool isUrgent;

  const RequestCard({
    super.key,
    required this.status,
    required this.distance,
    required this.title,
    required this.category,
    required this.customer,
    required this.time,
    required this.price,
    required this.isUrgent,
  });

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
              Icon(
                Icons.circle,
                size: 8,
                color: isUrgent ? Colors.red : Colors.blue,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: isUrgent ? Colors.red : Colors.blue,
                  ),
                ),
              ),
              const Icon(Icons.location_on_outlined, size: 13),
              Text(distance, style: const TextStyle(fontSize: 10)),
            ],
          ),

          const Divider(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/technician.png"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category,
                      style: const TextStyle(fontSize: 10, color: Colors.blue),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      customer,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: lightBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Estimated You / Visit',
                      style: TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Customer Budget',
                      style: TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryBlue,
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text('Decline', style: TextStyle(fontSize: 11)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequestDetailsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    'View Request Details  ›',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
