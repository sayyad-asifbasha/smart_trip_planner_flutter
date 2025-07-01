import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:smart_trip_planner/core/error/exception.dart';
import 'package:smart_trip_planner/core/error/failure.dart';
import 'package:smart_trip_planner/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:smart_trip_planner/core/common/entities/user.dart' show user;
import 'package:smart_trip_planner/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements authRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, user>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, user>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );
  }

  Future<Either<Failure, user>> _getUser(Future<user> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message as String));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, user>> getCurrentUserData() async {
    try{
      final user=await authRemoteDataSource.getCurrentUserData();
      if(user==null)
        {
          return Left(Failure("User not logged in"));
        }
      return right(user);
    }catch(e) {
      throw ServerException(e.toString());
    }
  }

  @override
   Future<Either<Failure, user>> signInWithGoogle() async {
    try {
      final user = await authRemoteDataSource.signInWithGoogle();
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? "Unknown Firebase error"));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

}
