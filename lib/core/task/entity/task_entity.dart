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

  factory Task.fromJSON(Map<String, dynamic> json) => _$$TaskImplFromJson(json);
}

@freezed
class TaskStatus with _$TaskStatus {
  @JsonSerializable(explicitToJson: true)
  const factory TaskStatus({
    @JsonKey(name: "ID") required String id,
    @JsonKey(name: "name") required String name,
  }) = _TaskStatus;

  factory TaskStatus.fromJSON(Map<String, dynamic> json) =>
      _$$TaskStatusImplFromJson(json);
}

@Freezed(toJson: true)
class AddTaskReq with _$AddTaskReq {
  @JsonSerializable(explicitToJson: true)
  const factory AddTaskReq({
    @JsonKey(name: "scheduleID") required String scheduleID,
    @JsonKey(name: "startTime") required String startTime,
    @JsonKey(name: "durationDay") required int durationDay,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "ownerID") required String ownerID,
    @JsonKey(name: "assigneeID") required String assigneeID,
    @JsonKey(name: "statusID") required String statusID,
  }) = _AddTaskReq;

  factory AddTaskReq.fromJSON(Map<String, dynamic> json) =>
      _$$AddTaskReqImplFromJson(json);
}
