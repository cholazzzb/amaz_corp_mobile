import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/building_service.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListMyBuilding extends ConsumerWidget {
  final void Function(String buildingID) onSelectBuilding;

  const ListMyBuilding({super.key, required this.onSelectBuilding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myBuildingAsync = ref.watch(getMyBuildingsProvider);

    Widget loadingWidget() {
      return const CircularProgressIndicator();
    }

    Widget errorWidget(e, st) {
      return const Text('Error');
    }

    Widget successWidget((String, List<BuildingMember>) data) {
      List<BuildingMember> bms = data.$2;
      return Column(
        children: bms
            .map(
              (bm) => Container(
                color: Theme.of(context).colorScheme.primary,
                width: Sizes.p64,
                height: Sizes.p64,
                child: IconButton(
                  icon: const Icon(Icons.business_outlined),
                  color: Colors.white,
                  onPressed: () {
                    onSelectBuilding(bm.id);
                  },
                ),
              ),
            )
            .toList(),
      );
    }

    return myBuildingAsync.when(
        loading: loadingWidget, error: errorWidget, data: successWidget);
  }
}

Future<String> call() {
  return Future(() => "null");
}
