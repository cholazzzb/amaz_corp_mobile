import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTaskFAB extends StatelessWidget {
  final String scheduleID;

  const AddTaskFAB({
    super.key,
    required this.scheduleID,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
      onPressed: () {
        context.goNamed(
          ScheduleRouteName.taskAdd.name,
          pathParameters: {
            "scheduleID": scheduleID,
          },
        );
      },
    );
  }
}
