import 'package:amaz_corp_mobile/core/building/service/building_service.dart';
import 'package:amaz_corp_mobile/core/remoteconfig/service/force_update_service.dart';
import 'package:amaz_corp_mobile/feature/drawer/building_drawer.dart';
import 'package:amaz_corp_mobile/feature/drawer/menu_drawer.dart';
import 'package:amaz_corp_mobile/routing/app_router.dart';
import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WithNavigationLayout extends ConsumerWidget {
  final Widget child;
  final String title;
  final int selectedIdx;
  final Widget? floatingActionButton;

  const WithNavigationLayout({
    super.key,
    required this.child,
    required this.title,
    required this.selectedIdx,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forceUpdateAsync = ref.watch(checkForceUpdateProvider);
    forceUpdateAsync.when(
      data: (needForceUpdate) {
        if (needForceUpdate) {
          // context.goNamed(AppRoute.forceUpdate.name);
        }
      },
      error: (e, st) {},
      loading: () {},
    );

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    Widget childWithTheme = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: child,
      ),
    );

    void onItemTapped(int index, BuildContext context) {
      switch (index) {
        case 0:
          context.goNamed(
            ScheduleRouteName.schedules.name,
            pathParameters: {'scheduleID': ''},
          );
          break;
        case 1:
          context.goNamed(ScheduleRouteName.tasks.name);
          break;
        case 2:
          context.goNamed(AppRoute.profile.name);
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawerEnableOpenDragGesture: true,
      drawer: const BuildingDrawer(),
      // endDrawerEnableOpenDragGesture: true,
      // endDrawer: const MenuDrawer(),
      onDrawerChanged: (isOpened) {
        ref.invalidate(getMyBuildingsProvider);
      },
      floatingActionButton: floatingActionButton,
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_month),
      //       label: 'Schedules',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.task),
      //       label: 'Tasks',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Rooms',
      //     ),
      //   ],
      //   currentIndex: selectedIdx,
      //   onTap: (idx) => onItemTapped(idx, context),
      // ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: childWithTheme,
              ),
            ],
          );
        },
      ),
    );
  }
}
