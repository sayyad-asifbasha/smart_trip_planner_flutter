import 'package:fpdart/fpdart.dart';
import 'package:smart_trip_planner/core/error/failure.dart';
import 'package:smart_trip_planner/core/usecase/usecase.dart';
import 'package:smart_trip_planner/core/common/entities/user.dart' show user;
import 'package:smart_trip_planner/features/authentication/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<user, UserLoginParams> {
  final authRepository _authRepository;
  UserLogin(this._authRepository);
  @override
  Future<Either<Failure, user>> call(UserLoginParams params)async {

    return await _authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
