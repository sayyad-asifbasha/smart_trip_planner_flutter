import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_trip_planner/core/common/entities/user.dart';

class UserModel extends user {
  UserModel({required super.email, required super.uid});

  factory UserModel.fromFirebaseUser(User firebaseUser) {
    return UserModel(
      email: firebaseUser.email ?? '',
      uid: firebaseUser.uid,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': uid,
    };
  }
}
