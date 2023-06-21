import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/feature/location/widget/list_location.dart';
import 'package:amaz_corp_mobile/feature/user/screen/login_screen.dart';
import 'package:amaz_corp_mobile/feature/user/screen/register_screen.dart';
import 'package:amaz_corp_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  location,
  login,
  register,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final localUserRepo = ref.watch(localUserRepoProvider);
  return GoRouter(
    initialLocation: '/',
    redirect: (BuildContext context, GoRouterState state) async {
      final bool isLoggedIn = await localUserRepo.isLoggedIn();
      final bool loggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn) {
        return '/login';
      }

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) {
        return '/';
      }

      return null;
    },
    // TODO: Add ErrorBuilder
    // errorBuilder: (context, state) => ,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const MyHomePage(
          title: "Welcome to Amaz",
        ),
        routes: [
          GoRoute(
            path: 'login',
            name: AppRoute.login.name,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: 'register',
            name: AppRoute.register.name,
            builder: (context, state) => const RegisterScreen(),
          ),
          GoRoute(
            path: 'locations',
            name: AppRoute.location.name,
            builder: (context, state) => const ListLocation(),
          )
        ],
      ),
    ],
  );
}
