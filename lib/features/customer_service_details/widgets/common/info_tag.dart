import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InfoTag extends StatelessWidget {
  const InfoTag({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: ColorsApp.blueColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 9, color: ColorsApp.primaryColor),
      ),
    );
  }
}
