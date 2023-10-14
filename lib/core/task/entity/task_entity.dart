import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_entity.freezed.dart';
part 'task_entity.g.dart';

@freezed
class Task with _$Task {
  @JsonSerializable(explicitToJson: true)
  const factory Task({
    @JsonKey(name: "ID") required String id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "startTime") required String startTime,
    @JsonKey(name: "durationDay") required int durationDay,
    @JsonKey(name: "scheduleID") required String scheduleID,
    @JsonKey(name: "endTime") required String endTime,
    @JsonKey(name: "taskDetailID") required String taskDetailID,
  }) = _Task;

  factory Task.fromJSON(Map<String, dynamic> json) => _$$_TaskFromJson(json);
}
