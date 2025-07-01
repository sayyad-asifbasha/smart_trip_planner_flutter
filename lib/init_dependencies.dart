import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_trip_planner/core/common/cubits/app_user_cubit.dart';
import 'package:smart_trip_planner/core/utils/size_config.dart';
import 'package:smart_trip_planner/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:smart_trip_planner/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:smart_trip_planner/features/authentication/domain/repository/auth_repository.dart';
import 'package:smart_trip_planner/features/authentication/domain/usecases/current_user.dart';
import 'package:smart_trip_planner/features/authentication/domain/usecases/user_login.dart';
import 'package:smart_trip_planner/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:smart_trip_planner/features/authentication/domain/usecases/user_sign_up_google.dart';
import 'package:smart_trip_planner/features/authentication/presentation/bloc/authentication_bloc.dart';

import 'firebase_options.dart';

final serviceLocator = GetIt.instance;

final sizeConfig = serviceLocator<SizeConfig>();

Future<void> initDependencies() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  serviceLocator.registerSingleton(SizeConfig());
  serviceLocator.registerLazySingleton(()=>AppUserCubit());

  _initAuthentication();

}

void _initAuthentication() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  serviceLocator.registerFactory<authRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));
  serviceLocator.registerFactory(() => SignInWithGoogle(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthenticationBloc(
      userSignup: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      signInWithGoogle: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}
