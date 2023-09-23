import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/feature/building/widget/list_member.dart';
import 'package:amaz_corp_mobile/feature/building/widget/list_room.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';
import 'package:flutter/material.dart';

enum Tab {
  room,
  member,
}

class BuildingScreen extends StatefulWidget {
  const BuildingScreen({super.key, required this.building});

  final Building building;

  @override
  State<BuildingScreen> createState() => _BuildingScreenState();
}

class _BuildingScreenState extends State<BuildingScreen> {
  Tab selectedTab = Tab.room;

  @override
  Widget build(BuildContext context) {
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
            Tab.room => ListRoom(buildingID: widget.building.id),
            Tab.member => ListMember(
                buildingID: widget.building.id,
              )
          }
        ],
      ),
    );
  }
}
