import 'package:amaz_corp_mobile/feature/drawer/building_drawer.dart';
import 'package:flutter/material.dart';

class PlainLayout extends StatelessWidget {
  const PlainLayout({
    super.key,
    required this.child,
    this.title,
  });

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    Widget childWithTheme = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: child,
      ),
    );

    final appBar = title != null ? AppBar(title: Text(title ?? '')) : null;
    final drawer = title != null ? const BuildingDrawer() : null;

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Expanded(
                child: childWithTheme,
              )
            ],
          );
        },
      ),
    );
  }
}
