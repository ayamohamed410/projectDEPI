import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../common/section_card.dart';
import '../common/section_heading.dart';

class DigitalReceiptSection extends StatelessWidget {
  const DigitalReceiptSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            icon: Icons.receipt_long_outlined,
            title: 'Digital Receipt',
            trailing: Text(
              'EGP (Egyptian Pound)',
              style: TextStyle(fontSize: 9, color: ColorsApp.secondaryText),
            ),
          ),
          const SizedBox(height: 14),
          const ReceiptRow(
            label: 'Inspection & Diagnostic Fee',
            value: 'EGP 100',
          ),
          const ReceiptRow(label: 'Labor & Repair Service', value: 'EGP 250'),
          const ReceiptRow(label: 'Brass Compression Valve', value: 'EGP 120'),
          const ReceiptRow(
            label: 'Elite Concierge Discount',
            value: '- EGP 50',
            valueColor: ColorsApp.accentBlue,
          ),
          const SizedBox(height: 8),
          const _PaymentSummary(),
        ],
      ),
    );
  }
}

class ReceiptRow extends StatelessWidget {
  const ReceiptRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor = ColorsApp.secondaryText,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: ColorsApp.secondaryText,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              color: valueColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentSummary extends StatelessWidget {
  const _PaymentSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorsApp.blueColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Total Paid',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ColorsApp.primaryColor,
                  ),
                ),
              ),
              Text(
                'EGP 420',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: ColorsApp.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Icon(
                Icons.money_off_csred_outlined,
                size: 13,
                color: ColorsApp.secondaryText,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  'Cash',
                  style: TextStyle(fontSize: 9, color: ColorsApp.secondaryText),
                ),
              ),
              Icon(
                Icons.check_circle_outline,
                size: 12,
                color: ColorsApp.accentBlue,
              ),
              SizedBox(width: 3),
              Text(
                'Confirmed',
                style: TextStyle(fontSize: 9, color: ColorsApp.accentBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
