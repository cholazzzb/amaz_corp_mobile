import 'package:amaz_corp_mobile/core/schedule/entity/schedule_entity.dart';
import 'package:amaz_corp_mobile/core/schedule/repository/remote_schedule_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_service.g.dart';

class ScheduleService {
  ScheduleService(this.ref);
  final Ref ref;
}

@Riverpod(keepAlive: true)
ScheduleService scheduleService(ScheduleServiceRef ref) {
  return ScheduleService(ref);
}

@riverpod
Future<List<Schedule>> getListScheduleByRoomID(
  GetListScheduleByRoomIDRef ref,
  String roomID,
) async {
  return await ref
      .read(remoteScheduleRepoProvider)
      .getListScheduleByRoomID(roomID);
}
