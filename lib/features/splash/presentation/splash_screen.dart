import 'package:animate_do/animate_do.dart';
import 'package:final_depi/app/routes/route_screen_name.dart';
import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/assets_app.dart';
import '../../../core/services/local_storage_key.dart';
import '../../../core/services/local_storage_service.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 3),
          () {
        var isFristTime = LocalStorageService.getBool(LocalStorageKeys.isFirstTimeRun)?? true;
        Navigator.pushReplacementNamed(context, isFristTime?RouteScreenName.onboarding :
        RouteScreenName.loginScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FC),
      body: Center(
    child: Column(
    mainAxisSize: MainAxisSize.min,
      children: [
        ZoomIn(
          duration: const Duration(seconds: 1),
          child: Image.asset(
            AssetsApp.logoSplash,
            width: 150,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),

        SlideInUp(
          duration: const Duration(seconds: 1),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '7elhaly',
                  style: GoogleFonts.inter(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: ColorsApp.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                 Text(
                  'Find. Fix. Done.',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF171A22),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    ),

    );
  }
}


