import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_trip_planner/core/common/cubits/app_user_cubit.dart';
import 'package:smart_trip_planner/core/common/navigation/app_navigation.dart';
import 'package:smart_trip_planner/core/theme/app_theme.dart';
import 'package:smart_trip_planner/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:smart_trip_planner/features/authentication/presentation/pages/signin_page.dart';
import 'package:smart_trip_planner/features/authentication/presentation/pages/signup_page.dart';
import 'package:smart_trip_planner/features/home/presentation/pages/home_page.dart';

import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF5F5F7),
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthenticationBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Itinera AI',
      theme: AppTheme.lightTheme,
      navigatorKey: AppNavigation.navigatorKey,
      initialRoute: AppNavigation.signIn,
      routes: {
        AppNavigation.signIn: (context) => const SignIn(),
        AppNavigation.signUp: (context) => const SignUp(),
        AppNavigation.home: (context) => const HomePage(),
      },
    );
  }
}
