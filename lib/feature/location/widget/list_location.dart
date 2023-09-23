import 'package:amaz_corp_mobile/feature/location/widget/my_location.dart';
import 'package:amaz_corp_mobile/feature/location/widget/public_location.dart';
import 'package:amaz_corp_mobile/shared/layout.dart';
import 'package:flutter/material.dart';

class ListLocation extends StatefulWidget {
  const ListLocation({super.key});

  @override
  State<ListLocation> createState() => _ListLocationState();
}

enum LocationType {
  public,
  mine,
}

class _ListLocationState extends State<ListLocation> {
  LocationType selected = LocationType.public;

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: 'List Location',
      selectedIdx: 2,
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
            LocationType.public => const PublicLocation(),
            LocationType.mine => const MyLocation(),
          },
        ],
      ),
    );
  }
}
