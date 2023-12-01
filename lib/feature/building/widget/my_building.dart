import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/building/controller/building_controller.dart';
import 'package:amaz_corp_mobile/feature/building/widget/create_building_bottom_sheet.dart';
import 'package:amaz_corp_mobile/feature/building/widget/my_building_card.dart';
import 'package:amaz_corp_mobile/routing/location_router.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyBuilding extends ConsumerWidget {
  const MyBuilding({super.key});

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
    void onPressClose() {
      Navigator.pop(context);
    }

    void onSuccess() {
      onPressClose();
      ref.invalidate(getMyLocationsProvider);
    }

    Future<void> onPressCreate(String name) async {
      final req = AddBuildingReq(name: name);

      final controller = ref.read(addLocationControllerProvider.notifier);
      await controller.addBuilding(req: req, onSuccess: onSuccess);
    }

    Future<void> onPressOpenBottomSheet() async {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return CreateBuildingBottomSheet(
            onPressCreate: onPressCreate,
            onPressClose: onPressClose,
          );
        },
      );
    }

    return Column(
      children: [
        const SizedBox(height: Sizes.p12),
        const Text("You don't have any buildings. Let's create one!"),
        const SizedBox(height: Sizes.p12),
        PrimaryButton(
          text: "Create Building",
          onPressed: onPressOpenBottomSheet,
        )
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
              LocationRouteName.roomID.name,
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

          return MyBuildingCard(
            locationName: building.name,
            onPressDetail: onPressDetail,
            onPressLeave: onPressedLeave,
          );
        },
      ),
    );
  }
}
