import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:men_store/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_form_field.dart';
import '../../../core/widgets/app_password_field.dart';
import '../../home/home_screen.dart';
import '../signup/signup_screen.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            AnimatedSnackBar.material(
              state.message,
              type: AnimatedSnackBarType.success,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
            ).show(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          } else if (state is LoginFailure) {
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
            appBar: AppBar(backgroundColor: AppColors.white, elevation: 0),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        l10n.loginTitle,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.loginSubtitle,
                        style: const TextStyle(color: AppColors.sub, fontSize: 14),
                      ),
                      const SizedBox(height: 40),

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

                      const SizedBox(height: 25),

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

                      const SizedBox(height: 50),

                      // Sign In Button
                      if (state is LoginLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        AppButton(
                          text: l10n.signIn,
                          onPressed: () {
                            context.read<LoginCubit>().login(
                              email: _emailController.text,
                              password: _passwordController.text,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: l10n.dontHaveAccount,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: l10n.join,
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
