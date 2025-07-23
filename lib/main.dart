import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:studio93/domain/firebase_repo_interface.dart';
import 'package:studio93/res/app_colors.dart';
import 'package:studio93/res/theme.dart';

import 'data/repository/auth_repo.dart';
import 'data/repository/firebase_repo.dart';
import 'firebase_options.dart';
import 'view/home_screen/bloc/home_bloc.dart';
import 'view/home_screen/home_screen.dart';

final getIt = GetIt.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerLazySingleton<FirebaseRepoInterface>(() => FirebaseRepo());
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo());
  await ScreenUtil.ensureScreenSize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(_MyApp());
}

class _MyApp extends StatefulWidget {
  const _MyApp();
  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => FirebaseRepo()),
        RepositoryProvider(create: (context) => AuthRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                HomeBloc(firebaseRepoInterface: getIt(), authRepo: getIt()),
          ),
        ],
        child: ScreenUtilInit(
          minTextAdapt: true,
          ensureScreenSize: true,
          useInheritedMediaQuery: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Task App',
              theme: lightTheme(context, AppColors.primaryColor),
              home: HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
