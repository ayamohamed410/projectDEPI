import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/home/presentation/screens/incoming_requests_screen.dart';
import 'package:final_depi/features/home/presentation/widgets/custom_button_nav_technician.dart';
import 'package:final_depi/features/home/presentation/widgets/technician_card_widget.dart';
import 'package:flutter/material.dart';

class TechnicianHome extends StatelessWidget {
  const TechnicianHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.background,
      // Color.fromARGB(255, 230, 234, 241)
      appBar: AppBar(
        backgroundColor: ColorsApp.blue,
        title: Text("Technician Home", style: TextStyle(fontSize: 14)),
        elevation: 22,

        actions: [
          Stack(
            children: [
              Container(
                width: 33,
                height: 33,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_outline, color: Colors.white, size: 22),
              ),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,

                    backgroundImage: AssetImage("assets/images/technician.png"),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("""Welcome back, 
Mahmoud""", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                        Text(
                          "Master Plumber",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff44474D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.handyman_outlined,
                    color: Color(0xFF555B65),
                    size: 21,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 31,
                        height: 29,
                        decoration: BoxDecoration(
                          color: Color(0xffEFF4FF),
                          shape: BoxShape.circle,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.notifications_outlined),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TechnicianCard(
                          icon: Icons.check_circle_outline,
                          iconColor: Colors.blue,
                          text1: "Completed Today",
                          text2: "3 Jobs",
                          text3: "100% on-time arrival",
                        ),
                      ),
                      SizedBox(width: 12),

                      Expanded(
                        child: TechnicianCard(
                          icon: Icons.timelapse_outlined,
                          iconColor: Colors.blue,
                          text1: "In Progress",
                          text2: "1 Active",
                          text3: "Dispatched",
                        ),
                      ),
                    ],
                  ),
                  TechnicianCard(
                    icon: Icons.star_border,
                    iconColor: Color(0xffBB7700),
                    text1: "Rating Score",
                    text2: "4.9",
                    text3: "184 reviews",
                  ),

                  SizedBox(height: 29),

                  // Ongoing job heading
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'ONGOING JOB • DISPATCHED',
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Text(
                        '#7H-9482',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF555B65),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.035),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Text(
                                'Kitchen Sink Pipe\nPressure Leak',
                                style: TextStyle(
                                  fontSize: 19,
                                  height: 1.3,
                                  fontWeight: FontWeight.bold,
                                  // color: ,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F0FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.navigation_outlined,
                                    size: 15,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '~15 mins',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text("""Emergency plumbing & valve
replacement""", style: TextStyle(color: Color(0xff44474D), fontSize: 14)),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(18),
                              right: Radius.circular(18),
                            ),
                            color: Color(0xffEFF4FF),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xffDCE9FF),
                                child: Text("TM"),
                              ),
                              SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tarek Mansour",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Apt 402, South Teseen St, New Cairo",
                                    style: TextStyle(
                                      color: Color(0xff44474D),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),

                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.phone_outlined,
                                  color: Colors.blue,
                                ),
                                highlightColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 18),
                        // Job action
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () {},

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              //                           elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Continue Active Job",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  //*****************      Incoming Requests********************* */
                  Row(
                    children: [
                      Text(
                        'Incoming Requests',
                        style: TextStyle(
                          fontSize: 19,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 12),

                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xffDCE9FF),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "1",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Review Inbox',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0051D5),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 14,
                          color: Color(0xFF0051D5),
                        ),
                      ),
                    ],
                  ),
                  //*******************Card Incoming Requist********************* */

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.035),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F0FF),
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Icon(
                                Icons.heat_pump_rounded,
                                size: 15,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                'Water Heater Thermostat\nFailure',
                                style: TextStyle(
                                  fontSize: 19,
                                  height: 1.3,
                                  fontWeight: FontWeight.bold,
                                  // color: ,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "EGP 400-650",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          "1.8 km away • New Cairo",
                          style: TextStyle(
                            color: Color(0xff44474D),
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(height: 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},

                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsApp.blue,
                                //                           elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Review Inbox",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const IncomingRequestsScreen(),
                                  ),
                                );
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                //                           elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "View Details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarTechnician(),
    );
  }
}
