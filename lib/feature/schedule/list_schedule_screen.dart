import 'package:amaz_corp_mobile/core/schedule/entity/schedule_entity.dart';
import 'package:amaz_corp_mobile/core/schedule/service/schedule_service.dart';
import 'package:amaz_corp_mobile/feature/schedule/add_schedule_fab_widget.dart';
import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:amaz_corp_mobile/shared/component/skeleton.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListScheduleScreen extends ConsumerWidget {
  final String roomID;

  const ListScheduleScreen({
    super.key,
    required this.roomID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listScheduleAsync =
        ref.watch(getListScheduleByRoomIDProvider(roomID));

    Widget res = listScheduleAsync.when(
      loading: () => const Skeleton(),
      error: (err, st) => const Text("Error"),
      data: (data) => data.isEmpty
          ? const EmptySchedule()
          : ListSchedule(
              schedules: data,
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
  final List<Schedule> schedules;

  const ListSchedule({
    super.key,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: schedules
          .map(
            (sch) => Card(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(sch.name),
                    ElevatedButton(
                      child: const Text('See Tasks'),
                      onPressed: () {
                        context.goNamed(
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
            ),
          )
          .toList(),
    );
  }
}

class EmptySchedule extends StatelessWidget {
  const EmptySchedule({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Sizes.p16),
          child: Text("You don't have any schedules yet"),
        ),
      ),
    );
  }
}
