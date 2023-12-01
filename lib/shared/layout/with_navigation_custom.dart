import 'package:amaz_corp_mobile/core/building/service/building_service.dart';
import 'package:amaz_corp_mobile/feature/drawer/building_drawer.dart';
import 'package:amaz_corp_mobile/feature/drawer/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WithNavigationCustomLayout extends ConsumerWidget {
  final Widget child;
  final String title;
  final int selectedIdx;
  final Widget? floatingActionButton;

  const WithNavigationCustomLayout({
    super.key,
    required this.child,
    required this.title,
    required this.selectedIdx,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    Widget childWithTheme = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: child,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawerEnableOpenDragGesture: true,
      drawer: const BuildingDrawer(),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: const MenuDrawer(),
      onDrawerChanged: (isOpened) {
        ref.invalidate(getMyBuildingsProvider);
      },
      floatingActionButton: floatingActionButton,
      body: childWithTheme,
    );
  }
}
