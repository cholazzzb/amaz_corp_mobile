import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Rethinking about this
    // Get My Buildings
    /**
     * If my buildings === 0
     *  you dont have any buildings yet -> Button to Search Building
     * else
     *  check the buildingID from hive
     *  if found => redirect to /building/[buildingID]
     */
    return const WithNavigationLayout(
      title: 'Home',
      selectedIdx: 0,
      child: Text("You don'"),
    );
  }
}
