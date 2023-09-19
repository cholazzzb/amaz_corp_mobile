import 'package:amaz_corp_mobile/core/remoteconfig/service/force_update_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Layout extends ConsumerWidget {
  const Layout({
    super.key,
    required this.child,
    required this.title,
    required this.selectedIdx,
  });

  final Widget child;
  final String title;
  final int selectedIdx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forceUpdateAsync = ref.watch(checkForceUpdateProvider);
    forceUpdateAsync.when(
      data: (needForceUpdate) {
        if (needForceUpdate) {
          context.go("/force-update");
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
          context.go('/');
        case 1:
          context.go('/login');
        case 2:
          context.go('/locations');
      }
    }

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: childWithTheme,
              ),
              SafeArea(
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.people),
                      label: 'Friends',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.place),
                      label: 'Locations',
                    ),
                  ],
                  currentIndex: selectedIdx,
                  onTap: (idx) => onItemTapped(idx, context),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
