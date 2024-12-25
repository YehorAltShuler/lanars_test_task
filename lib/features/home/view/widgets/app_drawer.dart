import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_test_task/core/common/user/user_cubit.dart';
import 'package:lanars_test_task/core/theme/app_theme_cubit.dart';

import '../../../../core/navigation/app_router.gr.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final user = context.read<UserCubit>().state;
    final appThemeCubit = context.read<AppThemeCubit>();

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28, left: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Theme.of(context).brightness == Brightness.dark
                        ? IconButton(
                            onPressed: () {
                              appThemeCubit.setThemeMode(ThemeMode.light);
                            },
                            icon: const Icon(Icons.sunny),
                          )
                        : IconButton(
                            onPressed: () {
                              appThemeCubit.setThemeMode(ThemeMode.dark);
                            },
                            icon: const Icon(Icons.nightlight_round),
                          ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: user!.profilePictureUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        user.username.isNotEmpty
                            ? Text(user.username,
                                style: Theme.of(context).textTheme.bodyLarge)
                            : const SizedBox(),
                        const SizedBox(height: 2),
                        Text(user.email,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Log out'),
                      content: Text('Are you shure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.router.maybePop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            userCubit.clearUser();
                            context.router.replace(SignInRoute());
                          },
                          child: Text('Log out'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.login,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              label: Text('Log out'),
            ),
          ),
        ],
      ),
    );
  }
}
