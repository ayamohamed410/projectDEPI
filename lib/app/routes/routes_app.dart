import 'package:final_depi/app/routes/route_screen_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/onboarding/onboarding_screen.dart';
import '../../features/splash/splash_screen.dart';





abstract class RoutesApp {
  static Route<dynamic> onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteScreenName.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );

      case RouteScreenName.onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
