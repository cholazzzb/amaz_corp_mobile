import 'package:flutter/material.dart';

class PlainLayout extends StatelessWidget {
  const PlainLayout({super.key, required this.child});

  final Widget child;

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

    return Scaffold(
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
