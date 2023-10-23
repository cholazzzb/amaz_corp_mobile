import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:amaz_corp_mobile/routing/app_router.dart';

class AddScheduleFAB extends StatelessWidget {
  final String roomID;

  const AddScheduleFAB({
    super.key,
    required this.roomID,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
      onPressed: () {
        context.goNamed(
          RoomRoute.scheduleAdd.name,
          extra: roomID,
        );
      },
    );
  }
}
