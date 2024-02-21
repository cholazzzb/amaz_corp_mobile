import 'package:amaz_corp_mobile/core/building/entity/member_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/task/add_task_screen.dart';
import 'package:amaz_corp_mobile/shared/component/form/select_form_field.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InviteBuildingScreen extends ConsumerStatefulWidget {
  final String buildingID;
  const InviteBuildingScreen({
    super.key,
    required this.buildingID,
  });

  @override
  ConsumerState<InviteBuildingScreen> createState() =>
      _InviteBuildingScreenState();
}

class _InviteBuildingScreenState extends ConsumerState<InviteBuildingScreen> {
  @override
  Widget build(BuildContext context) {
    Member member = emptyMember;

    final listMember =
        ref.watch(getListMemberByBuildingIDProvider(widget.buildingID));

    return WithNavigationLayout(
      title: "title",
      selectedIdx: 0,
      child: Row(
        children: [
          SelectFormField<Member>(
            loading: listMember.isLoading,
            errorMessage: listMember.error.toString(),
            title: "Select member",
            selectedValue: member,
            list: listMember.value ?? [],
            onSelect: (selectedValue) {
              setState(() {
                member = selectedValue;
              });
            },
          )
        ],
      ),
    );
  }
}
