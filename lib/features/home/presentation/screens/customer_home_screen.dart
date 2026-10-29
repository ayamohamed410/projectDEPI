import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/ai_triage_banner.dart';
import '../widgets/in_progress_card.dart';
import '../widgets/core_services_grid.dart';
import '../widgets/custom_bottom_nav.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 16),
              const _LocationAndTierRow(),
              const SizedBox(height: 12),
              const _WelcomeHeader(),
              const SizedBox(height: 16),
              const AiSmartTriageBanner(),
              const SizedBox(height: 16),
              const _SearchBarAndFilter(),
              const SizedBox(height: 16),
              const InProgressCard(),
              const SizedBox(height: 24),
              const _SectionHeader(
                title: 'Core Home Services',
                actionText: 'View All >',
              ),
              const SizedBox(height: 12),
              const CoreServicesGrid(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

class _LocationAndTierRow extends StatelessWidget {
  const _LocationAndTierRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.location_on, color: Colors.blue, size: 18),
            SizedBox(width: 4),
            Text(
              'New Cairo, Fifth Settlement',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black54),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: const [
              Icon(Icons.verified, size: 12, color: Colors.indigo),
              SizedBox(width: 4),
              Text(
                'Elite Tier',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Row(
          children: [
            Text(
              'Good morning, Shahd ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text('👋', style: TextStyle(fontSize: 20)),
          ],
        ),
        SizedBox(height: 2),
        Text(
          'What needs fixing in your home today?',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    );
  }
}

class _SearchBarAndFilter extends StatelessWidget {
  const _SearchBarAndFilter();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search plumber, AC repair, electrici...',
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.tune, color: Color(0xFF1D4ED8)),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;

  const _SectionHeader({required this.title, required this.actionText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          actionText,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
