part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class AuthenticationSignUp extends AuthenticationEvent {
  final String email;
  final String password;
  final String confirmPassword;

  AuthenticationSignUp({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

final class AuthenticationLogin extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationLogin({
    required this.email,
    required this.password,
  });
}

final class AuthenticationGoogle extends AuthenticationEvent{}


final class AuthIsUserLoggedIn extends AuthenticationEvent{}
