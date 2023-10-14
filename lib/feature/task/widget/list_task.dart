import 'package:amaz_corp_mobile/core/task/entity/task_entity.dart';
import 'package:amaz_corp_mobile/core/task/service/task_service.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListTask extends ConsumerWidget {
  const ListTask({super.key, required this.scheduleID});

  final String scheduleID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(getListTaskByScheduleIDProvider(scheduleID));

    Future<void> onPressRefetch() async {
      final _ = ref.refresh(getListTaskByScheduleIDProvider(scheduleID));
    }

    Widget errorWidget(Object err, StackTrace st) {
      return const Text("Error");
    }

    Widget loadingWidget() {
      return const Text("Loading");
    }

    Widget successWidget(List<Task> data) {
      return Expanded(
        flex: 1,
        child: RefreshIndicator(
          onRefresh: onPressRefetch,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final item = data[index];
              return Text(item.name);
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
