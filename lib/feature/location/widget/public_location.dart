import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/location/controller/location_controller.dart';
import 'package:amaz_corp_mobile/feature/location/widget/location_card.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PublicLocation extends ConsumerStatefulWidget {
  const PublicLocation({super.key});

  @override
  ConsumerState<PublicLocation> createState() => _PublicLocationState();
}

class _PublicLocationState extends ConsumerState<PublicLocation> {
  String currentBuildingId = "0";

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(getAllLocationsProvider);
    Widget res = locationAsync.when(
      data: (data) {
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              Future<void> onPressed(String buildingId) async {
                final controller =
                    ref.read(locationControllerProvider.notifier);
                await controller.joinBuilding(
                  memberId: "1",
                  buildingId: buildingId,
                  onSuccess: () {
                    setState(() {
                      currentBuildingId = buildingId;
                    });
                  },
                );
              }

              return LocationCard(
                name: item.name,
                buildingId: item.id,
                isSelected: item.id == currentBuildingId,
                buttonText: "Join",
                onPressed: onPressed,
              );
            },
          ),
        );
      },
      error: (e, st) {
        return Center(
          child: Text(
            e.toString(),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    return res;
  }
}
