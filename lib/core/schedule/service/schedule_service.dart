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
