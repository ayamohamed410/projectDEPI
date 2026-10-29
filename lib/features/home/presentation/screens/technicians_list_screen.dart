import 'package:flutter/material.dart';
import '../widgets/technicians_header_widget.dart';
import '../widgets/technician_card_widget.dart';

class TechniciansListScreen extends StatelessWidget {
  const TechniciansListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Book Service',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black54),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TechniciansHeaderWidget(),
            SizedBox(height: 16),
            TechnicianCardWidget(
              name: 'Mahmoud El-Sayed',
              role: 'Master Plumber',
              experience: '12 yrs exp',
              rating: '4.9',
              reviewsCount: '184',
              distance: '2.4 km',
              eta: '15m ETA',
              price: 'EGP 400',
              statusText: 'Available Now',
              statusColor: Color(0xFF1D4ED8),
              isElite: true,
            ),
            TechnicianCardWidget(
              name: 'Ibrahim Hassan',
              role: 'Plumbing & Water Heaters',
              experience: '8 yrs exp',
              rating: '4.8',
              reviewsCount: '96',
              distance: '3.8 km',
              eta: '25m ETA',
              price: 'EGP 350',
              statusText: 'At 2:00 PM',
              statusColor: Color(0xFF1D4ED8),
              isElite: false,
            ),
            TechnicianCardWidget(
              name: 'Hany Farouk',
              role: 'General Pipe Fitting & Drain Repair',
              experience: '5 yrs exp',
              rating: '4.7',
              reviewsCount: '72',
              distance: '5.1 km',
              eta: '5.1 km away',
              price: 'EGP 380',
              statusText: 'Available Today',
              statusColor: Color(0xFF1D4ED8),
              isElite: false,
            ),
          ],
        ),
      ),
    );
  }
}
