import 'package:final_depi/app/routes/route_screen_name.dart';
import 'package:final_depi/features/home/presentation/screens/incoming_requests_screen.dart';
import 'package:final_depi/features/home/presentation/screens/request_details_screen.dart';
import 'package:final_depi/features/technician_home/technician_home.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import '../../features/auth/presentation/pages/forgetPassword/forget_password.dart';
import '../../features/auth/presentation/pages/login/login_screen.dart';
import '../../features/auth/presentation/pages/register/selection_screen.dart';
import '../../features/auth/presentation/pages/register/signup_customer.dart';
import '../../features/auth/presentation/pages/register/signup_technician.dart';
import '../../features/home/logic/ai_analysis_bloc.dart';
import '../../features/home/presentation/screens/ai_result_screen.dart';

import '../../features/home/presentation/screens/customer_shell.dart';
import '../../features/home/presentation/screens/describe_problem_screen.dart';

import "../../features/Technician/presentation/pages/jobsHistory.dart";
import "../../features/Technician/presentation/pages/TechnicianChat .dart";
import "../../features/Technician/presentation/pages/technician_profile.dart";
import "../../features/Technician/presentation/pages/technician_active_job.dart";

import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

import '../../features/customer_chat/screens/customer_chat_screen.dart';
import '../../features/customer_service_details/screens/customer_service_details_screen.dart';
import '../../features/customer_settings/screens/customer_settings_screens.dart';

import '../../features/rating_and_review/screens/rating_and_review_screen.dart';

abstract class RoutesApp {
  static Route<dynamic> onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteScreenName.initial:
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

      case RouteScreenName.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );

      case RouteScreenName.customerHome:
        return MaterialPageRoute(
          builder: (context) => const CustomerShell(),
          settings: settings,
        );

      case RouteScreenName.describeProblem:
        return MaterialPageRoute(
          builder: (context) => const DescribeProblemScreen(),
          settings: settings,
        );

      case RouteScreenName.aiResult:
        return MaterialPageRoute(
          builder: (context) => settings.arguments is AiReport
              ? AiResultScreen(report: settings.arguments as AiReport)
              : const DescribeProblemScreen(),
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
          builder: (context) => Sc22TechnicianProfile(),
          settings: settings,
        );

      case RouteScreenName.technicianChat:
        return MaterialPageRoute(
          builder: (context) => const TechnicianChat(),
          settings: settings,
        );

      case RouteScreenName.customerChat:
        return MaterialPageRoute(
          builder: (context) => const CustomerChatScreen(),
          settings: settings,
        );

      case RouteScreenName.customerServiceDetails:
        return MaterialPageRoute(
          builder: (context) => const CustomerServiceDetailsScreen(),
          settings: settings,
        );

      case RouteScreenName.customerSettings:
        return MaterialPageRoute(
          builder: (context) => const CustomerSettingsScreen(),
          settings: settings,
        );

      case RouteScreenName.ratingAndReview:
        return MaterialPageRoute(
          builder: (context) => const RatingReviewScreen(),
          settings: settings,
        );
      case RouteScreenName.technicianHome:
        return MaterialPageRoute(
          builder: (context) => const TechnicianHome(),
          settings: settings,
        );
      case RouteScreenName.incomingRequestsScreen:
        return MaterialPageRoute(
          builder: (context) => const IncomingRequestsScreen(),
          settings: settings,
        );
      case RouteScreenName.requestDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => const RequestDetailsScreen(),
          settings: settings,
        );

      case RouteScreenName.incomingRequests:
        return MaterialPageRoute(
          builder: (context) => const IncomingRequestsScreen(),
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