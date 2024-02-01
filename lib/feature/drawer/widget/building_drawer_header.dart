import 'package:amaz_corp_mobile/routing/location_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuildingDrawerHeader extends StatelessWidget {
  const BuildingDrawerHeader({
    super.key,
    required this.logout,
  });

  final VoidCallback logout;

  @override
  Widget build(BuildContext context) {
    void onPressHome() {
      context.goNamed(LocationRouteName.home.name);
    }

    return DrawerHeader(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const EndDrawerButton(),
              IconButton(onPressed: onPressHome, icon: const Icon(Icons.home)),
              const Text('My Building'),
              IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
            ],
          ),
        ],
      ),
    );
  }
}
