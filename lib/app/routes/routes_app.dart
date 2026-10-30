import 'package:final_depi/app/routes/route_screen_name.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login/login_screen.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/home/presentation/screens/customer_home_screen.dart';
import '../../features/home/presentation/screens/describe_problem_screen.dart';
import '../../features/home/presentation/screens/ai_result_screen.dart';
//screens technician
import "../features/Technician/presentation/pages/jobsHistory.dart";
import "../features/Technician/presentation/pages/TechnicianChat .dart";
import "../features/Technician/presentation/pages/technician_profile.dart";
import "../features/Technician/presentation/pages/technician_active_job.dart";


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

      case RouteScreenName.customerHome:
        return MaterialPageRoute(
          builder: (context) => const CustomerHomeScreen(),
          settings: settings,
        );

      case RouteScreenName.describeProblem:
        return MaterialPageRoute(
          builder: (context) => const DescribeProblemScreen(),
          settings: settings,
        );

      case RouteScreenName.aiResult:
        return MaterialPageRoute(
          builder: (context) => const AiResultScreen(),
          settings: settings,
        );

        case RouteScreenName.jobsHistory:
        return MaterialPageRoute(
          builder: (context) => const jobsHistory(), // 
          settings: settings,
        );

      case RouteScreenName.technicianActiveJob:
        return MaterialPageRoute(
          builder: (context) => const TechnicianActiveJob(),
          settings: settings,
        );

      case RouteScreenName.technicianProfile:
        return MaterialPageRoute(
          builder: (context) => const Sc22TechnicianProfile(),
          settings: settings,
        );

      case RouteScreenName.technicianChat:
        return MaterialPageRoute(
          builder: (context) => const TechnicianChat(),
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
