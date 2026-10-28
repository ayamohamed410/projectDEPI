import 'package:flutter/material.dart';
import '/core/theme/themee/app_styles.dart';
import 'custom_card_container.dart';
container( IconData icon, String text) {
  return Container(
    decoration: AppDecorations.infoBox,
    child: Column(
      children: [
        Icon(icon),
        Text(text, style: AppTextStyles.bodySmall),
      ],
    ),
  );
}

container_row( IconData icon, String text) {
  return Container(
    decoration: AppDecorations.infoBox,
    child: Row(
      children: [
        Icon(icon),
        Text(text, style: AppTextStyles.bodySmall),
      ],
    ),
  );
}


Widget buildCustomContainer({required Widget child, Color? cardColor,BorderRadiusGeometry?decoration}) {
  return Container(  padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor ?? Colors.white,
        borderRadius:decoration?? BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),

  ),child: child,);
}