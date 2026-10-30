import 'package:flutter/material.dart';
import '/core/theme/themee/app_styles.dart';
import '../widgets/container.dart';

class Sc22TechnicianProfile extends StatefulWidget {
  Sc22TechnicianProfile({super.key});

  @override
  State<Sc22TechnicianProfile> createState() => _Sc22TechnicianProfileState();
}

int selectedindex = 0;

class _Sc22TechnicianProfileState extends State<Sc22TechnicianProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
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
                'Technician Profile',
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
          padding: EdgeInsetsGeometry.all(14),
          child: Column(
            children: [


              buildCustomContainer(child: Column(children: [
                
                Row(
                children: [
                  Icon(Icons.person, size: 60,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [buildCustomContainer(child: Row(
                      
                        children: const [
                          Icon(Icons.workspace_premium, size: 12, color: AppColors.primary),
                          SizedBox(width: 4),
                          Text(
                            'Elite Concierge Pro',
                            style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('Mahmoud El-Sayed', style: AppTextStyles.sectionHeader),
                    const Text('Master Plumber & Hydraulic Systems', style: AppTextStyles.bodySmall),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        SizedBox(width: 4),
                        Text('4.9 ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text('(184 reviews)', style: AppTextStyles.bodySmall),
                      ],
                    ),
          
                    
                    ],),

                ],
              ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                    Container(padding: EdgeInsets.all(15),decoration: BoxDecoration(color: AppColors.backgroundLightBlue,borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Text("Experience", style: AppTextStyles.caption),
                                          Text('12 Yrs', style: AppTextStyles.priceText),
                                          Text( 'Verified', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                        ],
                                      ),
                                    ),
                                    Container(padding: EdgeInsets.all(15),decoration: BoxDecoration(color: AppColors.backgroundLightBlue,borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Text('Completed', style: AppTextStyles.caption),
                                          Text('326', style: AppTextStyles.priceText),
                                          Text('Total Jobs', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                        ],
                                      ),
                                    ),
                                    Container(padding: EdgeInsets.all(15),decoration: BoxDecoration(color: AppColors.backgroundLightBlue,borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Text('Punctuality', style: AppTextStyles.caption),
                                          Text('98.4%', style: AppTextStyles.priceText),
                                          Text('On-Time',
                                           style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                        ],
                                      ),
                                    ),
                                    ],)],)),


              SizedBox(height: 12),
              buildCustomContainer(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified_user_outlined, color: AppColors.primary, size: 18),
              SizedBox(width: 8),
                        Text(
                          "About & Credentials",
                           style: AppTextStyles.sectionHeader,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Certified master plumber specializing in high-pressure plumbing, domestic leak detection, European mixer installation, and emergency water pipe replacement across Cairo.",
                    style: AppTextStyles.bodySmall,maxLines: 3,overflow: TextOverflow.ellipsis,),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              SizedBox(height: 8),
              buildCustomContainer(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.handyman_outlined, color: AppColors.primary, size: 18),
                  SizedBox(width: 8),
                            Text("Core Specialties",style: AppTextStyles.sectionHeader),
                          ],
                        ),
                        Row(children: [Text("5 Certified")]),
                      ],
                    ),
                    Wrap(runSpacing: 8,spacing: 8,children: 
                    [buildCustomContainer(cardColor: AppColors.bluenewcontainer,child:
                     Row(children: [Icon(Icons.build_outlined,color: AppColors.primary,),
                    
                     Text('Plumbing & Pipe Repair',style: AppTextStyles.cardTitle,),],))

                     ,buildCustomContainer(cardColor: AppColors.bluenewcontainer,child:
                     Row(children: [Icon(Icons.water_damage_outlined,color: AppColors.primary,),
                    
                     Text('Water Heaters',style: AppTextStyles.cardTitle,),],))
                     ,buildCustomContainer(cardColor: AppColors.bluenewcontainer,child:
                     Row(children: [Icon(Icons.waves,color: AppColors.primary,),
                    
                     Text('Drain Unblocking',style: AppTextStyles.cardTitle,),],)),
                     buildCustomContainer(cardColor: AppColors.bluenewcontainer,child:
                     Row(children: [Icon(Icons.plumbing,color: AppColors.primary,),
                    
                     Text('Valve Overhauls',style: AppTextStyles.cardTitle,)],)),
                     buildCustomContainer(cardColor: AppColors.bluenewcontainer,child:
                     Row(children: [Icon(Icons.bathtub_outlined,color: AppColors.primary,),
                    
                     Text('Luxury Sanitary Fixtures',style: AppTextStyles.cardTitle,),],))],)
                  ],
                ),
              ),
            
              SizedBox(height: 8),

            
            
                
                  


                    buildCustomContainer(
                    
                      child: Expanded(
                        child: Column(
                        children: [Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Row(
                                      children: [
                                        Icon(Icons.location_searching, color: AppColors.primary, size: 18),
                                        SizedBox(width: 8),
                                        Text('Coverage Areas', style: AppTextStyles.sectionHeader),
                                      ],
                                    ),
                                Text('Greater Cairo', style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),  ],
                                )
                                ,Wrap(spacing: 8,runSpacing: 8,children: [buildCustomContainer(cardColor: AppColors.bluenewcontainer,child: Text("New Cairo")),
                                buildCustomContainer(cardColor: AppColors.bluenewcontainer,child: Text("Fifth Settlement")),
                                buildCustomContainer(cardColor: AppColors.bluenewcontainer,child: Text("El Rehab")),buildCustomContainer(cardColor: AppColors.bluenewcontainer,child: Text("Madinaty")),
                                buildCustomContainer(cardColor: AppColors.bluenewcontainer,child: Text("Maadi")),buildCustomContainer(cardColor: AppColors.bluenewcontainer,child: Text("Nasr City"))],)],),
                      ),
                    ),
                  
                    buildCustomContainer(
                      
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [Row(children:
                              
                               [Icon(Icons.access_time,
                                color: AppColors.primary, size: 18),
            
              SizedBox(width: 8),
              Text('Working Hours & Availability', 
              style: AppTextStyles.sectionHeader),],),const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Monday – Saturday', style: AppTextStyles.cardTitle),
              Text('8:00 AM – 9:00 PM', style: AppTextStyles.bodySmall),
            ],),const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: AppDecorations.infoBox,
            child: Row(
              children: const [
                Icon(Icons.ac_unit, size: 14, color: AppColors.primary),
                SizedBox(width: 6),
                Text(
                  'Emergency 24/7 On-Call Dispatches Active',
                  style: TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600),
                ),]))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    buildCustomContainer(
                      
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [Icon(Icons.payments_outlined, color: AppColors.primary, size: 18),
              SizedBox(width: 8), Text("Standard Base Rates")],
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: AppColors.backgroundLightBlue,borderRadius: BorderRadius.circular(10)),
                                      
                                      child: Column(
                                        children: [
                                          Text("Inspection Visit", style: AppTextStyles.caption),
                                          Text("EGP 100", style: AppTextStyles.priceText),
                                          Text("Credited toward repair", style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                        ],
                                      ),
                                    ),
                                    Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: AppColors.backgroundLightBlue,borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Text("Standard Labor", style: AppTextStyles.caption),
                                          Text("EGP 200 /hr", style: AppTextStyles.priceText),
                                          Text("Official guaranteed rate", style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                        ],
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
                  
              SizedBox(width: double.infinity,height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBanner,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.edit_note, color: Colors.white),
                  label: const Text(
                    'log out',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
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
