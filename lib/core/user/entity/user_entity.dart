import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserQuery with _$UserQuery {
  @JsonSerializable(explicitToJson: true)
  const factory UserQuery({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'username') required String username,
  }) = _UserQuery;

  factory UserQuery.fromJSON(Map<String, dynamic> json) =>
      _$$UserQueryImplFromJson(json);
}
