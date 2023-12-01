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
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(Sizes.p32),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Create name as a building member!',
                ),
                controller: _nameController,
              ),
            ),
            ElevatedButton(
              onPressed: () => widget.onPressJoin(name),
              child: const Text("Join"),
            )
          ],
        ),
      ),
    );
  }
}
