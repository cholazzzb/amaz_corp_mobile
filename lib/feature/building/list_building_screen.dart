import 'package:amaz_corp_mobile/feature/building/widget/invited_building.dart';
import 'package:amaz_corp_mobile/feature/building/widget/joined_building.dart';
import 'package:amaz_corp_mobile/feature/building/widget/my_owned_building.dart';
import 'package:amaz_corp_mobile/feature/building/widget/public_building.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';
import 'package:flutter/material.dart';

class ListBuildingScreen extends StatefulWidget {
  const ListBuildingScreen({super.key});

  @override
  State<ListBuildingScreen> createState() => _ListBuildingScreenState();
}

enum LocationType {
  joined,
  invited,
  public,
  mine,
}

class _ListBuildingScreenState extends State<ListBuildingScreen> {
  LocationType selected = LocationType.joined;

  @override
  Widget build(BuildContext context) {
    return WithNavigationLayout(
      title: 'List Building',
      selectedIdx: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Sizes.p12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton<LocationType>(
                  segments: const <ButtonSegment<LocationType>>[
                    ButtonSegment<LocationType>(
                      value: LocationType.joined,
                      label: Text('Joined'),
                      icon: Icon(Icons.badge),
                    ),
                    ButtonSegment<LocationType>(
                      value: LocationType.invited,
                      label: Text('Invited'),
                      icon: Icon(Icons.mail_outline_rounded),
                    ),
                    ButtonSegment<LocationType>(
                      value: LocationType.mine,
                      label: Text('Owned'),
                      icon: Icon(Icons.location_city),
                    ),
                  ],
                  selected: <LocationType>{selected},
                  onSelectionChanged: (Set<LocationType> newSelection) {
                    setState(() {
                      selected = newSelection.first;
                    });
                  },
                ),
              ],
            ),
          ),
          switch (selected) {
            LocationType.joined => const JoinedBuilding(), // TODO
            LocationType.invited => const InvitedBuilding(),
            LocationType.mine => const MyOwnedBuilding(),
            LocationType.public => const PublicBuilding(),
          },
        ],
      ),
    );
  }
}
