import 'package:amaz_corp_mobile/core/schedule/repository/remote_schedule_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_controller.g.dart';

@riverpod
class ScheduleController extends _$ScheduleController {
  @override
  String build() => "";

  Future<void> getScheduleIDByRoomID(String roomID) async {
    final schs = await ref
        .watch(remoteScheduleRepoProvider)
        .getScheduleIDByRoomID(roomID);

    if (schs.isNotEmpty) {
      state = schs[0].id;
    }
  }
}
