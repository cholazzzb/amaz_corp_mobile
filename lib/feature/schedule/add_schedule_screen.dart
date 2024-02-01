import 'package:amaz_corp_mobile/core/schedule/entity/schedule_entity.dart';
import 'package:amaz_corp_mobile/feature/schedule/controller/add_schedule_controller.dart';
import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:amaz_corp_mobile/shared/async_value_ui.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/error/error_bottom_sheet_500.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      onSuccess: onSuccess,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      addScheduleControllerProvider,
      (prev, state) => state.showErrorBottomSheet(
        context,
        child: ErrorBottomSheet500(
          onPressClose: () => Navigator.pop(context),
        ),
      ),
    );
    final state = ref.watch(addScheduleControllerProvider);

    void onSuccess() {
      context.goNamed(
        ScheduleRouteName.schedules.name,
        pathParameters: {
          "roomID": widget.roomID,
        },
      );
    }

    return WithNavigationCustomLayout(
      title: 'Add Schedule',
      selectedIdx: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            //https://stackoverflow.com/questions/54027270/how-to-create-a-scroll-view-with-fixed-footer-with-flutter
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Schedule Name',
                      ),
                      controller: _scheduleNameController,
                    ),
                    const SizedBox(
                      height: Sizes.p12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.p8),
            child: PrimaryButton(
              text: 'Add Schedule',
              isLoading: state.isLoading,
              onPressed: () => _submit(onSuccess),
            ),
          ),
        ],
      ),
    );
  }
}
