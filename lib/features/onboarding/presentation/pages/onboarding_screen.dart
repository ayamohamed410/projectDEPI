import 'package:final_depi/app/routes/route_screen_name.dart';
import 'package:final_depi/features/onboarding/presentation/widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';
import '../../data/onboarding_data.dart';



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController =
  PageController(initialPage: 0);

  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage <
        OnboardingModel.onboardingList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishOnboarding() {
    Navigator.of(context).pushReplacementNamed(
      RouteScreenName.selectionScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = OnboardingModel.onboardingList;

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return OnboardingWidget(
            model: pages[index],
            currentPage: _currentPage,
            totalPages: pages.length,
            onNext: _nextPage,
            onBack: _previousPage,
            onFinish: _finishOnboarding,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
