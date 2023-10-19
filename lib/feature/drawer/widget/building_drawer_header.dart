import 'package:flutter/material.dart';

class BuildingDrawerHeader extends StatelessWidget {
  const BuildingDrawerHeader({
    super.key,
    required this.logout,
  });

  final VoidCallback logout;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const EndDrawerButton(),
              const Text('My Building'),
              IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
            ],
          ),
        ],
      ),
    );
  }
}
