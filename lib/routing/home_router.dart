import 'package:amaz_corp_mobile/feature/building/list_building_screen.dart';
import 'package:go_router/go_router.dart';

enum HomeRouteName {
  home,
}

final List<GoRoute> homeRoutes = [
  GoRoute(
    path: 'home',
    name: HomeRouteName.home.name,
    builder: (context, state) => const ListBuildingScreen(),
    // builder: (context, state) => const HomeScreen(),
  )
];
