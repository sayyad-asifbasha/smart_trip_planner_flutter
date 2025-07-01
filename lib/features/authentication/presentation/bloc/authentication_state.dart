part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState{
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState{}

final class AuthenticationLoading extends AuthenticationState{}

final class AuthenticationSuccess extends AuthenticationState{
  final user User;

  AuthenticationSuccess(this.User);
}

final class AuthenticationFailure extends AuthenticationState{
  final String message;

  const AuthenticationFailure(this.message);

}
