import 'package:amaz_corp_mobile/feature/schedule/add_schedule_screen.dart';
import 'package:amaz_corp_mobile/feature/schedule/list_schedule_screen.dart';
import 'package:amaz_corp_mobile/feature/task/add_task_screen.dart';
import 'package:amaz_corp_mobile/feature/task/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum ScheduleRouteName {
  schedules,
  scheduleID,
  scheduleAdd,
  tasks,
  taskAdd,
}

class ScheduleRoute {
  static List<GoRoute> create() {
    return [
      GoRoute(
        path: 'rooms/:roomID/schedules',
        name: ScheduleRouteName.schedules.name,
        redirect: (BuildContext context, GoRouterState state) {
          final roomID = state.pathParameters["roomID"];
          if (roomID == null) {
            return '/home';
          }
          return null;
        },
        builder: (context, state) => ListScheduleScreen(
          roomID: state.pathParameters['roomID']!,
        ),
      ),
      GoRoute(
        path: 'schedules/:scheduleID/tasks',
        name: ScheduleRouteName.scheduleID.name,
        redirect: (BuildContext context, GoRouterState state) {
          final scheduleID = state.pathParameters["scheduleID"];
          if (scheduleID == null) {
            return '/home';
          }
          return null;
        },
        builder: (context, state) => TaskScreen(
          scheduleID: state.pathParameters['scheduleID']!,
        ),
      ),
      GoRoute(
        path: 'schedules/:roomID/add',
        name: ScheduleRouteName.scheduleAdd.name,
        redirect: (BuildContext context, GoRouterState state) {
          final roomID = state.pathParameters["roomID"];
          if (roomID == null) {
            return '/home';
          }
          return null;
        },
        builder: (context, state) => AddScheduleScreen(
          roomID: state.pathParameters["roomID"]!,
        ),
      ),
      GoRoute(
        path: 'tasks/:scheduleID/add',
        name: ScheduleRouteName.taskAdd.name,
        redirect: (BuildContext context, GoRouterState state) {
          final scheduleID = state.pathParameters["scheduleID"];
          if (scheduleID == null) {
            return '/home';
          }
          return null;
        },
        builder: (context, state) => AddTaskScreen(
          scheduleID: state.pathParameters['scheduleID']!,
        ),
      ),
    ];
  }
}
