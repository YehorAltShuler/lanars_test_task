import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lanars_test_task/core/common/user/user_cubit.dart';
import 'package:lanars_test_task/core/common/user/user_repository.dart';
import 'package:lanars_test_task/core/services/impl/random_user_service.dart';
import 'package:lanars_test_task/core/services/impl/pexels_service.dart';
import 'package:lanars_test_task/features/auth/model/auth_repository.dart';
import 'package:lanars_test_task/features/auth/viewModel/bloc/auth_bloc.dart';
import 'package:lanars_test_task/features/home/model/feeds_repository.dart';
import 'package:lanars_test_task/features/home/viewModel/bloc/feeds_bloc.dart';

import 'core/services/abstract/auth_service.dart';
import 'core/services/impl/objectbox_service.dart';
import 'core/services/impl/shared_preferences_service.dart';
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
  sl.registerSingleton<AuthService>(RandomUserService(sl()));
  sl.registerSingleton<PexelsService>(PexelsService(sl()));

  // Repositories
  sl.registerSingleton<AppThemeRepository>(AppThemeRepository(sl()));
  sl.registerSingleton<AuthRepository>(AuthRepository(sl(), sl()));
  sl.registerSingleton<UserRepository>(UserRepository(sl()));
  sl.registerSingleton<FeedsRepository>(FeedsRepository(sl<PexelsService>()));

  // Blocs
  sl.registerSingleton<AppThemeCubit>(AppThemeCubit(sl()));
  sl.registerSingleton<AuthBloc>(AuthBloc(sl()));
  sl.registerSingleton<UserCubit>(UserCubit(sl()));
  sl.registerSingleton<FeedsBloc>(FeedsBloc(sl()));
}
