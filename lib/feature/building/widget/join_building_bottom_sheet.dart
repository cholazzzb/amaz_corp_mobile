import 'package:amaz_corp_mobile/shared/component/bottom_sheet/bottom_sheet_header.dart';
import 'package:amaz_corp_mobile/shared/component/button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

class JoinBuildingBottomSheet extends StatefulWidget {
  const JoinBuildingBottomSheet({
    super.key,
    required this.onPressJoin,
    required this.onPressClose,
  });

  final void Function(String name) onPressJoin;
  final void Function() onPressClose;

  @override
  State<JoinBuildingBottomSheet> createState() =>
      _JoinBuildingBottomSheetState();
}

class _JoinBuildingBottomSheetState extends State<JoinBuildingBottomSheet> {
  final _nameController = TextEditingController();

  String get name => _nameController.text;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Sizes.p24),
            topRight: Radius.circular(Sizes.p24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BottomSheetHeader(
              title: "Join",
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.p32),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Create name as a building member!',
                ),
                controller: _nameController,
              ),
            ),
            Button(
              onPressed: () {
                widget.onPressJoin(name);
                Navigator.pop(context);
              },
              text: "Join",
            )
          ],
        ),
      ),
    );
  }
}
