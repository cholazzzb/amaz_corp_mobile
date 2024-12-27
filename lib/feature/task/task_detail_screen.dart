import 'package:amaz_corp_mobile/core/task/entity/task_entity.dart';
import 'package:amaz_corp_mobile/core/task/service/task_service.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:amaz_corp_mobile/shared/date.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mix/mix.dart';

class TaskDetailScreen extends ConsumerWidget {
  final String scheduleID;
  final String taskID;

  const TaskDetailScreen({
    super.key,
    required this.scheduleID,
    required this.taskID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTaskDetail = ref.watch(getTaskDetailProvider(taskID));

    Future<void> onPressRefetch() async {
      final _ = ref.refresh(getTaskDetailProvider(taskID));
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Error"),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    Widget loadingWidget() {
      return const CircularProgressIndicator();
    }

    Widget successWidget(TaskDetail td) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            VBox(
              style:
                  Style($box.width(150), $box.alignment(Alignment.centerLeft)),
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Task name"), Text(": ")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Owner"), Text(": ")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Assignee"), Text(": ")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Start time"), Text(": ")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("End Time"), Text(": ")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Status"), Text(": ")],
                ),
              ],
            ),
            VBox(
              style: Style(
                $box.width(200),
                $box.alignment(Alignment.centerLeft),
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(td.name),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(td.ownerName.isEmpty ? "-" : td.ownerName),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(td.assigneeName.isEmpty ? "-" : td.assigneeName),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      dateToDM3Y4(
                        DateTime.parse(
                          td.startTime.replaceFirst(" +0000 +0000", " +0000"),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      dateToDM3Y4(
                        DateTime.parse(
                          td.endTime.replaceFirst(" +0000 +0000", " +0000"),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(td.status.isEmpty ? '-' : td.status),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    return WithNavigationCustomLayout(
      title: 'Task Detail',
      selectedIdx: 1,
      child: Center(
        child: asyncTaskDetail.when(
          error: errorWidget,
          loading: loadingWidget,
          data: successWidget,
        ),
      ),
    );
  }
}
