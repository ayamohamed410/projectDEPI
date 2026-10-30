// Reusable details card
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final Widget child;
  final Color color;

  const DetailsCard({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }
}
