
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/technician_signup_data.dart';

class TechnicianSpecializationField extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const TechnicianSpecializationField({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    this.errorText,
  });


  static const List<IconData> specializationIcons = [
    Icons.plumbing_rounded,
    Icons.bolt_rounded,
    Icons.ac_unit_rounded,
    Icons.handyman_rounded,
    Icons.format_paint_rounded,
    Icons.build_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          initialValue: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: 'Choose your specialization',
            hintStyle: const TextStyle(
              color: ColorsApp.greyColor,
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.build_rounded,
              color: ColorsApp.greylight,
            ),
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ColorsApp.greylight,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFD7E2F0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: ColorsApp.primaryColor,
                width: 1.5,
              ),
            ),
          ),
          items: TechnicianSignupData.specializations.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            TechnicianSignupData.specializations.length,
                (index) {
              final specialization =
              TechnicianSignupData.specializations[index];

              final isSelected = selectedValue == specialization;

              return ChoiceChip(
                avatar: Icon(
                  specializationIcons[index],
                  size: 18,
                  color: isSelected ? Colors.white : ColorsApp.primaryColor,
                ),
                label: Text(
                  specialization,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF526B8A),
                  ),
                ),
                selected: isSelected,
                showCheckmark: false,
                selectedColor: ColorsApp.primaryColor,
                backgroundColor: const Color(0xFFF2F6FB),
                side: BorderSide(
                  color: isSelected
                      ? ColorsApp.primaryColor
                      : const Color(0xFFF2F6FB),
                ),
                shape: const StadiumBorder(),
                onSelected: (_) => onChanged(specialization),
              );
            },
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
