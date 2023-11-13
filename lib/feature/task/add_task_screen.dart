import 'package:amaz_corp_mobile/app_dependencies.dart';
import 'package:amaz_corp_mobile/core/location/domain/entity/member_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:amaz_corp_mobile/core/task/entity/task_entity.dart';
import 'package:amaz_corp_mobile/feature/task/controller/add_task_controller.dart';
import 'package:amaz_corp_mobile/shared/async_value_ui.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/error_bottom_sheet.dart';
import 'package:amaz_corp_mobile/shared/component/form/date_form_field.dart';
import 'package:amaz_corp_mobile/shared/component/form/select_form_field.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:amaz_corp_mobile/shared/extension/numerical_range_formatter.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

const emptyMember = Member(
  id: '',
  userID: '',
  name: '',
  roomID: '',
  status: '',
);

class AddTaskScreen extends ConsumerStatefulWidget {
  final String scheduleID;

  const AddTaskScreen({
    super.key,
    required this.scheduleID,
  });

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _nameController = TextEditingController();
  final _durationDayController = TextEditingController();

  String get taskName => _nameController.text;
  DateTime startTime = DateTime.now();
  String get durationDay => _durationDayController.text.isNotEmpty
      ? _durationDayController.text
      : "0";
  Member ownerID = emptyMember;
  Member assigneeID = emptyMember;
  Member status = emptyMember;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit(VoidCallback onSuccess) async {
    final formatter = DateFormat('E, d MMM yyyy HH:mm:ss');
    final formatted = "${formatter.format(startTime.toUtc())} GMT";

    final req = AddTaskReq(
      scheduleID: widget.scheduleID,
      startTime: formatted,
      name: taskName,
      durationDay: int.parse(durationDay),
      ownerID: ownerID.id,
      assigneeID: assigneeID.id,
      status: status.id,
    );
    final controller = ref.read(addTaskControllerProvider.notifier);
    await controller.addTask(req: req);
  }

  Future<void> submit() async {
    _submit(() {
      // context.goNamed(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      addTaskControllerProvider,
      (prev, state) => state.showErrorBottomSheet(
        context,
        child: ErrorBottomSheet(
          errorMessage: state.error.toString(),
          onPressClose: () => Navigator.pop(context),
        ),
      ),
    );

    // requireValue is possible because appDependenciesProvider is loaded before
    // anything. See: lib/src/app.dart
    final buildingID = ref
        .watch(appDependenciesProvider)
        .requireValue
        .database
        .locationRepo
        .getSelectedBuildingID();

    final listMember = ref.watch(getListMemberByBuildingIDProvider(buildingID));

    return WithNavigationLayout(
      title: 'Add Task',
      selectedIdx: 0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Task Name'),
            ),
            const SizedBox(
              height: Sizes.p12,
            ),
            DateFormField(
              onChanged: (dateTime) {
                setState(() {
                  startTime = dateTime;
                });
              },
              currentValue: startTime,
              validator: null,
              label: 'StartTime',
            ),
            const SizedBox(
              height: Sizes.p12,
            ),
            TextFormField(
              controller: _durationDayController,
              decoration: const InputDecoration(
                labelText: 'Duration (day)',
                hintText: "Enter a number",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                NumericalRangeFormatter(min: 0, max: 14)
              ],
            ),
            const SizedBox(
              height: Sizes.p12,
            ),
            SelectFormField<Member>(
              loading: listMember.isLoading,
              errorMessage: listMember.error.toString(),
              title: "Owner",
              selectedValue: ownerID,
              list: listMember.value ?? [],
              selectValue: (value) => value.name,
              onSelect: (selectedValue) {
                setState(() {
                  ownerID = selectedValue;
                });
              },
            ),
            const SizedBox(
              height: Sizes.p12,
            ),
            SelectFormField<Member>(
              loading: listMember.isLoading,
              errorMessage: listMember.error.toString(),
              title: "Assignee",
              selectedValue: assigneeID,
              list: listMember.value ?? [],
              selectValue: (value) => value.name,
              onSelect: (selectedValue) {
                setState(() {
                  assigneeID = selectedValue;
                });
              },
            ),
            const SizedBox(
              height: Sizes.p12,
            ),
            SelectFormField<Member>(
              loading: listMember.isLoading,
              errorMessage: listMember.error.toString(),
              title: "Status",
              selectedValue: status,
              list: listMember.value ?? [],
              selectValue: (value) => value.name,
              onSelect: (selectedValue) {
                setState(() {
                  status = selectedValue;
                });
              },
            ),
            PrimaryButton(
              text: "Submit",
              onPressed: submit,
            )
          ]),
        ),
      ),
    );
  }
}
