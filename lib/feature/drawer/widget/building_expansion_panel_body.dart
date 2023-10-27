import 'package:amaz_corp_mobile/feature/drawer/building_drawer_controller.dart';
import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:amaz_corp_mobile/shared/component/skeleton.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BuildingExpansionPanelBody extends ConsumerWidget {
  const BuildingExpansionPanelBody({
    super.key,
    required this.buildingID,
  });

  final String buildingID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(buildingDrawerControllerProvider);
    if (!controller.containsKey(buildingID)) {
      return const Column();
    }
    final buildingAsync = controller[buildingID];

    List<Widget> children = switch (buildingAsync!.$1) {
      AsyncState.loading => List.filled(
          3,
          const Skeleton(
            width: 500,
            height: 20,
          ),
        ),
      AsyncState.success => buildingAsync.$2
          .map(
            (room) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.p12,
                    horizontal: Sizes.p24,
                  ),
                  child: Text(room.name),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: Sizes.p24),
                  child: ElevatedButton(
                    onPressed: () {
                      context.goNamed(
                        ScheduleRouteName.schedules.name,
                        pathParameters: {'roomID': room.id},
                      );
                    },
                    child: const Text('See'),
                  ),
                )
              ],
            ),
          )
          .toList(),
      AsyncState.error => []
    };

    return Column(
      children: children,
    );
  }
}
