import 'package:flutter/material.dart';
import '/core/theme/themee/app_styles.dart';
import '../widgets/container.dart';


//colors
//softBlueTint
// iconbluebg
//bluenewcontainer
class TechnicianChat extends StatefulWidget {
  const TechnicianChat({super.key});

  @override
  State<TechnicianChat> createState() => _TechnicianChatState();
}

class _TechnicianChatState extends State<TechnicianChat> {
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
          "Technician Chat",
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
        child: Column(
          children: [
            //1 widjet
            buildCustomContainer(
              child: Column(
                children: [
                  Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [


Row(children: [
                      Icon(Icons.person, size: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Tarek Mansour',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              buildCustomContainer(
                                cardColor: AppColors.iconbluebg,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      size: 12,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Client',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: const [
                              Icon(
                                Icons.star_border,
                                size: 14,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 2),
                              Text(
                                'Cairo • Frequent Customer (4.9 ★)',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ],)

                      , CircleAvatar(
    backgroundColor: Colors.blue.shade50,
    radius: 22,
    child: IconButton(
      icon: const Icon(Icons.phone_outlined, color: Colors.blue, size: 20),
      onPressed: () {
        // إجراء الاتصال هنا
      },
    ),
  ),
                    ],
                  ),

                  //containerblue
                  buildCustomContainer(
                    cardColor: AppColors.bluenewcontainer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //icon
                        buildCustomContainer(
                          decoration: BorderRadiusGeometry.circular(16),
                          cardColor: AppColors.iconbluebg,
                          child: const Icon(
                            Icons.handyman,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),

                        const SizedBox(width: 6),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Job #7H-9482',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),

                                const SizedBox(width: 6),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'In Progress',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Apt 402, South Teseen St, New C...',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {
                            // الانتقال لصفحة تفاصيل الوظيفة
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          child: const Text(
                            'Job Details →',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  buildCustomContainer(
                    cardColor: AppColors.bluenewcontainer,
                    child: Row(
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          color: AppColors.primary,
                          size: 20,
                        ),

                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            'Official 7elhaly chat channel. Retain all service updates here for warranty validation & job documentation.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildCustomContainer(child: Text("Today, October 24",),cardColor: AppColors.bluenewcontainer) ,
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: buildCustomContainer(
                          cardColor: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Text(
                                  maxLines: 10,
                                  overflow: TextOverflow.clip,
                                  'Hello Mr. Tarek, I have accepted your request and I am en route with the replacement compression valves.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '10:34 AM',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.done_all,
                                    color: Colors.blue,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Icon(Icons.person, size: 40),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: buildCustomContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      maxLines: 10,
                                      overflow: TextOverflow.clip,
                                      "Thanks Mahmoud! Please note the building elevator is on the right side of the main lobby.",
                                    ),
                                  ),

                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text(
                                        '10:34 AM',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.done_all,
                                        color: Colors.blue,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: buildCustomContainer(
                          cardColor: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.person, size: 50, color: Colors.white),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  maxLines: 10,
                                  overflow: TextOverflow.clip,
                                  'I have the standard brass joints ready. Arriving in ~15 minutes.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '10:43 AM',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.done_all,
                                    color: Colors.blue,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Icon(Icons.person, size: 40),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: buildCustomContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      maxLines: 10,
                                      overflow: TextOverflow.clip,
                                      'Perfect, the front gate is open.',
                                    ),
                                  ),

                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text(
                                        '10:45 AM',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.done_all,
                                        color: Colors.blue,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                        
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.flash_on,
                                    size: 16,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'QUICK STATUS UPDATES',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),SizedBox(width: 100,),
                              Text(
                                'Tap to send',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ActionChip(
                                  avatar: const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.blue,
                                  ),
                                  label: const Text(
                                    'I have arrived at the building',
                                  ),
                                  backgroundColor: AppColors.bluenewcontainer,
                                  onPressed: () {},
                                ),

                                const SizedBox(width: 8),
                                ActionChip(
                                  avatar: const Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: Colors.blue,
                                  ),
                                  label: const Text('Work completed'),
                                  backgroundColor: AppColors.bluenewcontainer,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            buildCustomContainer(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.insert_drive_file_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Reply to Tarek Mansour',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: AppColors.bluenewcontainer,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.mic_none, color: Colors.grey),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 22,
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
