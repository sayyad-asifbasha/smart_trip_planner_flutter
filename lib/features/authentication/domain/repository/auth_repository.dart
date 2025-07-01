import 'package:smart_trip_planner/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:smart_trip_planner/core/common/entities/user.dart' show user;
abstract interface class authRepository{
  Future<Either<Failure, user >> signUpWithEmailPassword({
    required String email,
    required String password,
    required String confirmPassword,
  });
  Future<Either<Failure, user>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure,user>> signInWithGoogle();
  Future<Either<Failure,user>> getCurrentUserData();
}