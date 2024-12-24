import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/services/shared_preferences_service.dart';
import 'core/theme/app_theme_cubit.dart';
import 'core/theme/app_theme_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPreferencesService = await SharedPreferencesService.getInstance();
  //Dio
  sl.registerSingleton<Dio>(Dio());

  //Services
  sl.registerSingleton<SharedPreferencesService>(sharedPreferencesService);

  //Repositories
  sl.registerSingleton<AppThemeRepository>(AppThemeRepository(sl()));

  //Blocs
  sl.registerSingleton<AppThemeCubit>(AppThemeCubit(sl()));
}
