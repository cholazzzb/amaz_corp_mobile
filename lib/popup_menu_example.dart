import 'package:amaz_corp_mobile/core/building/entity/room_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/core/schedule/repository/remote_schedule_repo.dart';
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
    final listRoomAsync = ref.watch(getListRoomProvider);
    final remoteScheduleRepo = ref.watch(remoteScheduleRepoProvider);

    Widget errorWidget(Object err, StackTrace st) {
      return const Text('Error');
    }

    Widget loadingWidget() {
      return const Text("Loading");
    }

    Widget successWidget(List<Room> data) {
      List<PopupMenuItem<Room>> list = data
          .map((room) => PopupMenuItem<Room>(
                child: Text(room.name),
                onTap: () {
                  remoteScheduleRepo
                      .getListScheduleByRoomID(room.id)
                      .then((value) => null);
                },
              ))
          .toList()
          .cast<PopupMenuItem<Room>>();

      return Column(
        children: [
          Row(
            children: [
              const Text("Selected:"),
              PopupMenuButton<Room>(
                icon: const Icon(Icons.arrow_drop_down),
                tooltip: 'Show List Rooms',
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Room>>[
                  ...list,
                ],
              ),
            ],
          ),
          if (scheduleID.isNotEmpty) ListTask(scheduleID: scheduleID)
        ],
      );
    }

    return WithNavigationLayout(
      title: 'Tasks',
      selectedIdx: 1,
      floatingActionButton: AddTaskFAB(scheduleID: scheduleID),
      child: Center(
        child: Column(
          children: [
            listRoomAsync.when(
              data: successWidget,
              error: errorWidget,
              loading: loadingWidget,
            ),
          ],
        ),
      ),
    );
  }
}
