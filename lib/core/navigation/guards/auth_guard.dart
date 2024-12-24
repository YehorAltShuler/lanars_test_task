import 'package:auto_route/auto_route.dart';
import '../../common/user/user_cubit.dart';
import '../app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final UserCubit userCubit;

  AuthGuard(this.userCubit);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final user = userCubit.state;

    if (user != null) {
      resolver.next();
    } else {
      router.push(SignInRoute());
    }
  }
}
