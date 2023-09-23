import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/feature/building/building_screen.dart';
import 'package:amaz_corp_mobile/feature/location/widget/list_location.dart';
import 'package:amaz_corp_mobile/feature/profile/profile_screen.dart';
import 'package:amaz_corp_mobile/feature/remoteconfig/force_update_screen.dart';
import 'package:amaz_corp_mobile/feature/user/screen/login_screen.dart';
import 'package:amaz_corp_mobile/feature/user/screen/register_screen.dart';
import 'package:amaz_corp_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  welcome,
  location,
  roomID,
  login,
  register,
  profile,
  forceUpdate,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final localUserRepo = ref.watch(localUserRepoProvider);
  return GoRouter(
    initialLocation: '/',
    redirect: (BuildContext context, GoRouterState state) async {
      final bool isLoggedIn = await localUserRepo.isLoggedIn();
      final bool notLoggedRoute =
          state.matchedLocation == '/' || state.matchedLocation == '/login';

      if (!isLoggedIn) {
        return '/login';
      }

      // if the user is logged in but still on the login page, send them to
      // the welcome page
      if (notLoggedRoute) {
        return '/locations';
      }

      return null;
    },
    // TODO: Add ErrorBuilder
    // errorBuilder: (context, state) => ,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.welcome.name,
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
          ),
          GoRoute(
            path: 'building/list-room',
            name: AppRoute.roomID.name,
            builder: (context, state) {
              Building building = state.extra as Building;
              return BuildingScreen(
                building: building,
              );
            },
          ),
          GoRoute(
            path: 'profile',
            name: AppRoute.profile.name,
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: 'force-update',
            name: AppRoute.forceUpdate.name,
            builder: (context, state) => const ForceUpdateScreen(),
          )
        ],
      ),
    ],
  );
}
