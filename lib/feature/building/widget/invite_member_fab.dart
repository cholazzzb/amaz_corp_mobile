import 'package:amaz_corp_mobile/core/building/entity/member_entity.dart';
import 'package:amaz_corp_mobile/feature/building/controller/member_controller.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/bottom_sheet_header.dart';
import 'package:amaz_corp_mobile/shared/component/form/select_form_field.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class InviteMemberBottomSheet extends ConsumerStatefulWidget {
  final String buildingID;

  const InviteMemberBottomSheet({
    super.key,
    required this.buildingID,
  });

  @override
  ConsumerState<InviteMemberBottomSheet> createState() =>
      _InviteMemberBottomSheetState();
}

class _InviteMemberBottomSheetState
    extends ConsumerState<InviteMemberBottomSheet> {
  String name = "";
  Member selectedMember = const Member(
    id: "",
    userID: "",
    name: "",
    roomID: "",
    status: "",
  );

  List<Member> members = [];

  void onSearch(String text) {
    final controller = ref.read(getListMemberByNameControllerProvider.notifier);
    controller.getListMember(name: text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getListMemberByNameControllerProvider);

    void onSelect(value) {
      setState(() {
        name = value;
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(Sizes.p8),
          child: BottomSheetHeader(title: "Invite member"),
        ),
        Padding(
          padding: const EdgeInsets.all(Sizes.p8),
          child: SelectFormField<Member>(
            loading: state.isLoading,
            errorMessage: state.error.toString(),
            title: 'Member',
            selectedValue: selectedMember,
            list: state.hasValue ? state.value! : [],
            onSelect: onSelect,
            onSearch: onSearch,
          ),
        ),
        const SizedBox(
          height: Sizes.p64,
        ),
        const SizedBox(
          height: Sizes.p64,
        ),
        const SizedBox(
          height: Sizes.p64,
        ),
      ],
    );
  }
}
