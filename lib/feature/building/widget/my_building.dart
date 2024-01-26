import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/building/controller/building_controller.dart';
import 'package:amaz_corp_mobile/feature/building/widget/my_building_card.dart';
import 'package:amaz_corp_mobile/routing/location_router.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JoinedBuilding extends ConsumerWidget {
  const JoinedBuilding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(getMyLocationsProvider);

    Widget res = locationAsync.when(
      data: (data) {
        if (data.isNotEmpty) {
          return ListLocation(data: data);
        }
        return const EmptyLocation();
      },
      error: (e, st) {
        return Center(
          child: Text(e.toString()),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    return res;
  }
}

class EmptyLocation extends ConsumerWidget {
  const EmptyLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        Text("You don't joined any buildings"),
      ],
    );
  }
}

class ListLocation extends ConsumerWidget {
  final List<BuildingMember> data;

  const ListLocation({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final building = data[index];

          void onPressDetail() {
            context.goNamed(
              LocationRouteName.buildingID.name,
              pathParameters: {"buildingID": building.id},
            );
          }

          Future<void> onPressedLeave() async {
            final controller =
                ref.read(leaveBuildingControllerProvider.notifier);
            await controller.leaveBuilding(
              memberId: building.memberID,
              buildingId: building.id,
              onSuccess: () {
                final _ = ref.refresh(getMyLocationsProvider);
              },
            );
          }

          return JoinedBuildingCard(
            locationName: building.name,
            onPressDetail: onPressDetail,
            onPressLeave: onPressedLeave,
          );
        },
      ),
    );
  }
}
