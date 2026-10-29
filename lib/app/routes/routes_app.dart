import 'package:final_depi/app/routes/route_screen_name.dart';
import 'package:final_depi/features/auth/presentation/pages/forgetPassword/forget_password.dart';
import 'package:final_depi/features/auth/presentation/pages/register/selection_screen.dart';
import 'package:final_depi/features/auth/presentation/pages/register/signup_customer.dart';
import 'package:final_depi/features/auth/presentation/pages/register/signup_technician.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login/login_screen.dart';
import '../../features/auth/presentation/pages/register/signup_customer.dart';
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
      case RouteScreenName.selectionScreen:
        return MaterialPageRoute(
          builder: (context) => const SelectionScreen(),
          settings: settings,
        );


      case RouteScreenName.signupCustomerScreen:
        return MaterialPageRoute(
          builder: (context) => const SignupCustomerScreen(),
          settings: settings,
        );
      case RouteScreenName.signupTechnicianScreen:
        return MaterialPageRoute(
          builder: (context) => const SignupTechnicianScreen(),
          settings: settings,
        );
      case RouteScreenName.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
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
