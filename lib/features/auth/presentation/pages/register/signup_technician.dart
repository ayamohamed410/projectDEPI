import 'package:flutter/material.dart';
import '../../../../../core/extensions/validate.dart';
import '../../../../../core/services/Custom_button_widget.dart';
import '../../../../../core/services/custom_text_field.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../widgets/register/signup_section_label.dart';
import '../../widgets/register/technician_signup_header.dart';
import '../../widgets/register/technician_specialization_field.dart';
import '../../widgets/register/technician_experience_field.dart';
import '../login/login_screen.dart';

class SignupTechnicianScreen extends StatefulWidget {
  const SignupTechnicianScreen({super.key});

  @override
  State<SignupTechnicianScreen> createState() =>
      _SignupTechnicianScreenState();
}

class _SignupTechnicianScreenState
    extends State<SignupTechnicianScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedSpecialization;
  String? _selectedExperience;

  String? _specializationError;
  String? _experienceError;



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
    FocusScope.of(context).unfocus();

    final isFormValid = _formKey.currentState!.validate();

    setState(() {
      _specializationError = _selectedSpecialization == null
          ? 'Please select your specialization'
          : null;

      _experienceError = _selectedExperience == null
          ? 'Please select your experience level'
          : null;
    });

    if (!isFormValid ||
        _selectedSpecialization == null ||
        _selectedExperience == null) {
      return;
    }

    if (_passwordController.text !=
        _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    // TODO: Connect Firebase Authentication.
    // TODO: Save technician details in Cloud Firestore.

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Technician registration is not connected yet.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TechnicianSignupHeader(),

                const SignupSectionLabel(title: 'Full Name'),
                CustomTextField(
                  controller: _nameController,
                  hint: 'Enter your full name',
                  hintColor: ColorsApp.greyColor,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF8296B0),
                  ),
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),

                const SignupSectionLabel(title: 'Email Address'),
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
                      return 'Please enter your email';
                    }
                    if (!Validations.validateEmail(value.trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SignupSectionLabel(title: 'Phone Number'),
                CustomTextField(
                  controller: _phoneController,
                  hint: 'Enter your phone number',
                  hintColor: ColorsApp.greyColor,
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    color: Color(0xFF8296B0),
                  ),
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.trim().length < 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),

                const SignupSectionLabel(title: 'Specialization'),
                TechnicianSpecializationField(
                  selectedValue: _selectedSpecialization,
                  errorText: _specializationError,
                  onChanged: (value) {
                    setState(() {
                      _selectedSpecialization = value;
                      _specializationError = null;
                    });
                  },
                ),

                const SignupSectionLabel(
                  title: 'Years of Experience',
                ),
                TechnicianExperienceField(
                  selectedValue: _selectedExperience,
                  errorText: _experienceError,
                  onChanged: (value) {
                    setState(() {
                      _selectedExperience = value;
                      _experienceError = null;
                    });
                  },
                ),

                const SignupSectionLabel(title: 'Password'),
                CustomTextField(
                  controller: _passwordController,
                  hint: 'Create a password',
                  hintColor: ColorsApp.greyColor,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF8296B0),
                  ),
                  isPassword: true,
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (!Validations.validatePassword(value)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),

                const SignupSectionLabel(title: 'Confirm Password'),
                CustomTextField(
                  controller: _confirmPasswordController,
                  hint: 'Confirm your password',
                  hintColor: ColorsApp.greyColor,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF8296B0),
                  ),
                  isPassword: true,
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

                SizedBox(
                  width: double.infinity,
                  child: CustomButtonWidget(
                    buttonText: 'Create Technician Account',
                    onPressed: _createAccount,
                    backgroundColor: ColorsApp.primaryColor,
                    textColor: Colors.white,
                    height: 54,
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: ColorsApp.greyColor,
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
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: ColorsApp.BlueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
