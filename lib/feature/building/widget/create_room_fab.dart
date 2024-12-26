import 'package:amaz_corp_mobile/feature/building/widget/create_room_bottom_sheet.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';

class CreateRoomFAB extends StatelessWidget {
  final String buildingID;

  const CreateRoomFAB({
    super.key,
    required this.buildingID,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text("Add Room"),
      icon: const Icon(Icons.add),
      onPressed: () {
        showAmzBottomSheet(context, (BuildContext context) {
          return CreateRoomBottomSheet(
            buildingID: buildingID,
          );
        });
      },
    );
  }
}
