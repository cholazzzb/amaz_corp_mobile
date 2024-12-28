import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:amaz_corp_mobile/core/schedule/entity/schedule_entity.dart';
import 'package:amaz_corp_mobile/core/schedule/service/schedule_service.dart';

part 'add_schedule_controller.g.dart';

@riverpod
class AddScheduleController extends _$AddScheduleController {
  @override
  FutureOr<void> build() {}

  Future<void> addSchedule({
    required AddScheduleReq scheduleReq,
    VoidCallback? onSuccess,
  }) async {
    state = const AsyncValue.loading();

    try {
      await _addSchedule(scheduleReq);
      state = const AsyncValue.data(null);
      onSuccess?.call();
    } catch (err, st) {
      state = AsyncValue.error(err, st);
    }
  }

  Future<void> _addSchedule(AddScheduleReq req) async {
    final svc = ref.read(scheduleServiceProvider);
    await svc.addSchedule(req);
  }
}
