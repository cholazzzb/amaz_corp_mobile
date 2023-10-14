import 'package:amaz_corp_mobile/core/location/domain/entity/room_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/task/controller/task_controller.dart';
import 'package:amaz_corp_mobile/feature/task/widget/list_task.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleController = ref.watch(scheduleControllerProvider.notifier);
    String scheduleID = ref.watch(scheduleControllerProvider);
    final async = ref.watch(getListRoomProvider);

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
                onTap: () => scheduleController.getScheduleIDByRoomID(room.id),
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
      child: Center(
        child: async.when(
          data: successWidget,
          error: errorWidget,
          loading: loadingWidget,
        ),
      ),
    );
  }
}
