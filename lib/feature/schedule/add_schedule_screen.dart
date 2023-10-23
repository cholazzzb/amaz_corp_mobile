import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:amaz_corp_mobile/core/schedule/entity/schedule_entity.dart';
import 'package:amaz_corp_mobile/feature/schedule/controller/add_schedule_controller.dart';
import 'package:amaz_corp_mobile/shared/async_value_ui.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/error_bottom_sheet.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';

class AddScheduleScreen extends ConsumerStatefulWidget {
  final String roomID;

  const AddScheduleScreen({
    super.key,
    required this.roomID,
  });

  @override
  ConsumerState<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends ConsumerState<AddScheduleScreen> {
  final _scheduleNameController = TextEditingController();

  String get scheduleName => _scheduleNameController.text;

  @override
  void dispose() {
    _scheduleNameController.dispose();
    super.dispose();
  }

  Future<void> _submit(VoidCallback onSuccess) async {
    final controller = ref.read(addScheduleControllerProvider.notifier);
    await controller.addSchedule(
      scheduleReq: AddScheduleReq(
        scheduleName: scheduleName,
        roomID: widget.roomID,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      addScheduleControllerProvider,
      (prev, state) => state.showErrorBottomSheet(
        context,
        child: ErrorBottomSheet(
          errorMessage: state.error.toString(),
          onPressClose: () => Navigator.pop(context),
        ),
      ),
    );
    final state = ref.watch(addScheduleControllerProvider);

    void onSuccess() {
      context.push('/location');
    }

    return WithNavigationLayout(
      title: 'Add Schedule',
      selectedIdx: 0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Schedule Name'),
              ),
              const SizedBox(
                height: Sizes.p12,
              ),
              PrimaryButton(
                text: 'Add Schedule',
                isLoading: state.isLoading,
                onPressed: () => _submit(onSuccess),
              )
            ],
          ),
        ),
      ),
    );
  }
}