import 'package:freezed_annotation/freezed_annotation.dart';

part 'building_entity.freezed.dart';
part 'building_entity.g.dart';

@freezed
class Building with _$Building {
  @JsonSerializable(explicitToJson: true)
  const factory Building({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
  }) = _Building;

  factory Building.fromJSON(Map<String, dynamic> json) =>
      _$$_BuildingFromJson(json);
}

@freezed
class BuildingMember with _$BuildingMember {
  @JsonSerializable(explicitToJson: true)
  const factory BuildingMember({
    @JsonKey(name: 'buildingID') required String id,
    @JsonKey(name: 'buildingName') required String name,
    @JsonKey(name: 'memberID') required String memberID,
  }) = _BuildingMember;

  factory BuildingMember.fromJSON(Map<String, dynamic> json) =>
      _$$_BuildingMemberFromJson(json);
}

@Freezed(toJson: true)
class AddBuildingReq with _$AddBuildingReq {
  @JsonSerializable(explicitToJson: true)
  const factory AddBuildingReq({
    @JsonKey(name: 'name') required String name,
  }) = _AddBuildingReq;

  factory AddBuildingReq.fromJSON(Map<String, dynamic> json) =>
      _$$_AddBuildingReqFromJson(json);
}
