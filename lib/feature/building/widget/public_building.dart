import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/building/widget/building_card.dart';
import 'package:amaz_corp_mobile/shared/component/skeleton.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class PublicBuilding extends ConsumerStatefulWidget {
  const PublicBuilding({super.key});

  @override
  ConsumerState<PublicBuilding> createState() => _PublicBuildingState();
}

class _PublicBuildingState extends ConsumerState<PublicBuilding> {
  String currentBuildingId = "0";

  // void _onPressClose() {
  //   Navigator.pop(context);
  // }

  // Future<void> _onPressJoin(String name, Building building) async {
  //   final controller = ref.read(renameMemberControllerProvider.notifier);
  //   await controller.renameMember(
  //     name: name,
  //     buildingID: building.id,
  //     onSuccess: () {
  //       context.goNamed(
  //         LocationRouteName.buildingID.name,
  //         pathParameters: {"buildingID": building.id},
  //       );
  //     },
  //   );
  // }

  Widget successWidget(List<Building> data) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final building = data[index];

          Future<void> onPressed(String buildingID) async {
            // showModalBottomSheet<void>(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return JoinBuildingBottomSheet(
            //       onPressJoin: (name) => _onPressJoin(name, building),
            //       onPressClose: _onPressClose,
            //     );
            //   },
            // );
          }

          return BuildingCard(
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
              'Loading',
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
