import 'package:amaz_corp_mobile/shared/layout/with_navigation_custom.dart';
import 'package:flutter/material.dart';

class EmptyLayout extends StatelessWidget {
  final String title;
  final String message;

  const EmptyLayout({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return WithNavigationCustomLayout(
      title: title,
      selectedIdx: 0,
      child: Empty(message: message),
    );
  }
}

class Empty extends StatelessWidget {
  final String message;

  const Empty({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(message)],
      ),
    );
  }
}
