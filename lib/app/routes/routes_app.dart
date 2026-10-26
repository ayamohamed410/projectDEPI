import 'package:final_depi/app/routes/route_screen_name.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/auth/pages/login_screen.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
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

      case RouteScreenName.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
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
