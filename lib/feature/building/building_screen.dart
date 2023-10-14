import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/service/building_service.dart';
import 'package:amaz_corp_mobile/feature/building/widget/list_member.dart';
import 'package:amaz_corp_mobile/feature/building/widget/list_room.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Tab {
  room,
  member,
}

class BuildingScreen extends ConsumerStatefulWidget {
  const BuildingScreen({super.key});

  @override
  ConsumerState<BuildingScreen> createState() => _BuildingScreenState();
}

class _BuildingScreenState extends ConsumerState<BuildingScreen> {
  Tab selectedTab = Tab.room;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(getMyBuildingsProvider);

    Widget loadingWidget() {
      return const Text("Loading");
    }

    Widget errorWidget(Object err, StackTrace st) {
      return const Text("error");
    }

    Widget successWidget(
      (
        String activeBuildingID,
        List<BuildingMember> buildings,
      ) data,
    ) {
      return WithNavigationLayout(
        title: "List Room",
        selectedIdx: 0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton<Tab>(
                  segments: const <ButtonSegment<Tab>>[
                    ButtonSegment<Tab>(
                      value: Tab.room,
                      label: Text('Rooms'),
                      icon: Icon(Icons.door_back_door),
                    ),
                    ButtonSegment<Tab>(
                      value: Tab.member,
                      label: Text('Members'),
                      icon: Icon(Icons.people),
                    )
                  ],
                  selected: <Tab>{selectedTab},
                  onSelectionChanged: (Set<Tab> newSelection) {
                    setState(() {
                      selectedTab = newSelection.first;
                    });
                  },
                )
              ],
            ),
            switch (selectedTab) {
              Tab.room => ListRoom(buildingID: data.$1),
              Tab.member => ListMember(
                  buildingID: data.$1,
                )
            }
          ],
        ),
      );
    }

    return async.when(
      data: successWidget,
      error: errorWidget,
      loading: loadingWidget,
    );
  }
}
