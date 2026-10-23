import 'package:flutter/material.dart';

void main() {
  runApp(const HelhalyApp());
}

class HelhalyApp extends StatelessWidget {
  const HelhalyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '7elhaly - حلّالي',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FD),
        primarySwatch: Colors.blue,
        fontFamily: 'sans-serif',
      ),
      home: const CustomerHomeScreen(),
    );
  }
}

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
              const _CustomAppBar(),
              const SizedBox(height: 16),
              const _LocationAndTierRow(),
              const SizedBox(height: 12),
              const _WelcomeHeader(),
              const SizedBox(height: 16),
              const _AiSmartTriageBanner(),
              const SizedBox(height: 16),
              const _SearchBarAndFilter(),
              const SizedBox(height: 16),
              const _InProgressCard(),
              const SizedBox(height: 24),
              const _SectionHeader(
                  title: 'Core Home Services', actionText: 'View All >'),
              const SizedBox(height: 12),
              const _CoreServicesGrid(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _CustomBottomNavBar(),
    );
  }
}

// 1. App Bar Component
class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.home, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              'Client Home',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: Colors.black87),
              onPressed: () {},
            ),
            const SizedBox(width: 4),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.black,
                child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// 2. Location and Tier Row
class _LocationAndTierRow extends StatelessWidget {
  const _LocationAndTierRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.blue, size: 18),
            const SizedBox(width: 4),
            const Text(
              'New Cairo, Fifth Settlement',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down,
                size: 18, color: Colors.black54),
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

// 3. Welcome Header
class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              'Good morning, Tarek ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text('👋', style: TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 2),
        const Text(
          'What needs fixing in your home today?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// 4. AI Smart Triage Banner
class _AiSmartTriageBanner extends StatelessWidget {
  const _AiSmartTriageBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                    SizedBox(width: 4),
                    Text(
                      'AI SMART TRIAGE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.flash_on, color: Colors.blueAccent, size: 18),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Describe Your Problem with AI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Instant issue diagnosis, required parts forecast & upfront price estimates',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D4ED8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.auto_awesome, size: 16),
                  label: const Text('Describe Issue',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt_outlined,
                      color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 5. Search Bar and Filter
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

// 6. In Progress Card
class _InProgressCard extends StatelessWidget {
  const _InProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  CircleAvatar(radius: 4, backgroundColor: Colors.blue),
                  SizedBox(width: 6),
                  Text(
                    'IN PROGRESS',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.near_me, size: 10, color: Colors.blue),
                    SizedBox(width: 4),
                    Text(
                      'ETA 15 mins',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Living Room AC\nLeaking',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Request #7H-9482 • Carrier Split\n2.25HP',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Technician En\nRoute 🚀',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.indigo,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Ahmed Kamal',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.verified, color: Colors.blue, size: 12),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 12),
                      SizedBox(width: 2),
                      Text('4.9 ',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold)),
                      Text('(184 jobs)',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade100,
                child: const Icon(Icons.phone, color: Colors.blue, size: 16),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF1D4ED8),
                child: const Icon(Icons.map, color: Colors.white, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 7. Section Header
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

// 8. Core Services Grid
class _CoreServicesGrid extends StatelessWidget {
  const _CoreServicesGrid();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'Plumbing',
        'subtitle': 'Pipes &\nFixtures',
        'price': 'From EGP 150',
        'icon': Icons.plumbing
      },
      {
        'title': 'AC & Cooling',
        'subtitle': 'Freon &\nRepair',
        'price': 'From EGP 300',
        'icon': Icons.ac_unit
      },
      {
        'title': 'Electrical',
        'subtitle': 'Wiring &\nBreakers',
        'price': 'From EGP 180',
        'icon': Icons.electrical_services
      },
      {
        'title': 'Painting',
        'subtitle': 'Touch-up &\nWalls',
        'price': 'From EGP 300',
        'icon': Icons.format_paint
      },
      {
        'title': 'Carpentry',
        'subtitle': 'Doors &\nLocks',
        'price': 'From EGP 160',
        'icon': Icons.chair
      },
      {
        'title': 'Appliances',
        'subtitle': 'Washers &\nOvens',
        'price': 'From EGP 200',
        'icon': Icons.local_laundry_service
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final service = services[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(service['icon'], color: Colors.blue, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      service['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      service['subtitle'],
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service['price'],
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// 9. Bottom Navigation Bar
class _CustomBottomNavBar extends StatelessWidget {
  const _CustomBottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _NavBarItem(icon: Icons.home, label: 'Home', isSelected: true),
          _NavBarItem(
              icon: Icons.description_outlined,
              label: 'Requests',
              isSelected: false),
          _NavBarItem(
              icon: Icons.chat_bubble_outline,
              label: 'Messages',
              isSelected: false),
          _NavBarItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              isSelected: false),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavBarItem(
      {required this.icon, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.blue : Colors.grey;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
