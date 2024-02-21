import 'package:amaz_corp_mobile/shared/isar_db.dart';
import 'package:isar/isar.dart';

part 'isar_location_repo.g.dart';

@collection
class LocalLocationIsar {
  final String id;
  final String buildingID;

  Id get isarId => fastHash(id);

  LocalLocationIsar({
    required this.id,
    required this.buildingID,
  });
}
