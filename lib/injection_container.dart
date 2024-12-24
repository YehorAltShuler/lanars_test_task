import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lanars_test_task/core/common/user/user_cubit.dart';
import 'package:lanars_test_task/core/common/user/user_repository.dart';
import 'package:lanars_test_task/core/services/auth_service.dart';
import 'package:lanars_test_task/features/auth/model/auth_repository.dart';
import 'package:lanars_test_task/features/auth/viewModel/bloc/auth_bloc.dart';

import 'core/services/objectbox_service.dart';
import 'core/services/shared_preferences_service.dart';
import 'core/theme/app_theme_cubit.dart';
import 'core/theme/app_theme_repository.dart';

final sl = GetIt.instance;
late ObjectboxService objectboxService;

Future<void> initDependencies() async {
  await ObjectboxService.initialize();
  final objectBoxService = ObjectboxService.instance;

  final sharedPreferencesService = await SharedPreferencesService.getInstance();

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Services
  sl.registerSingleton<SharedPreferencesService>(sharedPreferencesService);
  sl.registerSingleton<ObjectboxService>(objectBoxService);
  sl.registerSingleton<AuthService>(AuthService(sl()));

  // Repositories
  sl.registerSingleton<AppThemeRepository>(AppThemeRepository(sl()));
  sl.registerSingleton<AuthRepository>(AuthRepository(sl(), sl()));
  sl.registerSingleton<UserRepository>(UserRepository(sl()));

  // Blocs
  sl.registerSingleton<AppThemeCubit>(AppThemeCubit(sl()));
  sl.registerSingleton<AuthBloc>(AuthBloc(sl()));
  sl.registerSingleton<UserCubit>(UserCubit(sl()));
}
