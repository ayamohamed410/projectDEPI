import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsApp.whiteColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios_new,
                  size: 22,
                  color: ColorsApp.primaryColor,
                ),
                const SizedBox(width: 22),
                const Expanded(
                  child: Text(
                    'Customer Chat',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: ColorsApp.primaryColor,
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: ColorsApp.primaryColor,
                  child: Icon(
                    Icons.person_outline,
                    color: ColorsApp.whiteColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: ColorsApp.blueColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.support_agent,
                  size: 17,
                  color: Color(0xFF1262E8),
                ),
                const SizedBox(width: 5),
                const Expanded(
                  child: Text(
                    'Request #7H-9482 • Kitchen Leak',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0EAFF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'View Status →',
                    style: TextStyle(fontSize: 11, color: Color(0xFF1262E8)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 21,
                  backgroundColor: ColorsApp.blueColor,
                  child: Icon(Icons.person, color: ColorsApp.primaryColor),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Mahmoud El-Sayed',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.verified,
                            size: 15,
                            color: Color(0xFF1262E8),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.circle, size: 7, color: Color(0xFF12B886)),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              'Online & En Route (ETA 10:55 AM)',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ColorsApp.greyColor,
                                fontSize: 11,
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
        ],
      ),
    );
  }
}
