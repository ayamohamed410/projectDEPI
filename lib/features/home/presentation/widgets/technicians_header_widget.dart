import 'package:flutter/material.dart';

class TechniciansHeaderWidget extends StatelessWidget {
  const TechniciansHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Available Technicians',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Icon(Icons.tune, color: Color(0xFF1D4ED8), size: 20),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: const [
            Icon(Icons.location_on_outlined, size: 12, color: Colors.grey),
            SizedBox(width: 4),
            Text(
              '12 certified plumbers near Fifth Settlement',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              _SortChip(label: 'Recommended', isSelected: true),
              SizedBox(width: 8),
              _SortChip(label: 'Highest Rated', isSelected: false),
              SizedBox(width: 8),
              _SortChip(label: 'Nearest', isSelected: false),
            ],
          ),
        ),
      ],
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _SortChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFF0F172A) : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
