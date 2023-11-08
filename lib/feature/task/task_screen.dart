import 'package:amaz_corp_mobile/feature/task/add_task_fab_widget.dart';
import 'package:amaz_corp_mobile/feature/task/widget/list_task.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskScreen extends ConsumerWidget {
  final String scheduleID;

  const TaskScreen({super.key, required this.scheduleID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WithNavigationLayout(
      title: 'Tasks',
      selectedIdx: 1,
      floatingActionButton: AddTaskFAB(scheduleID: scheduleID),
      child: Center(
        child: Column(
          children: [ListTask(scheduleID: scheduleID)],
        ),
      ),
    );
  }
}
