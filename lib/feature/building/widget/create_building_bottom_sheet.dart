import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

class CreateBuildingBottomSheet extends StatefulWidget {
  final void Function(String name) onPressCreate;
  final void Function() onPressClose;

  const CreateBuildingBottomSheet({
    super.key,
    required this.onPressCreate,
    required this.onPressClose,
  });

  @override
  State<CreateBuildingBottomSheet> createState() =>
      _CreateBuildingBottomSheetState();
}

class _CreateBuildingBottomSheetState extends State<CreateBuildingBottomSheet> {
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
                  labelText: 'Create name as a location!',
                ),
                controller: _nameController,
              ),
            ),
            ElevatedButton(
              onPressed: () => widget.onPressCreate(name),
              child: const Text("Create"),
            )
          ],
        ),
      ),
    );
  }
}
