import 'package:flutter/material.dart';

import 'container.dart';
import '/core/theme//app_styles.dart';

class Jobcard extends StatelessWidget {
  Jobcard({
    super.key,
    required this.varid,
    required this.vardateTime,
    required this.varpayout,
    required this.varname,
    required this.varcompleted,
    required this.vartitel,
    required this.varrating,
    required this.varlocation,
    required this.varview,
  });
  String varid;
  DateTime vardateTime;
  String varcompleted;
  String varview;
  String vartitel;
  String varname;
  String varlocation;
  int varpayout;
  int varrating;

  @override
  Widget build(BuildContext context) {
    return buildCustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$varid", style: AppCardStyles.viewOrder),
              Text("$vardateTime", style: AppCardStyles.dateTime),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.bluenewcontainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 16),
                    SizedBox(width: 4),
                    Text("$varcompleted", style: AppCardStyles.viewOrder),
                  ],
                ),
              ),
            ],
          ),
          Text("$vartitel", style: AppCardStyles.jobTitle),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.backgroundLightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.iconbluebg,
                      radius: 20,
                      child: Icon(Icons.person, size: 18),
                    ),
                    SizedBox(width: 12),
                    Column(
                      children: [
                        Text("$varname", style: AppCardStyles.clientName),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "$varlocation",
                              style: AppCardStyles.locationText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.chat_bubble_outline,
                        size: 12,
                        color: AppColors.accentBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.softBlueTint,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rate,
                      size: 18,
                      color: AppColors.activeBadge,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "$varrating",
                      style: TextStyle(
                        color: AppColors.activeBadge,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text("Rating", style: AppCardStyles.payoutLabel),
                  ],
                ),
              ),
              Column(
                children: [
                  Text("Net Payout"),
                  Text("$varpayout", style: AppCardStyles.payoutAmount),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.description_outlined, color: AppColors.accentBlue),
                  Text("$varview", style: AppCardStyles.viewOrder),
                ],
              ),
              Icon(Icons.arrow_back, color: AppColors.textSecondary),
            ],
          ),
        ],
      ),
    );
  }
}
