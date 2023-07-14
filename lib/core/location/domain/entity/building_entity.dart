import 'package:freezed_annotation/freezed_annotation.dart';

part 'building_entity.freezed.dart';
part 'building_entity.g.dart';

@freezed
class Building with _$Building {
  @JsonSerializable(explicitToJson: true)
  const factory Building({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'Name') required String name,
  }) = _Building;

  factory Building.fromJSON(Map<String, dynamic> json) =>
      _$$_BuildingFromJson(json);
}
