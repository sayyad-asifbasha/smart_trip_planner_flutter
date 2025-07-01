import 'package:fpdart/fpdart.dart';
import 'package:smart_trip_planner/core/error/failure.dart';
import 'package:smart_trip_planner/core/usecase/usecase.dart';
import 'package:smart_trip_planner/core/common/entities/user.dart' show user;
import 'package:smart_trip_planner/features/authentication/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<user, UserSignUpParams> {
  final authRepository _authRepository;
  UserSignUp(this._authRepository);
  @override
  Future<Either<Failure, user>> call(UserSignUpParams params)async {

    return await _authRepository.signUpWithEmailPassword(
      email: params.email,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String confirmPassword;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
