import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomerActionsSection extends StatelessWidget {
  const CustomerActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsApp.primaryColor,
              foregroundColor: ColorsApp.whiteColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            icon: const Icon(Icons.star_rounded, size: 18),
            label: const Text(
              'Rate Your Experience',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _SecondaryActionButton(
                icon: Icons.download_outlined,
                label: 'Download PDF',
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _SecondaryActionButton(
                icon: Icons.add_circle_outline,
                label: 'Book Another',
                onPressed: () {},
              ),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.support_agent, size: 15),
          label: const Text(
            'Contact 24/7 Dedicated Support',
            style: TextStyle(fontSize: 11),
          ),
          style: TextButton.styleFrom(foregroundColor: ColorsApp.accentBlue),
        ),
      ],
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDCE8FF),
          foregroundColor: ColorsApp.primaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
        icon: Icon(icon, size: 14),
        label: Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
