import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/extensions/validate.dart';
import '../../../../../core/services/custom_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgetPasswordScreen> {
  final TextEditingController emailController =
  TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Connect the reset password functionality later.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Back button
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                color: ColorsApp.primaryColor,
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),

              const SizedBox(height: 40),

              // Illustration
              Center(
                child: Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF1FC),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Icon(
                    Icons.mark_email_read_outlined,
                    size: 55,
                    color: ColorsApp.primaryColor,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Title
              Center(
                child: Text(
                  'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.primaryColor,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Description
              const Text(
                "Don't worry! It happens. Enter your email "
                    "address and we'll help you reset your password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.7,
                  color: ColorsApp.greyColor,
                ),
              ),

              const SizedBox(height: 36),

              // Email label
              Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.primaryColor,
                ),
              ),

              const SizedBox(height: 10),

              // Email field

              CustomTextField(
                controller: emailController,
                hint: 'Enter your email address',
                hintColor: ColorsApp.greyColor,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: ColorsApp.greyColor,
                ),
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your e-mail';
                  }

                  if (!Validations.validateEmail(value.trim())) {
                    return 'Please enter a valid e-mail';
                  }

                  return null;
                },
              ),


              const SizedBox(height: 28),

              // Send reset link button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _sendResetLink,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Send Reset Link',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Back to login
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const Text(
                      'Remember your password? ',
                      style: TextStyle(
                        color: ColorsApp.greyColor,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: ColorsApp.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

