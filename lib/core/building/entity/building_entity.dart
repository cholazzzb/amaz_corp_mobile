import 'package:flutter/foundation.dart';
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
      _$$BuildingImplFromJson(json);
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
      _$$BuildingMemberImplFromJson(json);
}

@Freezed(toJson: true)
class AddBuildingReq with _$AddBuildingReq {
  @JsonSerializable(explicitToJson: true)
  const factory AddBuildingReq({
    @JsonKey(name: 'name') required String name,
  }) = _AddBuildingReq;

  factory AddBuildingReq.fromJSON(Map<String, dynamic> json) =>
      _$$AddBuildingReqImplFromJson(json);
}

@Freezed(toJson: true)
class JoinBuildingReq with _$JoinBuildingReq {
  @JsonSerializable(explicitToJson: true)
  const factory JoinBuildingReq({
    @JsonKey(name: 'memberID') required String memberID,
    @JsonKey(name: 'buildingID') required String buildingID,
  }) = _JoinBuildingReq;

  factory JoinBuildingReq.fromJSON(Map<String, dynamic> json) =>
      _$$JoinBuildingReqImplFromJson(json);
}

@Freezed(toJson: true)
class InviteMemberToBuildingReq with _$InviteMemberToBuildingReq {
  @JsonSerializable(explicitToJson: true)
  const factory InviteMemberToBuildingReq({
    @JsonKey(name: 'userID') required String userID,
    @JsonKey(name: "buildingID") required String buildingID,
  }) = _InviteMemberToBuildingReq;

  factory InviteMemberToBuildingReq.fromJSON(Map<String, dynamic> json) =>
      _$$InviteMemberToBuildingReqImplFromJson(json);
}

@Freezed(toJson: true)
class RenameMemberNameReq with _$RenameMemberNameReq {
  @JsonSerializable(explicitToJson: true)
  const factory RenameMemberNameReq({
    @JsonKey(name: 'memberID') required String memberID,
    @JsonKey(name: "name") required String name,
  }) = _RenameMemberNameReq;

  factory RenameMemberNameReq.fromJSON(Map<String, dynamic> json) =>
      _$$RenameMemberNameReqImplFromJson(json);
}

@Freezed(toJson: true)
class GetListMemberByNameReq with _$GetListMemberByNameReq {
  @JsonSerializable(explicitToJson: true)
  const factory GetListMemberByNameReq({
    @JsonKey(name: 'name') required String name,
  }) = _GetListMemberByNameReq;

  factory GetListMemberByNameReq.fromJSON(Map<String, dynamic> json) =>
      _$$GetListMemberByNameReqImplFromJson(json);
}
