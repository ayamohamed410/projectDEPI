
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/Custom_button_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/onboarding_data.dart';

class OnboardingWidget extends StatelessWidget {
  final OnboardingModel model;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onFinish;

  const OnboardingWidget({
    super.key,
    required this.model,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onBack,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentPage == totalPages - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          children: [
            // Top Image
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    model.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // Bottom Content
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    // Heading
                    Text(
                      model.header,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        color: ColorsApp.primaryColor,
                      ),
                    ),

                    if (model.description != null) ...[
                      const SizedBox(height: 14),
                      Text(
                        model.description!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.6,
                          color: ColorsApp.greyColor,
                        ),
                      ),
                    ],

                    const Spacer(),
                    // Page Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        totalPages,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          height: 6,
                          width: currentPage == index ? 24 : 6,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? ColorsApp.primaryColor
                                : ColorsApp.greyColor.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),

                   SizedBox(height: 5,),

                    // Main Action
                    SizedBox(
                      width: double.infinity,
                      child: CustomButtonWidget(
                        buttonText: isLastPage ? 'Get Started' : 'Next',
                        onPressed: isLastPage ? onFinish : onNext,
                        backgroundColor: ColorsApp.primaryColor,
                        textColor: ColorsApp.whiteColor,
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
