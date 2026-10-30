// lib/constants/app_styles.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color background = Color(0xFFF8FAFC);
  static const Color cardBg = Colors.white;
  static const Color darkBanner = Color(0xFF0F172A);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color chipBlueBg = Color(0xFFEFF6FF);
  static const Color border = Color(0xFFE2E8F0);
  static const Color warning = Color(0xFFDC2626);
  static const Color activeBadge = Color(0xFFD97706);
  static const Color colorbluew = Color(
    0xFFEFF6FF,
  ); // قيمة تعبر عن الأزرق الفاتح الشفاف
  static const Color textDark = Color(0xFF0F172A);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color softBlueTint = Color(0xFFBFDBFE);
  static const Color backgroundLightBlue = Color(0xFFEFF6FF);
  static const Color bluenewcontainer = Color(0xFFEFF6FF);
  static const Color iconbluebg = Color(0xFFD3E4FE
);
  
}

class AppDecorations {
  static final BorderRadius cardRadius = BorderRadius.circular(16);
  static final BorderRadius smallRadius = BorderRadius.circular(8);
  static final BorderRadius pillRadius = BorderRadius.circular(20);

  static final BoxDecoration whiteCardBox = BoxDecoration(
    color: AppColors.cardBg,
    borderRadius: cardRadius,
    border: Border.all(color: AppColors.border, width: 1),
  );

  static final BoxDecoration infoBox = BoxDecoration(
    color: AppColors.chipBlueBg,
    borderRadius: BorderRadius.circular(12),
  );
}

class AppTextStyles {
  static const TextStyle sectionHeader = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const TextStyle priceText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}

class AppPadding {
  static const EdgeInsets pagePadding = EdgeInsets.all(16.0);
  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);
  static const EdgeInsets internalBoxPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  );
}

class AppCardStyles {
  // رقم الطلب والتاريخ
  static const TextStyle requestId = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.accentBlue,
  );

  static const TextStyle dateTime = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  // عنوان الخدمة الرئيسي (مثل Main Water Shutoff...)
  static const TextStyle jobTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  // اسم العميل والموقع
  static const TextStyle clientName = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle locationText = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  // السعر النهائي (Net Payout & EGP 520)
  static const TextStyle payoutLabel = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle payoutAmount = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  // زر عرض أمر الشغل (View Work Order)
  static const TextStyle viewOrder = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.accentBlue,
  );
}
