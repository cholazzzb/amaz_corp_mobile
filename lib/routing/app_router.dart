import 'package:amaz_corp_mobile/feature/schedule/add_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/feature/building/building_screen.dart';
import 'package:amaz_corp_mobile/feature/home/home_screen.dart';
import 'package:amaz_corp_mobile/feature/location/widget/list_location.dart';
import 'package:amaz_corp_mobile/feature/profile/profile_screen.dart';
import 'package:amaz_corp_mobile/feature/remoteconfig/force_update_screen.dart';
import 'package:amaz_corp_mobile/feature/schedule/list_schedule_screen.dart';
import 'package:amaz_corp_mobile/feature/schedule/schedule_screen.dart';
import 'package:amaz_corp_mobile/feature/task/task_screen.dart';
import 'package:amaz_corp_mobile/feature/user/screen/login_screen.dart';
import 'package:amaz_corp_mobile/feature/user/screen/register_screen.dart';
import 'package:amaz_corp_mobile/main.dart';

part 'app_router.g.dart';

enum AppRoute {
  welcome,
  home,
  location,
  roomID,
  scheduleID,
  tasksID,
  login,
  register,
  profile,
  forceUpdate,
}

enum LocationRoute {
  rooms,
}

enum RoomRoute {
  schedules,
  scheduleID,
  scheduleAdd,
  tasks,
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

      if (isLoggedIn && isPublicLocation) {
        return '/home';
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
            path: 'home',
            name: AppRoute.home.name,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: 'locations',
            name: AppRoute.location.name,
            builder: (context, state) => const ListLocation(),
          ),
          GoRoute(
            path: 'building/rooms',
            name: AppRoute.roomID.name,
            builder: (context, state) => const BuildingScreen(),
          ),
          GoRoute(
            path: 'rooms/:roomID/schedules',
            name: RoomRoute.schedules.name,
            redirect: (BuildContext context, GoRouterState state) {
              final roomID = state.pathParameters["roomID"];
              if (roomID == null) {
                return 'home';
              }
              return null;
            },
            builder: (context, state) => ListScheduleScreen(
              roomID: state.pathParameters['roomID']!,
            ),
          ),
          // GoRoute(
          //   path: 'schedules/:scheduleID/task',
          //   name: RoomRoute.scheduleID.name,
          //   builder: (context, state) => ScheduleScreen(
          //     scheduleID: state.pathParameters['scheduleID'],
          //   ),
          // ),
          GoRoute(
            path: 'schedules/add',
            name: RoomRoute.scheduleAdd.name,
            builder: (context, state) => AddScheduleScreen(
              roomID: state.extra as String,
            ),
          ),
          GoRoute(
            path: 'building/tasks',
            name: AppRoute.tasksID.name,
            builder: (context, state) => const TaskScreen(),
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
