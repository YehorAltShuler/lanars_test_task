import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';
import 'guards/auth_guard.dart';

class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;

  AppRouter({required this.authGuard});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SignInRoute.page,
          path: '/sign-in',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          guards: [authGuard],
        ),
      ];
}
