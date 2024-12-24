import 'package:amaz_corp_mobile/core/building/entity/room_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListRoom extends ConsumerWidget {
  const ListRoom({super.key, required this.buildingID});

  final String buildingID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Room>> rooms =
        ref.watch(getListRoomsByBuildingIDProvider(buildingID));

    Future<void> onPressRefetch() async {
      final _ = ref.refresh(getListRoomsByBuildingIDProvider(buildingID));
    }

    Widget loadingWidget() {
      return const Center(child: CircularProgressIndicator());
    }

    Widget errorWidget(e, st) {
      return Center(
        child: Column(
          children: [
            const Text("Failed to get list rooms"),
            ElevatedButton(
              onPressed: onPressRefetch,
              child: const Text("Retry"),
            )
          ],
        ),
      );
    }

    Widget successWidget(List<Room> data) {
      return Expanded(
        flex: 1,
        child: RefreshIndicator(
          onRefresh: onPressRefetch,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final item = data[index];
              return RoomCard(item: item);
            },
          ),
        ),
      );
    }

    return rooms.when(
      data: successWidget,
      error: errorWidget,
      loading: loadingWidget,
    );
  }
}

class RoomCard extends StatelessWidget {
  const RoomCard({
    super.key,
    required this.item,
  });

  final Room item;

  @override
  Widget build(BuildContext context) {
    Future<void> onPress() async {
      context.pushNamed(ScheduleRouteName.schedules.name, pathParameters: {
        "roomID": item.id,
        "roomName": item.name,
      });
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.name),
            PrimaryButton(
              text: 'Schedule',
              onPressed: onPress,
            )
          ],
        ),
      ),
    );
  }
}
