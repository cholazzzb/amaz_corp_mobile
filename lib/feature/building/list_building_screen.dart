import 'package:amaz_corp_mobile/feature/building/widget/my_building.dart';
import 'package:amaz_corp_mobile/feature/building/widget/public_building.dart';
import 'package:amaz_corp_mobile/shared/layout/plain.dart';
import 'package:flutter/material.dart';

class ListBuildingScreen extends StatefulWidget {
  const ListBuildingScreen({super.key});

  @override
  State<ListBuildingScreen> createState() => _ListBuildingScreenState();
}

enum LocationType {
  public,
  mine,
}

class _ListBuildingScreenState extends State<ListBuildingScreen> {
  LocationType selected = LocationType.public;

  @override
  Widget build(BuildContext context) {
    return PlainLayout(
      title: 'List Building',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SegmentedButton<LocationType>(
                segments: const <ButtonSegment<LocationType>>[
                  ButtonSegment<LocationType>(
                    value: LocationType.public,
                    label: Text('Public'),
                    icon: Icon(Icons.location_searching),
                  ),
                  ButtonSegment<LocationType>(
                    value: LocationType.mine,
                    label: Text('Yours'),
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
          switch (selected) {
            LocationType.public => const PublicBuilding(),
            LocationType.mine => const MyBuilding(),
          },
        ],
      ),
    );
  }
}
