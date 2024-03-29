import 'package:amaz_corp_mobile/core/building/entity/room_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListMyRoom extends ConsumerWidget {
  final String buildingID;

  const ListMyRoom({super.key, this.buildingID = ""});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (buildingID == "") {
      return const Center(
        child: Text("No building selected"),
      );
    }

    final listRoomAsync =
        ref.watch(getListRoomsByBuildingIDProvider(buildingID));

    Widget loadingWidget() {
      return const CircularProgressIndicator();
    }

    Widget errorWidget(e, st) {
      return const Text("data");
    }

    void onTap(String roomID) {
      context.pushNamed(
        ScheduleRouteName.schedules.name,
        pathParameters: {"roomID": roomID},
      );
    }

    Widget successWidget(List<Room> data) {
      return Column(
        children: data.map(
          (room) {
            return Padding(
              padding: const EdgeInsets.all(Sizes.p12),
              child: InkWell(
                onTap: () {
                  onTap(room.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(room.name),
                    const Icon(CupertinoIcons.arrow_right_circle)
                  ],
                ),
              ),
            );
          },
        ).toList(),
      );
    }

    return listRoomAsync.when(
      loading: loadingWidget,
      error: errorWidget,
      data: successWidget,
    );
  }
}
