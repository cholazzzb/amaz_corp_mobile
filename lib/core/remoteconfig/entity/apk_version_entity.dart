import 'package:freezed_annotation/freezed_annotation.dart';

part 'apk_version_entity.freezed.dart';
part 'apk_version_entity.g.dart';

@freezed
class APKVersion with _$APKVersion {
  @JsonSerializable(explicitToJson: true)
  const factory APKVersion({
    @JsonKey(name: "apk-version") required String apkVersion,
  }) = _APKVersion;

  factory APKVersion.fromJSON(Map<String, dynamic> json) =>
      _$$APKVersionImplFromJson(json);
}
