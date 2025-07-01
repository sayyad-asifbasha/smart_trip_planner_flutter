import 'package:flutter/material.dart';

class AppNavigation {
  static final AppNavigation _instance = AppNavigation._internal();
  factory AppNavigation() => _instance;
  AppNavigation._internal();

  static AppNavigation get instance => _instance;

  // Navigation keys
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Route names
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String dashboard = '/dashboard';

  // Navigation methods
  void navigateToSignIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, signIn);
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.pushNamed(context, signUp);
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, home);
  }

  void navigateToDashboard(BuildContext context) {
    Navigator.pushReplacementNamed(context, dashboard);
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void navigateToSignUpFromSignIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, signUp);
  }

  void navigateToSignInFromSignUp(BuildContext context) {
    Navigator.pushReplacementNamed(context, signIn);
  }

  // Clear navigation stack and go to home (after successful authentication)
  void navigateToHomeAfterAuth(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, home, (route) => false);
  }

  // Clear navigation stack and go to sign in (after logout)
  void navigateToSignInAfterLogout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, signIn, (route) => false);
  }
}
