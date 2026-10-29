import 'package:flutter/material.dart';

class ServiceCategoriesRow extends StatelessWidget {
  const ServiceCategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          _CategoryChip(
            icon: Icons.plumbing,
            label: 'Plumbing',
            isSelected: true,
          ),
          SizedBox(width: 8),
          _CategoryChip(
            icon: Icons.electrical_services,
            label: 'Electrical',
            isSelected: false,
          ),
          SizedBox(width: 8),
          _CategoryChip(icon: Icons.ac_unit, label: 'HVAC', isSelected: false),
          SizedBox(width: 8),
          _CategoryChip(
            icon: Icons.format_paint,
            label: 'Painting',
            isSelected: false,
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _CategoryChip({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.black87,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
