import 'package:amaz_corp_mobile/feature/building/building_screen.dart';
import 'package:amaz_corp_mobile/feature/home/home_screen.dart';
import 'package:amaz_corp_mobile/feature/location/widget/list_location.dart';
import 'package:go_router/go_router.dart';

enum LocationRouteName {
  home,
  location,
  roomID,
}

class LocationRoute {
  static List<GoRoute> create() {
    return [
      GoRoute(
        path: 'home',
        name: LocationRouteName.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: 'locations',
        name: LocationRouteName.location.name,
        builder: (context, state) => const ListLocation(),
      ),
      GoRoute(
        path: 'building/rooms',
        name: LocationRouteName.roomID.name,
        builder: (context, state) => const BuildingScreen(),
      ),
    ];
  }
}
