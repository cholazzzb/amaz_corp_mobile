import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/location/controller/location_controller.dart';
import 'package:amaz_corp_mobile/feature/location/widget/my_location_card.dart';
import 'package:amaz_corp_mobile/routing/app_router.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyLocation extends ConsumerWidget {
  const MyLocation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(getMyLocationsProvider);

    Widget res = locationAsync.when(
      data: (data) {
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final building = data[index];

              void onPressDetail() {
                context.goNamed(
                  AppRoute.roomID.name,
                  extra: Building(
                    id: building.id,
                    name: building.name,
                  ),
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

              return MyLocationCard(
                locationName: building.name,
                onPressDetail: onPressDetail,
                onPressLeave: onPressedLeave,
              );
            },
          ),
        );
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
