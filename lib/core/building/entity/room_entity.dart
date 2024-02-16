import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_entity.freezed.dart';
part 'room_entity.g.dart';

@freezed
class Room with _$Room {
  @JsonSerializable(explicitToJson: true)
  const factory Room({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
  }) = _Room;

  factory Room.fromJSON(Map<String, dynamic> json) => _$$RoomImplFromJson(json);
}
