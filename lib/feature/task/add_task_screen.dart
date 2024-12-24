import 'package:amaz_corp_mobile/app_dependencies.dart';
import 'package:amaz_corp_mobile/core/building/entity/member_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/core/task/entity/task_entity.dart';
import 'package:amaz_corp_mobile/feature/task/controller/add_task_controller.dart';
import 'package:amaz_corp_mobile/shared/async_value_ui.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/error/error_bottom_sheet_500.dart';
import 'package:amaz_corp_mobile/shared/component/emty_layout.dart';
import 'package:amaz_corp_mobile/shared/component/form/date_form_field.dart';
import 'package:amaz_corp_mobile/shared/component/form/select_form_field.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:amaz_corp_mobile/shared/date.dart';
import 'package:amaz_corp_mobile/shared/extension/numerical_range_formatter.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final formatted = dateToUTCSTring(startTime.toUtc());

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
        child: ErrorBottomSheet500(
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

    if (buildingID.isEmpty) {
      return const EmptyLayout(
        title: 'Add Task',
        message: "No building selected, please select building first",
      );
    }

    final listMember = ref.watch(getListMemberByBuildingIDProvider(buildingID));

    return WithNavigationCustomLayout(
      title: 'Add Task',
      selectedIdx: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: Column(
                  children: [
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
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.p8),
            child: PrimaryButton(
              text: "Submit",
              onPressed: submit,
            ),
          )
        ],
      ),
    );
  }
}
