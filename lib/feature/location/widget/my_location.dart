import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/location/controller/location_controller.dart';
import 'package:amaz_corp_mobile/feature/location/widget/location_card.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyLocation extends ConsumerWidget {
  const MyLocation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.read(getMyLocationsProvider);

    Widget res = locationAsync.when(
      data: (data) {
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final item = data[index];

              Future<void> onPressed(String buildingId) async {
                final controller =
                    ref.read(locationControllerProvider.notifier);
                await controller.leaveBuilding(
                  memberId: "1",
                  buildingId: buildingId,
                  onSuccess: () {},
                );
              }

              return LocationCard(
                name: item.name,
                buildingId: item.id,
                buttonText: "Leave",
                onPressed: onPressed,
                isSelected: false,
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
