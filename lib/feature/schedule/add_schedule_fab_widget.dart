import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          ScheduleRouteName.scheduleAdd.name,
          pathParameters: {
            "roomID": roomID,
          },
        );
      },
    );
  }
}
