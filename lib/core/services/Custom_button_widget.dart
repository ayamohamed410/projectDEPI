import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';


class CustomButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color sideColor;
  final Color textColor;
  final String? icon;
  final double? height;

  const CustomButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor = ColorsApp.primaryColor,
    this.sideColor = Colors.transparent,
    this.textColor = ColorsApp.whiteColor,
    this.icon,
    this.height = 65,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: size.width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: sideColor,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Image.asset(
                  icon!,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 12),
              ],
              Text(
                buttonText,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

