import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/building/controller/building_controller.dart';
import 'package:amaz_corp_mobile/shared/async_value_ui.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/bottom_sheet_header.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/error/error_bottom_sheet_500.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateRoomBottomSheet extends ConsumerStatefulWidget {
  final String buildingID;

  const CreateRoomBottomSheet({
    super.key,
    required this.buildingID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateRoomBottomSheetState();
}

class _CreateRoomBottomSheetState extends ConsumerState<CreateRoomBottomSheet> {
  final _roomNameController = TextEditingController();

  String get roomName => _roomNameController.text;

  @override
  void dispose() {
    _roomNameController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      createRoomControllerProvider,
      (prev, state) => state.showErrorBottomSheet(
        context,
        child: ErrorBottomSheet500(
          onPressClose: () => Navigator.pop(context),
        ),
      ),
    );

    Future<void> onCreateRoom() async {
      final createRoomController =
          ref.read(createRoomControllerProvider.notifier);
      await createRoomController.createRoom(
        roomName: roomName,
        buildingID: widget.buildingID,
        onSuccess: () {
          final _ =
              ref.refresh(getListRoomsByBuildingIDProvider(widget.buildingID));

          Navigator.pop(context);
          final snackBar = SnackBar(
            backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
            content: const Text("Success Create Room"),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      );
    }

    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 0.75,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Sizes.p24),
                  topRight: Radius.circular(Sizes.p24),
                ),
              ),
              child: Column(
                children: [
                  const BottomSheetHeader(title: "Create Room"),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(Sizes.p8),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Room name"),
                            controller: _roomNameController,
                          )
                        ],
                      ),
                    ),
                  ),
                  PrimaryButton(
                    text: "Create!",
                    onPressed: () {
                      onCreateRoom();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
