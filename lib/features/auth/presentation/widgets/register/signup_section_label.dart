
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class SignupSectionLabel extends StatelessWidget {
  final String title;

  const SignupSectionLabel({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: ColorsApp.primaryColor,
        ),
      ),
    );
  }
}
