import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ServiceProgressCard extends StatelessWidget {
  const ServiceProgressCard({super.key});

  static const List<Map<String, String>> steps = [
    {
      'title': 'Accepted',
      'description': 'Request accepted by technician',
      'time': '10:30 AM',
    },
    {
      'title': 'On the Way',
      'description': 'Technician marked on the way',
      'time': '10:45 AM',
    },
    {
      'title': 'Arrived',
      'description': 'Technician marked arrival at property',
      'time': '—',
    },
    {
      'title': 'In Progress',
      'description': 'Technician started the repair work',
      'time': '—',
    },
    {
      'title': 'Completed',
      'description': 'Work finished and verified',
      'time': '—',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorsApp.whiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Service Progress',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.primaryColor,
                ),
              ),
              Text(
                'Step 2 of 5',
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFF0054D8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ...List.generate(steps.length, (index) => _buildProgressStep(index)),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int index) {
    final bool isCompleted = index == 0;
    final bool isActive = index == 1;
    final bool isLast = index == steps.length - 1;

    final Color activeColor = const Color(0xFF0054D8);

    final Color circleColor = isCompleted || isActive
        ? activeColor
        : const Color(0xFFDCE7FA);

    final Color textColor = index <= 1
        ? ColorsApp.primaryColor
        : ColorsApp.greyColor;

    return SizedBox(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 19,
                  height: 19,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted
                        ? Icons.check
                        : isActive
                        ? Icons.directions_car
                        : Icons.circle,
                    color: isCompleted || isActive
                        ? ColorsApp.whiteColor
                        : ColorsApp.whiteColor,
                    size: isActive ? 12 : 10,
                  ),
                ),

                if (!isLast)
                  Expanded(
                    child: Container(width: 1, color: const Color(0xFFB9D0FF)),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${index + 1}. ${steps[index]['title']}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: textColor,
                      ),
                    ),

                    if (isActive) ...[
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsApp.blueColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(
                            fontSize: 8,
                            color: Color(0xFF0054D8),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 3),

                Text(
                  steps[index]['description']!,
                  style: TextStyle(
                    fontSize: 9,
                    color: index <= 1
                        ? ColorsApp.greyColor
                        : const Color(0xFFB8BEC9),
                  ),
                ),
              ],
            ),
          ),

          Text(
            steps[index]['time']!,
            style: TextStyle(
              fontSize: 9,
              color: index <= 1
                  ? ColorsApp.primaryColor
                  : const Color(0xFFB8BEC9),
            ),
          ),
        ],
      ),
    );
  }
}
