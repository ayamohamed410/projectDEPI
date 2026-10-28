import 'package:flutter/material.dart';
import '/core/theme/themee/app_styles.dart';
import '../widgets/container.dart';
import '../widgets/custom_card_container.dart';

class TechnicianActiveJob extends StatefulWidget {
  const TechnicianActiveJob({super.key});

  @override
  State<TechnicianActiveJob> createState() => _TechnicianActiveJobState();
}

class _TechnicianActiveJobState extends State<TechnicianActiveJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // خلفية الشاشة الفاتحة
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
                        children:  [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage('assets/image.png'),
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
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          Icons.chat_bubble_outline,
                          "Chat",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(Icons.phone_outlined, "Call"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. كارت الـ Manual Status Progression & Timeline
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "MANUAL STATUS PROGRESSION",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "No GPS Required",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatusStep(
                          "1. On Way",
                          Icons.check_circle_outline,
                          false,
                          true,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: _buildStatusStep(
                          "2. Arrived",
                          Icons.check_circle_outline,
                          false,
                          true,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: _buildStatusStep(
                          "3. In Progress",
                          Icons.play_arrow,
                          true,
                          false,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: _buildStatusStep(
                          "4. Complete",
                          Icons.hourglass_empty,
                          false,
                          false,
                        ),
                      ),
                    ],
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
            const SizedBox(height: 16),

            // 4. كارت Diagnosis & Billing
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
                      Icon(Icons.build_outlined, size: 16, color: Colors.blue),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Action: Currently replacing compression brass valve and sealing joints under main island sink.",
                    style: TextStyle(fontSize: 11, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 5. زر الحساب وإكمال الخدمة
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
            const SizedBox(height: 8),

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
            const SizedBox(height: 20),

            ///widjet الاخر
            CustomCardContainer(
              child: Column(
                children: [
                  //[اخر جزء ]
                  buildCustomContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Base Inspection & Labor", style: AppTextStyles.cardTitle),
                            Text("EGP 270",style: TextStyle(fontSize: 12,color: Colors.black),),
                          ],
                        ),

                         const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Logged Extra Parts", style: AppTextStyles.cardTitle),
                            Text("+EGP 150",style: TextStyle(fontSize: 12,color: Colors.black),),
                          ],
                        ),  const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Final Billing Amount", style: AppTextStyles.sectionHeader), 
                                   Text(maxLines: 1,
                                           overflow: TextOverflow.ellipsis,"Verified against labor guideline tier   ", style: AppTextStyles.caption)
                                ],
                              ),
                            ),
                            SizedBox(height: 100,width: 150,child: CustomCardContainer(padding: EdgeInsets.all(14),child: 
                            Text("EGP\n420",maxLines: 2,style: TextStyle(height: 1.1,fontSize: 24,color: Colors.blueAccent),)))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      
        
          
          
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.person, color: Colors.blue),
                Expanded(
                  child: Text(maxLines: 1,
                          overflow: TextOverflow.ellipsis,"aaaaaaaaaaaaaaaaaaa", style: AppTextStyles.caption),
                ),
              ],
            ),

            ///widjet الاخر
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusStep(
    String title,
    IconData icon,
    bool isActive,
    bool isDone,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.blue
            : (isDone ? const Color(0xFFE2E8F0) : const Color(0xFFF8FAFC)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 14,
            color: isActive
                ? Colors.white
                : (isDone ? Colors.blue : Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: isActive
                  ? Colors.white
                  : (isDone ? Colors.black87 : Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
