import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:men_store/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_form_field.dart';
import '../../../core/widgets/app_password_field.dart';
import '../login/login_screen.dart';
import 'cubit/signup_cubit.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            AnimatedSnackBar.material(
              state.message,
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
            ).show(context);
            // Go to login screen on successful signup
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          } else if (state is SignupFailure) {
            AnimatedSnackBar.material(
              state.error,
              type: AnimatedSnackBarType.error,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
            ).show(context);
          }
        },
        builder: (context, state) {
          final l10n = AppLocalizations.of(context)!;
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        l10n.createAccount,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.letsCreateAccount,
                        style: const TextStyle(color: AppColors.sub, fontSize: 14),
                      ),
                      const SizedBox(height: 30),

                      // Full Name Field
                      Text(
                        l10n.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppFormField(
                        controller: _fullNameController,
                        hintText: l10n.enterFullName,
                      ),

                      const SizedBox(height: 20),

                      // Email Address Field
                      Text(
                        l10n.emailAddress,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppFormField(
                        controller: _emailController,
                        hintText: l10n.enterEmail,
                      ),

                      const SizedBox(height: 20),

                      // Password Field
                      Text(
                        l10n.password,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppPasswordField(
                        controller: _passwordController,
                        hintText: l10n.enterPassword,
                      ),

                      const SizedBox(height: 20),

                      // Confirm Password Field
                      Text(
                        l10n.confirmPassword,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppPasswordField(
                        controller: _confirmPasswordController,
                        hintText: l10n.confirmYourPassword,
                      ),

                      const SizedBox(height: 40),

                      // Create Account Button
                      if (state is SignupLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        AppButton(
                          text: l10n.signUp,
                          onPressed: () {
                            context.read<SignupCubit>().signup(
                              fullName: _fullNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              confirmPassword: _confirmPasswordController.text,
                            );
                          },
                          height: 55,
                          elevation: 0,
                        ),

                      const SizedBox(height: 30),

                      // Footer
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: RichText(
                              text: TextSpan(
                                text: l10n.alreadyHaveAccount,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: l10n.login,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
