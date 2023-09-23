import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_entity.freezed.dart';
part 'member_entity.g.dart';

@freezed
class Member with _$Member {
  @JsonSerializable(explicitToJson: true)
  const factory Member({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'userID') required String userID,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'roomID') required String roomID,
    @JsonKey(name: 'status') required String status,
  }) = _Member;

  factory Member.fromJSON(Map<String, dynamic> json) =>
      _$$_MemberFromJson(json);
}
