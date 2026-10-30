import 'package:flutter/material.dart';
import '../../models/job1_model.dart';

import '../widgets/container.dart';
import '../widgets/custom_card_container.dart';
import '../widgets/JobCard.dart';
import '/core/theme/themee/app_styles.dart';

class jobsHistory extends StatefulWidget {
  const jobsHistory({super.key});

  @override
  State<jobsHistory> createState() => _jobsHistoryState();
}

int selectedindex = 0;

class _jobsHistoryState extends State<jobsHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 62, 131, 215),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Jobs History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              children: [
                buildCustomContainer(
                  cardColor: AppColors.colorbluew,
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'PRO',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {},
                  ),
                  backgroundColor: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomCardContainer(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          hintText:
                              'Search by customer, service, or request ID',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),

                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.tune, color: Colors.grey),
                  ],
                ),
              ),

              //************************ */ widjet 2**********************************
              CustomCardContainer(
                cardcolor: AppColors.colorbluew,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: sort_child_properties_last
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 40,
                          color: Colors.lightBlue,
                        ),

                        SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Billing Period',
                              style: AppTextStyles.cardTitle,
                            ),
                            SizedBox(height: 2),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Text(
                                      'October 2024',
                                      style: AppTextStyles.cardTitle,
                                    ),
                                    Icon(Icons.keyboard_arrow_down),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //*******************widjet2.1**************************************
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Net Invoiced',
                              style: AppTextStyles.cardTitle,
                            ),
                            SizedBox(height: 2),
                            Text('EGP 14,850', style: AppTextStyles.cardTitle),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),

              //widjet3**************************
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCustomContainer(
                    child: Text("All (48)", style: AppTextStyles.cardTitle),
                    cardColor: AppColors.colorbluew,
                  ),
                  buildCustomContainer(
                    child: Text(
                      "Completed (44)",
                      style: TextStyle(color: Colors.white),
                    ),
                    cardColor: Colors.black,
                  ),
                  buildCustomContainer(
                    child: Text(
                      "Cancelled (3)",
                      style: AppTextStyles.cardTitle,
                    ),
                    cardColor: AppColors.colorbluew,
                  ),
                ],
              ),

              //widjet4*******************
              CustomCardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: jobdata.length,
                      itemBuilder: (context, index) {
                        final jobItem = jobdata[index];
                        return Jobcard(
                          varid: jobItem.id,
                          vartitel: jobItem.title,
                          vardateTime: jobItem.dateTime,
                          varpayout: jobItem.netPayout,
                          varname: "Tarek Mansour",
                          varcompleted: jobItem.status ?? "Pending",
                          varrating: jobItem.rating,
                          varlocation: "New Cairo",
                          varview: "View Work Order",
                        );
                      },
                    ),
                  ],
                ),
              ),
              //widjet6*************************
              buildCustomContainer(
                cardColor: AppColors.bluenewcontainer,
                child: Row(
                  children: [
                    Icon(Icons.verified_user_rounded, color: AppColors.primary),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'All loggedrecords are secured & escrow-cleared',
                        style: AppTextStyles.cardTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: AppColors.textSecondary,
        currentIndex: selectedindex,

        onTap: (val) {
          setState(() {
            selectedindex = val;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_email_read_outlined),
            label: "Requests",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_history_outlined),
            label: "Jobs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
