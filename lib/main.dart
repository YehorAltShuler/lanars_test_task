import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_test_task/core/common/user/user_cubit.dart';
import 'package:lanars_test_task/features/auth/viewModel/bloc/auth_bloc.dart';
import 'package:lanars_test_task/features/home/viewModel/bloc/feeds_bloc.dart';
import 'package:lanars_test_task/injection_container.dart';

import 'core/navigation/app_router.dart';
import 'core/navigation/guards/auth_guard.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter
      _appRouter; // Инициализируем позже, чтобы передать AuthGuard

  @override
  void initState() {
    super.initState();
    final userCubit = sl<UserCubit>();
    final authGuard = AuthGuard(userCubit); // Создаем экземпляр AuthGuard
    _appRouter = AppRouter(authGuard: authGuard); // Передаем Guard в AppRouter
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppThemeCubit>(
          create: (BuildContext context) => sl(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => sl(),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) => sl(),
        ),
        BlocProvider<FeedsBloc>(
          create: (BuildContext context) => sl(),
        ),
      ],
      child: BlocBuilder<AppThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            routerConfig: _appRouter.config(),
            title: 'Lanars Test Task',
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _appRouter.dispose(); // Очищаем AppRouter, если требуется
    super.dispose();
  }
}
