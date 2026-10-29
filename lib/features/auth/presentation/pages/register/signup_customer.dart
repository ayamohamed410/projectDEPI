import 'package:flutter/material.dart';

import '../../../../../core/constants/assets_app.dart';
import '../../../../../core/extensions/validate.dart';
import '../../../../../core/services/Custom_button_widget.dart';
import '../../../../../core/services/custom_text_field.dart';
import '../../../../../core/theme/app_colors.dart';
import '../login/login_screen.dart';
import 'selection_screen.dart';

class SignupCustomerScreen extends StatefulWidget {
  const SignupCustomerScreen({super.key});

  @override
  State<SignupCustomerScreen> createState() =>
      _SignupCustomerScreenState();
}

class _SignupCustomerScreenState
    extends State<SignupCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Customer registration is not connected yet.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorsApp.primaryColor,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [


                SizedBox(height: height * 0.015),

                // Logo
                Center(
                  child: Image.asset(
                    AssetsApp.logoSplash,
                    height: height * 0.11,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 4),

                // App Name
                const Text(
                  '7elhaly',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: ColorsApp.primaryColor,
                  ),
                ),

                const SizedBox(height: 24),

                // Header
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: ColorsApp.primaryColor,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Find the right expert for your home.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: ColorsApp.greyColor,
                  ),
                ),

                const SizedBox(height: 24),

                // Full Name
                _buildLabel('Full Name'),

                const SizedBox(height: 8),

                CustomTextField(
                  controller: _nameController,
                  hint: 'Enter your full name',
                  hintColor: ColorsApp.greyColor,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: ColorsApp.greyColor,
                  ),
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }

                    if (value.trim().length < 3) {
                      return 'Name must be at least 3 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Email
                _buildLabel('Email Address'),

                const SizedBox(height: 8),

                CustomTextField(
                  controller: _emailController,
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

                const SizedBox(height: 16),

                // Phone Number
                _buildLabel('Phone Number'),

                const SizedBox(height: 8),

                CustomTextField(
                  controller: _phoneController,
                  hint: 'Enter your phone number',
                  hintColor: ColorsApp.greyColor,
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    color: ColorsApp.greyColor,
                  ),
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }

                    // Add your phone validation here
                    // according to the accepted Egyptian formats.
                    if (value.trim().length < 10) {
                      return 'Please enter a valid phone number';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Password
                _buildLabel('Password'),

                const SizedBox(height: 8),

                CustomTextField(
                  controller: _passwordController,
                  hint: 'Create a password',
                  hintColor: ColorsApp.greyColor,
                  isPassword: true,
                  maxLines: 1,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: ColorsApp.greyColor,
                  ),
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    if (!Validations.validatePassword(value)) {
                      return 'Please enter a valid password';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Confirm Password
                _buildLabel('Confirm Password'),

                const SizedBox(height: 8),

                CustomTextField(
                  controller: _confirmPasswordController,
                  hint: 'Confirm your password',
                  hintColor: ColorsApp.greyColor,
                  isPassword: true,
                  maxLines: 1,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: ColorsApp.greyColor,
                  ),
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }

                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                // Create Account Button
                CustomButtonWidget(
                  buttonText: 'Create Account',
                  height: 54,
                  onPressed: _createAccount,
                ),

                const SizedBox(height: 22),

                // Login
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorsApp.primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.BlueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ColorsApp.primaryColor,
      ),
    );
  }
}
