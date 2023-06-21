import 'package:amaz_corp_mobile/feature/location/widget/list_location.dart';
import 'package:amaz_corp_mobile/shared/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(title: 'Home', child: ListLocation());
  }
}
