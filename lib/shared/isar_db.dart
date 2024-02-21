import 'package:amaz_corp_mobile/core/building/repository/isar_location_repo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_db.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isarDB(IsarDBRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([LocalLocationIsarSchema], directory: dir.path);
  return isar;
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
