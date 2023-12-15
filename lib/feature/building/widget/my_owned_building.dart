import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/building/controller/building_controller.dart';
import 'package:amaz_corp_mobile/feature/building/widget/create_building_bottom_sheet.dart';
import 'package:amaz_corp_mobile/routing/location_router.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyOwnedBuilding extends ConsumerWidget {
  const MyOwnedBuilding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingsRef = ref.watch(getListMyOwnedBuildingsProvider);

    Widget res = buildingsRef.when(
      data: (data) {
        if (data.isNotEmpty) {
          return ListOwnedBuilding(data: data);
        }
        return const EmptyOwnedBuilding();
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

class EmptyOwnedBuilding extends ConsumerWidget {
  const EmptyOwnedBuilding({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressClose() {
      Navigator.pop(context);
    }

    void onSuccess() {
      onPressClose();
      ref.invalidate(getListMyOwnedBuildingsProvider);
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

class ListOwnedBuilding extends StatelessWidget {
  final List<Building> data;

  const ListOwnedBuilding({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p12),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final building = data[index];

          void onPressDetail() {
            context.goNamed(LocationRouteName.buildingID.name, pathParameters: {
              "buildingID": building.id,
            });
          }

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: Sizes.p12),
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(building.name),
                  PrimaryButton(
                    text: "Detail",
                    onPressed: onPressDetail,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
