import 'package:amaz_corp_mobile/feature/building/widget/invite_member_bottom_sheet.dart';
import 'package:flutter/material.dart';

class InviteMemberFAB extends StatelessWidget {
  final String buildingID;
  const InviteMemberFAB({
    super.key,
    required this.buildingID,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Invite member'),
      icon: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return InviteMemberBottomSheet(
              buildingID: buildingID,
            );
          },
        );
      },
    );
  }
}
