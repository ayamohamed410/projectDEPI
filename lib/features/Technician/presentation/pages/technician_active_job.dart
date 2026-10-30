import 'package:flutter/material.dart';
import '/core/theme//app_styles.dart';
import '../widgets/container.dart';
import '../widgets/custom_card_container.dart';
import '../widgets/timelinestep.dart';

class TechnicianActiveJob extends StatefulWidget {
  const TechnicianActiveJob({super.key});

  @override
  State<TechnicianActiveJob> createState() => _TechnicianActiveJobState();
}

class _TechnicianActiveJobState extends State<TechnicianActiveJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: const Text(
          "Technician Active Job",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. شريط رقم الطلب والحالة (Dark Header Bar)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.circle, color: Colors.blue, size: 10),
                      SizedBox(width: 8),
                      Text(
                        "Request #7H-9482",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'ACTIVE IN PROGRESS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. كارت معلومات العميل والاتصال
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 28,
                          child: Icon(Icons.person),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Icon(
                              Icons.verified,
                              size: 18,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tarek Mansour',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: const [
                                Icon(
                                  Icons.star_border,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  '4.9 (14 bookings) • Premium Resident',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.blue,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Apt 402, Building 12, South Teseen St',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'New Cairo, District 5',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  //chaaaaaaaaaaaaat
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bluenewcontainer,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.chat,
                                size: 24,
                                color: AppColors.primary,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Chat",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bluenewcontainer,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.call,
                                size: 24,
                                color: AppColors.primary,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Call",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            buildCustomContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'MANUAL STATUS PROGRESSION',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      buildCustomContainer(
                        cardColor: AppColors.bluenewcontainer,
                        child: Text(
                          'No GPS Required',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.bluenewcontainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 24,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "1. On Way",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.bluenewcontainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 24,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "2. Arrived",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        //3
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.bluenewcontainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  size: 24,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "3. In Progress",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        //4
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.bluenewcontainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.hourglass_empty,
                                  size: 24,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "4. Complete",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Icon(Icons.sync, size: 12, color: Colors.blue),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Manual status updates sync automatically to customer in real-time without GPS.",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  const Divider(
                    color: Color.fromARGB(255, 218, 231, 249),
                    thickness: 1,
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Service Timeline',
                        style: AppTextStyles.sectionHeader,
                      ),

                      buildCustomContainer(
                        cardColor: AppColors.bluenewcontainer,
                        child: Text(
                          'Step 4 of 5',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Timelinestep(
                        title: 'Accepted',
                        subtitle: 'Confirmed at 10:15 AM',
                      ),
                      Timelinestep(
                        title: 'On the Way',
                        subtitle: 'Dispatched at 10:28 AM',
                      ),
                      Timelinestep(
                        title: 'Arrived',
                        subtitle: 'Marked at 10:48 AM',
                      ),
                      Timelinestep(
                        title: 'In Progress (Active)',
                        subtitle: 'Started 10:52 AM • Work underway',
                        icon: Icons.hourglass_bottom,
                        lineColor: Color(0xFFE3E6EB),
                        titleColor: Color(0xFF1456E0),
                        badgeText: '24 mins',
                      ),
                      Timelinestep(
                        title: 'Completed',
                        subtitle: 'Awaiting completion sign-off',
                        circleColor: Color(0xFFE3E6EB),
                        icon: Icons.flag_outlined,
                        lineColor: Colors.transparent,
                        titleColor: Color(0xFF6B7280),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 4. كارت Diagnosis & Billing
            const SizedBox(height: 16),

            ///widjet الاخر
            CustomCardContainer(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF5FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.build_outlined,
                              size: 16,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "DIAGNOSIS & SCOPE",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Kitchen Sink High Pressure Pipe Leak",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Action: Currently replacing compression brass valve and sealing joints under main island sink.",
                          style: TextStyle(fontSize: 11, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Logged Parts & Hardware',
                        style: AppTextStyles.sectionHeader,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_circle_outline,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 2),
                          Text(
                            'Add Item',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1456E0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  buildCustomContainer(
                    cardColor: AppColors.bluenewcontainer,
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Brass compression valve 1/2"',
                                style: AppTextStyles.cardTitle,
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Qty: 1 • OEM Standard',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text('+ EGP 120', style: AppTextStyles.cardTitle),
                      ],
                    ),
                  ),

                  buildCustomContainer(
                    cardColor: AppColors.bluenewcontainer,
                    child: Row(
                      children: [
                        Icon(Icons.straighten, size: 20, color: Colors.grey),
                        SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'High-density Teflon tape',
                                style: AppTextStyles.cardTitle,
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Qty: 2 rolls • Water-grade',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text('+ EGP 30', style: AppTextStyles.cardTitle),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Photo Verification',
                        style: AppTextStyles.sectionHeader,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '2 of 2 Required',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1456E0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 120,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/images/before_fix.png',
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  //
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black54,
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 8,
                                  child: Text(
                                    'Before Fix',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  //
                                  right: 10,
                                  bottom: 8,
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: Color(0xFF1456E0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 120,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/images/after_fix.png',
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black54,
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 8,
                                  child: Text(
                                    'After Fix',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 8,
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: Color(0xFF1456E0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), //[اخر جزء ]
                  buildCustomContainer(
                    cardColor: AppColors.bluenewcontainer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Base Inspection & Labor",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "EGP 270",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Logged Extra Parts",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "+EGP 150",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Final Billing Amount",
                                    style: AppTextStyles.sectionHeader,
                                  ),
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    "Verified against labor guideline tier   ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 150,
                              child: CustomCardContainer(
                                padding: EdgeInsets.all(14),
                                child: Text(
                                  "EGP\n420",
                                  maxLines: 2,
                                  style: TextStyle(
                                    height: 1.1,
                                    fontSize: 24,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Complete Service & Generate Receipt",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),

            // 6. زر الإبلاغ عن مشكلة
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F5F9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Report Issue / Delay",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.sync, size: 12, color: Colors.blue),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "Manual status updates sync automatically to customer in real-time without GPS.",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
