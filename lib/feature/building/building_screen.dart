import 'package:amaz_corp_mobile/feature/building/widget/create_room_fab.dart';
import 'package:amaz_corp_mobile/feature/building/widget/invite_member_fab.dart';
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
  final String buildingID;

  const BuildingScreen({
    super.key,
    required this.buildingID,
  });

  @override
  ConsumerState<BuildingScreen> createState() => _BuildingScreenState();
}

class _BuildingScreenState extends ConsumerState<BuildingScreen> {
  Tab selectedTab = Tab.room;

  @override
  Widget build(BuildContext context) {
    return WithNavigationLayout(
      title: "List Room",
      selectedIdx: 0,
      floatingActionButton: switch (selectedTab) {
        Tab.room => CreateRoomFAB(
            buildingID: widget.buildingID,
          ),
        Tab.member => InviteMemberFAB(
            buildingID: widget.buildingID,
          )
      },
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
            Tab.room => ListRoom(buildingID: widget.buildingID),
            Tab.member => ListMember(
                buildingID: widget.buildingID,
              )
          }
        ],
      ),
    );
  }
}
