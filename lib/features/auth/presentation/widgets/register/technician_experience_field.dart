
import 'package:flutter/material.dart';


import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/technician_signup_data.dart';

class TechnicianExperienceField extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const TechnicianExperienceField({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          initialValue: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: 'Select your experience level',
            hintStyle: const TextStyle(
              color: ColorsApp.greyColor
              ,
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.calendar_month_outlined,
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
                color: ColorsApp.greyTextField,
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
          items: TechnicianSignupData.experienceLevels.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
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
