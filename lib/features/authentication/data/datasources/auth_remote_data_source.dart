import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_trip_planner/core/common/entities/user.dart' show user;
import 'package:smart_trip_planner/core/error/exception.dart';
import 'package:smart_trip_planner/features/authentication/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String confirmPassword,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel> signInWithGoogle();
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      if (password != confirmPassword) {
        throw ServerException("Passwords do not match");
      }

      final credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userData = credentials.user;
      if (userData == null) throw ServerException("User is null");

      return UserModel.fromFirebaseUser(userData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userData = credentials.user;
      if (userData == null) throw ServerException("User is null");

      return UserModel.fromFirebaseUser(userData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final userData = firebaseAuth.currentUser;
      if (userData == null) return null;

      return UserModel.fromFirebaseUser(userData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw ServerException("Google sign-in cancelled");

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );

      final userData = userCredential.user;
      if (userData == null) throw ServerException("User is null");

      return UserModel.fromFirebaseUser(userData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
