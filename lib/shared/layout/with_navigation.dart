import 'package:amaz_corp_mobile/core/remoteconfig/service/force_update_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WithNavigationLayout extends ConsumerWidget {
  const WithNavigationLayout({
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
          // context.go("/force-update");
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
          context.go('/locations');
        case 1:
          context.go('/profile');
      }
    }

    return Scaffold(
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
                      icon: Icon(Icons.place),
                      label: 'Locations',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
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
