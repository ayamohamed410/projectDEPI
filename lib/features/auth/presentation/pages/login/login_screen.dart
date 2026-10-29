import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/assets_app.dart';
import '../../../../../core/extensions/validate.dart';
import '../../../../../core/services/Custom_button_widget.dart';
import '../../../../../core/services/custom_text_field.dart';
import '../../../../../core/theme/app_colors.dart';
import '../forgetPassword/forget_password.dart';
import '../register/selection_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.025),

                // Logo
                Center(
                  child: Image.asset(
                    AssetsApp.logoSplash,
                    height: height * 0.14,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 8),

                // App Name
                const Text(
                  '7elhaly',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: ColorsApp.primaryColor,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 30),

                // Welcome Title
                const Text(
                  'Welcome Back!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: ColorsApp.primaryColor,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Log in to continue to your account.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: ColorsApp.greyColor,
                  ),
                ),

                const SizedBox(height: 28),

                // Email Label
                const Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorsApp.primaryColor,
                  ),
                ),

                const SizedBox(height: 9),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  hint: 'Enter your email address',
                  hintColor: ColorsApp.greyColor,
                  prefixIcon: const Icon(
                    Icons.mail_outline,
                    color: Color(0xFF8296B0),
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

                const SizedBox(height: 20),

                // Password Label
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorsApp.primaryColor,
                  ),
                ),

                const SizedBox(height: 9),

                // Password Field
                CustomTextField(
                  controller: _passwordController,
                  isPassword: true,
                  maxLines: 1,
                  hint: 'Enter your password',
                  hintColor: ColorsApp.greyColor,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xFF8296B0),

                    //color: ColorsApp.greyColor,
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

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const ForgetPasswordScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      foregroundColor: ColorsApp.BlueColor,
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Login Button - UI Only
                CustomButtonWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Login is not connected yet.',
                          ),
                        ),
                      );
                    }
                  },
                  buttonText: 'Log In',
                  height: 54,
                ),

                const SizedBox(height: 24),

                // Create Account
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
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
                              const SelectionScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Create Account',
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

                const SizedBox(height: 25),

                // OR Divider
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFFE0E5EC),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: ColorsApp.greyColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFFE0E5EC),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // Google Login Button - UI Only
                CustomButtonWidget(
                  buttonText: 'Continue with Google',
                  icon: AssetsApp.googleIcon,
                  height: 54,
                  backgroundColor: ColorsApp.whiteColor,
                  sideColor: const Color(0xFFD7DDE6),
                  textColor: ColorsApp.primaryColor,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Google Login is not connected yet.',
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
