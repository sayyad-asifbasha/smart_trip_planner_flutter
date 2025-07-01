import 'package:fpdart/fpdart.dart';
import 'package:smart_trip_planner/core/common/entities/user.dart';
import 'package:smart_trip_planner/core/error/failure.dart';
import 'package:smart_trip_planner/core/usecase/usecase.dart';
import 'package:smart_trip_planner/features/authentication/domain/repository/auth_repository.dart';
//
// class SignInWithGoogle implements UseCase<user, NoParams> {
//   final authRepository _authRepository;
//   SignInWithGoogle(this._authRepository);
//
//   @override
//   Future<Either<Failure, user>> call(NoParams params) async {
//     return await _authRepository.signInWithGoogle();
//   }
// }
// class NoParams{
//
// }
// import 'package:fpdart/fpdart.dart';
// import 'package:smart_trip_planner/core/error/failure.dart';
// import 'package:smart_trip_planner/core/usecase/usecase.dart';
// import 'package:smart_trip_planner/core/common/entities/user.dart' show user;
// import 'package:smart_trip_planner/features/authentication/domain/repository/auth_repository.dart';

class SignInWithGoogle implements UseCase<user, withoutParams> {
  final authRepository _authRepository;
  SignInWithGoogle(this._authRepository);
  @override
  Future<Either<Failure, user>> call(withoutParams params) async
  {
    return await _authRepository.signInWithGoogle();
  }
}

class withoutParams {
}

