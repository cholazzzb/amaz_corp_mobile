import 'package:amaz_corp_mobile/core/user/entity/user_entity.dart';
import 'package:amaz_corp_mobile/feature/building/controller/member_controller.dart';
import 'package:amaz_corp_mobile/feature/building/widget/invite_member_search_bottom_sheet.dart';
import 'package:amaz_corp_mobile/shared/async_value_ui.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/bottom_sheet.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/bottom_sheet_header.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/error/error_bottom_sheet_500.dart';
import 'package:amaz_corp_mobile/shared/component/button.dart';
import 'package:amaz_corp_mobile/shared/component/form/select_form_field_custom.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  UserQuery selectedMember = const UserQuery(
    id: "",
    username: "",
  );

  void onSelectMember(UserQuery selected) {
    setState(() {
      selectedMember = selected;
    });
  }

  Future<void> _submit(VoidCallback onSuccess) async {
    final controller = ref.read(inviteMemberControllerProvider.notifier);
    await controller.inviteMember(
      userID: selectedMember.id,
      buildingID: widget.buildingID,
      onSuccess: onSuccess,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      inviteMemberControllerProvider,
      (prev, state) => state.showErrorBottomSheet(
        context,
        child: ErrorBottomSheet500(
          onPressClose: () => Navigator.pop(context),
        ),
      ),
    );

    final state = ref.watch(inviteMemberControllerProvider);

    void onSuccess() {
      Navigator.pop(context);

      final snackBar = SnackBar(
        backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
        content: const Text("Success Invite Member"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetHeader(title: "Invite member"),
            SelectFormFieldCustom(
              title: 'Member',
              selectedValue: selectedMember.username,
              onPressOpen: () {
                showAmzBottomSheet(
                  context: context,
                  builder: (context) => InviteMemberSearchBottomSheet(
                    title: "Member",
                    onSelect: onSelectMember,
                  ),
                );
              },
            ),
            const SizedBox(
              height: Sizes.p64,
            ),
            const SizedBox(
              height: Sizes.p64,
            ),
            Button(
              onPressed: () {
                _submit(onSuccess);
              },
              text: "Invite",
              isLoading: state.isLoading,
            )
          ],
        ),
      ),
    );
  }
}
