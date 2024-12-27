import 'package:amaz_corp_mobile/core/task/entity/task_entity.dart';
import 'package:amaz_corp_mobile/core/task/service/task_service.dart';
import 'package:amaz_corp_mobile/routing/schedule_router.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListTask extends ConsumerWidget {
  final String scheduleID;

  const ListTask({super.key, required this.scheduleID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(getListTaskByScheduleIDProvider(scheduleID));

    Future<void> onPressRefetch() async {
      final _ = ref.refresh(getListTaskByScheduleIDProvider(scheduleID));
    }

    Future<void> onPressDetail(String taskID) async {
      context.pushNamed(ScheduleRouteName.taskID.name, pathParameters: {
        "scheduleID": scheduleID,
        "taskID": taskID,
      });
    }

    Widget errorWidget(Object err, StackTrace st) {
      return Expanded(
        flex: 1,
        child: RefreshIndicator(
          onRefresh: onPressRefetch,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.p16,
                horizontal: Sizes.p8,
              ),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.p16),
                    child: Row(
                      children: [
                        Text("Error"),
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    }

    Widget loadingWidget() {
      return const Text("Loading");
    }

    Widget successWidget(List<Task> data) {
      if (data.isEmpty) {
        return Expanded(
          flex: 1,
          child: RefreshIndicator(
            onRefresh: onPressRefetch,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.p16,
                horizontal: Sizes.p8,
              ),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.p16),
                    child: Row(
                      children: [
                        Text("You don't have any tasks yet!"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }

      return Expanded(
        flex: 1,
        child: RefreshIndicator(
          onRefresh: onPressRefetch,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.p16,
              horizontal: Sizes.p8,
            ),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final task = data[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(task.name),
                      PrimaryButton(
                        text: 'See Detail',
                        onPressed: () => onPressDetail(task.id),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return async.when(
      error: errorWidget,
      loading: loadingWidget,
      data: successWidget,
    );
  }
}
