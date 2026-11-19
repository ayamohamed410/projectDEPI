import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, size: 21),
            color: ColorsApp.primaryColor,
          ),
          const Expanded(
            child: Text(
              'Rating & Review',
              style: TextStyle(
                color: ColorsApp.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: ColorsApp.primaryColor,
              child: Icon(
                Icons.person_outline,
                color: ColorsApp.whiteColor,
                size: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
