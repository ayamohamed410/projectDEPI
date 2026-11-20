import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CancelRequestButton extends StatelessWidget {
  const CancelRequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 12, color: ColorsApp.greyColor),
            SizedBox(width: 5),
            Text(
              'Cancellation is free before technician arrival.',
              style: TextStyle(fontSize: 9, color: ColorsApp.greyColor),
            ),
          ],
        ),

        const SizedBox(height: 9),

        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.cancel_outlined, size: 15),
            label: const Text('Cancel Request', style: TextStyle(fontSize: 12)),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsApp.blueColor,
              foregroundColor: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
