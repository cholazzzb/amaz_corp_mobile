import 'package:amaz_corp_mobile/feature/building/building_screen.dart';
import 'package:amaz_corp_mobile/feature/building/list_building_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum LocationRouteName {
  home,
  location,
  buildingID,
}

final List<GoRoute> locationRoute = [
  GoRoute(
    path: 'locations',
    name: LocationRouteName.location.name,
    builder: (context, state) => const ListBuildingScreen(),
  ),
  GoRoute(
    path: 'building/:buildingID',
    name: LocationRouteName.buildingID.name,
    redirect: (BuildContext context, GoRouterState state) {
      final buildingID = state.pathParameters["buildingID"];
      if (buildingID == null) {
        return '/home';
      }
      return null;
    },
    builder: (context, state) => BuildingScreen(
      buildingID: state.pathParameters["buildingID"]!,
    ),
  ),
];
