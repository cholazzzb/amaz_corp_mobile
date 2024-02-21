import 'package:amaz_corp_mobile/core/building/repository/local_location_repo.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/feature/profile/profile_screen.dart';
import 'package:amaz_corp_mobile/feature/remoteconfig/force_update_screen.dart';
import 'package:amaz_corp_mobile/main.dart';
import 'package:amaz_corp_mobile/routing/home_router.dart';
import 'package:amaz_corp_mobile/routing/location_router.dart';
import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:amaz_corp_mobile/routing/user_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  welcome,
  profile,
  forceUpdate,
}

final publicRoute = {"/", "/register", "/login"};

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final localUserRepo = ref.watch(localUserRepoProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (BuildContext context, GoRouterState state) async {
      final bool isLoggedIn = await localUserRepo.isLoggedIn();
      bool isPublicLocation = publicRoute.contains(state.matchedLocation);

      if (!isLoggedIn && !isPublicLocation) {
        return '/login';
      }

      String buildingID =
          await ref.watch(localBuildingRepoProvider).getActiveBuildingID();

      if (isLoggedIn && isPublicLocation) {
        if (buildingID.isEmpty) {
          return '/home';
        }
        return '/building/$buildingID';
      }

      return null;
    },
    // TODO: Add ErrorBuilder
    // errorBuilder: (context, state) => ,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.welcome.name,
        builder: (context, state) => const LandingPage(
          title: "Welcome to Amaz",
        ),
        routes: [
          ...homeRoutes,
          ...userRoute,
          ...locationRoute,
          ...scheduleRoute,
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
