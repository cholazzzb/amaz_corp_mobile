import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/location/controller/location_controller.dart';
import 'package:amaz_corp_mobile/feature/location/widget/join_building_bottom_sheet.dart';
import 'package:amaz_corp_mobile/feature/location/widget/location_card.dart';
import 'package:amaz_corp_mobile/routing/app_router.dart';
import 'package:amaz_corp_mobile/shared/component/skeleton.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class PublicLocation extends ConsumerStatefulWidget {
  const PublicLocation({super.key});

  @override
  ConsumerState<PublicLocation> createState() => _PublicLocationState();
}

class _PublicLocationState extends ConsumerState<PublicLocation> {
  String currentBuildingId = "0";

  void _onPressClose() {
    Navigator.pop(context);
  }

  Future<void> _onPressJoin(String name, Building building) async {
    final controller = ref.read(locationControllerProvider.notifier);
    await controller.joinBuilding(
      name: name,
      buildingID: building.id,
      onSuccess: () {
        setState(() {
          currentBuildingId = building.id;
        });
        context.goNamed(AppRoute.roomID.name, extra: building);
      },
    );
  }

  Widget successWidget(List<Building> data) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final building = data[index];

          Future<void> onPressed(String buildingID) async {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return JoinBuildingBottomSheet(
                  onPressJoin: (name) => _onPressJoin(name, building),
                  onPressClose: _onPressClose,
                );
              },
            );
          }

          return LocationCard(
            name: building.name,
            buildingId: building.id,
            isSelected: building.id == currentBuildingId,
            buttonText: "Join",
            onPressed: onPressed,
          );
        },
      ),
    );
  }

  Widget errorWidget(Object err, StackTrace st) {
    return Center(
      child: Center(
        child: SizedBox(
          width: 200.0,
          height: 100.0,
          child: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: const Text(
              'Shimmer',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(Sizes.p8),
        child: Skeleton(
          width: 1000,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(getAllLocationsProvider);
    Widget res = locationAsync.when(
      data: successWidget,
      error: errorWidget,
      loading: loadingWidget,
    );

    return res;
  }
}
