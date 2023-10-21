import 'package:amaz_corp_mobile/feature/schedule/add_schedule_fab_widget.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:amaz_corp_mobile/core/schedule/service/schedule_service.dart';
import 'package:amaz_corp_mobile/shared/component/skeleton.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';

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
          : Column(
              children: data
                  .map(
                    (sch) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Sizes.p16),
                        child: Row(
                          children: [
                            Text(sch.name),
                            // Text(sch.id),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );

    return WithNavigationLayout(
      title: "List Schedule",
      selectedIdx: 0,
      floatingActionButton: const AddScheduleFAB(),
      child: res,
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
