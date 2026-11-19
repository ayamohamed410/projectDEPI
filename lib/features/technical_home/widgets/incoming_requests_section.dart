import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/technical_home/widgets/request_card.dart';
import 'package:flutter/material.dart';

class IncomingRequestsSection extends StatelessWidget {
  const IncomingRequestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Row(
          children: [
            Text(
              'Incoming Requests',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: ColorsApp.primaryColor,
              ),
            ),
            SizedBox(width: 9),
            CircleAvatar(
              radius: 10,
              backgroundColor: ColorsApp.blueColor,
              child: Text(
                '1',
                style: TextStyle(fontSize: 11, color: ColorsApp.primaryColor),
              ),
            ),
            Spacer(),
            Text(
              'Review Inbox ›',
              style: TextStyle(
                fontSize: 13,
                color: ColorsApp.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        RequestCard(),
      ],
    );
  }
}
