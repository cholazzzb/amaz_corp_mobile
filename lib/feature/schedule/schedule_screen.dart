import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/shared/layout/with_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({
    super.key,
    required this.scheduleID,
  });

  final String? scheduleID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUserRepo = ref.watch(localUserRepoProvider);
    return const WithNavigationLayout(
      title: "Schedules",
      selectedIdx: 0,
      child: Text('Schedules'),
    );
  }
}
