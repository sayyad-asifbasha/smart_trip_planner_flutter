import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_trip_planner/core/common/navigation/app_navigation.dart';
import 'package:smart_trip_planner/core/common/utils/validation_utils.dart';
import 'package:smart_trip_planner/core/utils/size_config.dart';
import 'package:smart_trip_planner/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:smart_trip_planner/features/authentication/presentation/widgets/custom_text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
        AuthenticationLogin(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          setState(() => isLoading = true);
        } else {
          setState(() => isLoading = false);
        }

        if (state is AuthenticationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to home page after successful authentication
          AppNavigation.instance.navigateToHomeAfterAuth(context);
        }

        if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(SizeConfig.screenHeight! * 0.025),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: 0.785398, // 45 degrees in radians = π/4 ≈ 0.785398
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          const LinearGradient(
                            colors: [Color(0xFFFFAE00), Color(0xFFCD941B)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: const Icon(
                        Icons.flight,
                        size: 25,
                        color: Colors.white, // Required to reveal gradient
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Itinera AI",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal! * 7,
                right: SizeConfig.safeBlockHorizontal! * 7,
                top: SizeConfig.safeBlockVertical! * 3,
              ),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        "Hi, Welcome Back",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Login to your account",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthenticationBloc>().add(
                            AuthenticationGoogle(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: const BorderSide(
                              color: Color(0xFFD8DAE5),
                              width: 1,
                            ),
                          ),
                        ),
                        child: SizedBox(
                          height: SizeConfig.safeBlockVertical! * 7,
                          width: SizeConfig.safeBlockHorizontal! * 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/Google Icon.png',
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Sign in with Google',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical! * 4),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Color(0xFFE6E8F0),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Or Sign in with Email",
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Color(0xFFE6E8F0),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical! * 4),

                      CustomTextField(
                        label: "Email address",
                        hintText: "john@example.com",
                        controller: emailController,
                        icon: Icons.email_outlined,
                        validator: ValidationUtils.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: "Password",
                        hintText: "Enter password",
                        controller: passwordController,
                        icon: Icons.lock_outline,
                        isPassword: true,
                        validator: ValidationUtils.validatePassword,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.6,
                            child: SizedBox(
                              width: SizeConfig.blockSizeVertical! * 3,
                              child: Checkbox(
                                value: rememberMe,
                                activeColor: const Color(
                                  0xFF065F46,
                                ), // green checkbox
                                onChanged: (val) {
                                  setState(() {
                                    rememberMe = val!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Remember me",
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(fontSize: 12, color: Colors.black),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // Handle forgot password
                            },
                            child: Text(
                              "Forgot your password?",
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(fontSize: 12, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: isLoading ? null : _handleSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF065F46),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          minimumSize: Size(
                            double.infinity,
                            SizeConfig.blockSizeVertical! * 7,
                          ), // full width + height
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                "Log in",
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextButton(
                            onPressed: () {
                              AppNavigation.instance.navigateToSignUpFromSignIn(
                                context,
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    color: const Color(0xFF065F46),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
