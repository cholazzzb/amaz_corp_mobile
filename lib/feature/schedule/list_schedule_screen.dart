import 'package:amaz_corp_mobile/core/schedule/entity/schedule_entity.dart';
import 'package:amaz_corp_mobile/core/schedule/service/schedule_service.dart';
import 'package:amaz_corp_mobile/feature/schedule/add_schedule_fab_widget.dart';
import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:amaz_corp_mobile/shared/component/empty.dart';
import 'package:amaz_corp_mobile/shared/component/skeleton.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListScheduleScreen extends ConsumerWidget {
  final String roomID;
  final String roomName;

  const ListScheduleScreen({
    super.key,
    required this.roomID,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listScheduleAsync =
        ref.watch(getListScheduleByRoomIDProvider(roomID));

    Future<void> onRefresh() async {
      final _ = ref.refresh(getListScheduleByRoomIDProvider(roomID));
    }

    Widget res = listScheduleAsync.when(
      loading: () => const Skeleton(),
      error: (err, st) =>
          EmptyLayout(title: "Room $roomName", message: "Error load schedules"),
      data: (data) => data.isEmpty
          ? EmptySchedule(roomName: roomName)
          : Row(
              children: [
                ListSchedule(
                  roomName: roomName,
                  schedules: data,
                  onRefresh: onRefresh,
                ),
              ],
            ),
    );

    return WithNavigationLayout(
      title: "List Schedule",
      selectedIdx: 0,
      floatingActionButton: AddScheduleFAB(
        roomID: roomID,
      ),
      child: res,
    );
  }
}

class ListSchedule extends StatelessWidget {
  final String roomName;
  final List<Schedule> schedules;
  final Future<void> Function() onRefresh;

  const ListSchedule({
    super.key,
    required this.roomName,
    required this.schedules,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Room: $roomName")],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: schedules.length,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
              itemBuilder: (BuildContext context, int index) {
                final sch = schedules[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.p16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(sch.name),
                        ElevatedButton(
                          child: const Text('See Tasks'),
                          onPressed: () {
                            context.pushNamed(
                              ScheduleRouteName.scheduleID.name,
                              pathParameters: {
                                'scheduleID': sch.id,
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EmptySchedule extends StatelessWidget {
  final String roomName;

  const EmptySchedule({
    super.key,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Room $roomName"),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(Sizes.p16),
              child: Text("You don't have any schedules yet"),
            ),
          ),
        ],
      ),
    );
  }
}
