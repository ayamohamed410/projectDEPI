import 'package:flutter/material.dart';

class CoreServicesGrid extends StatelessWidget {
  final String query;
  const CoreServicesGrid({super.key, this.query = ''});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'Plumbing',
        'subtitle': 'Pipes &\nFixtures',
        'price': 'From EGP 150',
        'icon': Icons.plumbing,
      },
      {
        'title': 'AC & Cooling',
        'subtitle': 'Freon &\nRepair',
        'price': 'From EGP 300',
        'icon': Icons.ac_unit,
      },
      {
        'title': 'Electrical',
        'subtitle': 'Wiring &\nBreakers',
        'price': 'From EGP 180',
        'icon': Icons.electrical_services,
      },
      {
        'title': 'Painting',
        'subtitle': 'Touch-up &\nWalls',
        'price': 'From EGP 300',
        'icon': Icons.format_paint,
      },
      {
        'title': 'Carpentry',
        'subtitle': 'Doors &\nLocks',
        'price': 'From EGP 160',
        'icon': Icons.chair,
      },
      {
        'title': 'Appliances',
        'subtitle': 'Washers &\nOvens',
        'price': 'From EGP 200',
        'icon': Icons.local_laundry_service,
      },
    ];

    final results = services.where((service) {
      final queryText = query.trim().toLowerCase();
      if (queryText.isEmpty) return true;
      return ('${service['title']} ${service['subtitle']}').toLowerCase().contains(queryText);
    }).toList();
    if (results.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: Text('No matching services found.')),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final service = results[index];
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
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
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
                        color: Colors.blue,
                      ),
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
