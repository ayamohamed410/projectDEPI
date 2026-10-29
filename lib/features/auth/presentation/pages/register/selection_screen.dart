import 'package:final_depi/core/constants/assets_app.dart';
import 'package:final_depi/core/services/Custom_button_widget.dart';
import 'package:final_depi/core/theme/app_colors.dart';
import 'package:final_depi/features/auth/presentation/pages/register/signup_customer.dart';
import 'package:final_depi/features/auth/presentation/pages/register/signup_technician.dart';

import 'package:flutter/material.dart';

import '../../widgets/account_card_type.dart';
import '../login/login_screen.dart';


enum AccountType {
  customer,
  technician,
}

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  AccountType? selectedType;

  void _continue() {
    if (selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your account type'),
        ),
      );
      return;
    }

    final Widget screen;

    if (selectedType == AccountType.customer) {
      screen = const SignupCustomerScreen();
    } else {
      screen = const SignupTechnicianScreen();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),

              // App logo
              Image.asset(
                AssetsApp.logoSplash,
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              ),

             // const SizedBox(height: 16),

              // App name
              Text(
                '7elhaly',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  color: ColorsApp.primaryColor,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Choose Your Account Type',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.primaryColor,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Select how you want to use 7elhaly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.greyColor,
                ),
              ),

              const SizedBox(height: 32),

              // Customer card
              AccountTypeCard(
                title: 'Customer',
                subtitle: 'Find trusted professionals for your home',
                icon: Icons.person_rounded,
                isSelected: selectedType == AccountType.customer,
                onTap: () {
                  setState(() {
                    selectedType = AccountType.customer;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Technician card
              AccountTypeCard(
                title: 'Technician',
                subtitle: 'Offer your services to customers',
                icon: Icons.handyman_rounded,
                isSelected: selectedType == AccountType.technician,
                onTap: () {
                  setState(() {
                    selectedType = AccountType.technician;
                  });
                },
              ),

              const Spacer(flex: 2),

              // Continue button
              CustomButtonWidget(buttonText: "Continue", onPressed: _continue),



              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 15,
                      color: ColorsApp.greyColor,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ColorsApp.BlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}