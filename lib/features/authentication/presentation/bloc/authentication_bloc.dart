// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_trip_planner/core/common/cubits/app_user_cubit.dart';
// import 'package:smart_trip_planner/core/common/entities/user.dart' show user;
// import 'package:smart_trip_planner/features/authentication/domain/usecases/current_user.dart' hide NoParams;
// import 'package:smart_trip_planner/features/authentication/domain/usecases/user_login.dart';
// import 'package:smart_trip_planner/features/authentication/domain/usecases/user_sign_up.dart';
// import 'package:smart_trip_planner/features/authentication/domain/usecases/user_sign_up_google.dart' hide NoParams;
//
// part 'authentication_event.dart';
// part 'authentication_state.dart';
//
// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final UserSignUp _userSignUp;
//   final UserLogin _userLogin;
//   final CurrentUser _currentUser;
//   final SignInWithGoogle _signInWithGoogle;
//   final AppUserCubit _appUserCubit;
//   AuthenticationBloc({
//     required UserSignUp userSignup,
//     required UserLogin userLogin,
//     required CurrentUser currentUser,
//     required SignInWithGoogle signInWithGoogle,
//     required AppUserCubit appUserCubit,
//   }) : _userSignUp = userSignup,
//        _userLogin = userLogin,
//        _currentUser = currentUser,
//         _signInWithGoogle=signInWithGoogle,
//        _appUserCubit=appUserCubit,
//        super(AuthenticationInitial()) {
//     on<AuthenticationSignUp>(_onSignUp);
//     on<AuthenticationLogin>(_onLogin);
//     on<AuthenticationGoogle>(_onGoogleSignIn);
//     on<AuthIsUserLoggedIn>(_isUserLoggedIn);
//   }
//   void _onGoogleSignIn(
//       AuthenticationGoogle event,
//       Emitter<AuthenticationState> emit,
//       ) async {
//     final response = await _signInWithGoogle(NoParams());
//     response.fold(
//           (l) => emit(AuthenticationFailure(l.message)),
//           (user) => _emitAuthSuccess(user,emit),
//     );
//   }
//   void _isUserLoggedIn(
//     AuthIsUserLoggedIn event,
//     Emitter<AuthenticationState> emit,
//   ) async {
//     final response = await _currentUser(NoParams());
//     response.fold(
//       (l) => emit(AuthenticationFailure(l.message)),
//           (user) => _emitAuthSuccess(user,emit),
//     );
//   }
//
//   void _onSignUp(
//     AuthenticationSignUp event,
//     Emitter<AuthenticationState> emit,
//   ) async {
//     emit(AuthenticationLoading());
//     final response = await _userSignUp.call(
//       UserSignUpParams(
//         email: event.email,
//         password: event.password,
//         confirmPassword: event.confirmPassword,
//       ),
//     );
//     response.fold(
//       (l) => emit(AuthenticationFailure(l.message)),
//           (user) => _emitAuthSuccess(user,emit),
//     );
//   }
//
//   void _onLogin(
//     AuthenticationLogin event,
//     Emitter<AuthenticationState> emit,
//   ) async {
//     emit(AuthenticationLoading());
//     final response = await _userLogin.call(
//       UserLoginParams(email: event.email, password: event.password),
//     );
//     response.fold(
//       (l) => emit(AuthenticationFailure(l.message)),
//       (user) => _emitAuthSuccess(user,emit),
//     );
//   }
//
//
//   void _emitAuthSuccess(user User,Emitter<AuthenticationState>emit){
//     _appUserCubit.updateUserStatus(User);
//     emit(AuthenticationSuccess(User));
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_trip_planner/core/common/cubits/app_user_cubit.dart';
import 'package:smart_trip_planner/core/common/entities/user.dart';
import 'package:smart_trip_planner/core/error/failure.dart';
import 'package:smart_trip_planner/core/usecase/usecase.dart' hide NoParams;
import 'package:smart_trip_planner/features/authentication/domain/usecases/current_user.dart';
import 'package:smart_trip_planner/features/authentication/domain/usecases/user_login.dart';
import 'package:smart_trip_planner/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:smart_trip_planner/features/authentication/domain/usecases/user_sign_up_google.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final SignInWithGoogle _signInWithGoogle;
  final AppUserCubit _appUserCubit;

  AuthenticationBloc({
    required UserSignUp userSignup,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required SignInWithGoogle signInWithGoogle,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignup,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _signInWithGoogle = signInWithGoogle,
        _appUserCubit = appUserCubit,
        super(AuthenticationInitial()) {
    on<AuthenticationEvent>((_,emit)=>emit(AuthenticationLoading()));
    on<AuthenticationSignUp>(_onSignUp);
    on<AuthenticationLogin>(_onLogin);
    on<AuthenticationGoogle>(_onGoogleSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _onGoogleSignIn(
      AuthenticationGoogle event,
      Emitter<AuthenticationState> emit,
      ) async {
    final response = await _signInWithGoogle(withoutParams());
    response.fold(
          (l) => emit(AuthenticationFailure(l.message)),
          (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedIn event,
      Emitter<AuthenticationState> emit,
      ) async {
    final response = await _currentUser(NoParams());
    response.fold(
          (l) => emit(AuthenticationFailure(l.message)),
          (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onSignUp(
      AuthenticationSignUp event,
      Emitter<AuthenticationState> emit,
      ) async {
    final response = await _userSignUp.call(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      ),
    );
    response.fold(
          (l) => emit(AuthenticationFailure(l.message)),
          (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onLogin(
      AuthenticationLogin event,
      Emitter<AuthenticationState> emit,
      ) async {
    final response = await _userLogin.call(
      UserLoginParams(email: event.email, password: event.password),
    );
    response.fold(
          (l) => emit(AuthenticationFailure(l.message)),
          (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(user currentUser, Emitter<AuthenticationState> emit) {
    _appUserCubit.updateUserStatus(currentUser);
    emit(AuthenticationSuccess(currentUser));
  }
}