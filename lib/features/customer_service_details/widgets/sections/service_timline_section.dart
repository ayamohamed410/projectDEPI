import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../common/section_card.dart';
import '../common/section_heading.dart';

class ServiceTimelineSection extends StatelessWidget {
  const ServiceTimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    const events = [
      TimelineEvent(title: 'Dispatched', time: '10:32 AM'),
      TimelineEvent(title: 'Arrived on Premise', time: '10:48 AM'),
      TimelineEvent(title: 'Work Started', time: '10:52 AM'),
      TimelineEvent(
        title: 'Completed & Signed',
        time: '11:25 AM',
        isCompleted: true,
      ),
    ];

    return SectionCard(
      child: Column(
        children: [
          const SectionHeading(
            icon: Icons.access_time,
            title: 'Service Timeline',
            trailing: Text(
              '33 mins labor',
              style: TextStyle(fontSize: 9, color: ColorsApp.primaryColor),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(events.length, (index) {
            return TimelineItem(
              event: events[index],
              isLast: index == events.length - 1,
            );
          }),
        ],
      ),
    );
  }
}

class TimelineEvent {
  const TimelineEvent({
    required this.title,
    required this.time,
    this.isCompleted = false,
  });

  final String title;
  final String time;
  final bool isCompleted;
}

class TimelineItem extends StatelessWidget {
  const TimelineItem({super.key, required this.event, required this.isLast});

  final TimelineEvent event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 29,
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!isLast)
                  Positioned(
                    top: 15,
                    bottom: -14,
                    child: Container(width: 2, color: ColorsApp.borderColor),
                  ),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: event.isCompleted
                        ? ColorsApp.accentBlue
                        : const Color(0xFFD9E6FF),
                    shape: BoxShape.circle,
                  ),
                  child: event.isCompleted
                      ? const Icon(
                          Icons.check,
                          size: 11,
                          color: ColorsApp.whiteColor,
                        )
                      : Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: ColorsApp.accentBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              event.title,
              style: TextStyle(
                fontSize: 10,
                color: ColorsApp.primaryColor,
                fontWeight: event.isCompleted
                    ? FontWeight.w700
                    : FontWeight.w400,
              ),
            ),
          ),
          Text(
            event.time,
            style: TextStyle(
              fontSize: 9,
              color: event.isCompleted
                  ? ColorsApp.accentBlue
                  : ColorsApp.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
