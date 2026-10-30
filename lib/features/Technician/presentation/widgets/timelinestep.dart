import 'package:flutter/material.dart';
import '/core/theme/themee/app_styles.dart';
import '../widgets/container.dart';
class TimeStep {
const  TimeStep({required this.title, required this.subtitle,
  this.circleColor = AppColors.primary,
  this.lineColor = AppColors.primary,this.icon = Icons.check, this.titleColor = Colors.black,this.badgeText, });
  final String subtitle;
  final String title;
  final Color circleColor;
final Color lineColor;
final IconData icon;
final Color titleColor;
final String? badgeText; 

}

class Timelinestep extends StatelessWidget {
  const Timelinestep({super.key,required this.subtitle,required this.title,this.circleColor = AppColors.primary,
  this.lineColor = AppColors.primary,this.icon = Icons.check, this.titleColor = Colors.black,this.badgeText,  });
  final String subtitle;
  final String title;
  final Color circleColor;
final Color lineColor;
final IconData icon;
final Color titleColor;
final String? badgeText; 

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color:circleColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 16, color: Colors.white),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    color:lineColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12), 
          // ===== الجزء اليمين: النص =====
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,color: titleColor),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          if (badgeText != null)  
          buildCustomContainer(cardColor: AppColors.bluenewcontainer,decoration:BorderRadius.circular(0),child: Text(
          badgeText!,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1456E0),
          ),
        ),),       
  
      
      
        ],
      ),
    );
  }
}
