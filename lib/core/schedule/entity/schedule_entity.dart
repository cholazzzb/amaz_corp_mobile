import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_entity.freezed.dart';
part 'schedule_entity.g.dart';

@freezed
class Schedule with _$Schedule {
  @JsonSerializable(explicitToJson: true)
  const factory Schedule({
    @JsonKey(name: 'ID') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: "roomID") required String roomID,
  }) = _Schedule;

  factory Schedule.fromJSON(Map<String, dynamic> json) =>
      _$$ScheduleImplFromJson(json);
}

@Freezed(toJson: true)
class AddScheduleReq with _$AddScheduleReq {
  @JsonSerializable(explicitToJson: true)
  const factory AddScheduleReq({
    @JsonKey(name: 'name') required String scheduleName,
    @JsonKey(name: 'roomID') required String roomID,
  }) = _AddScheduleReq;
}
