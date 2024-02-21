import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fss_db.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage fssDB(FssDBRef ref) {
  return const FlutterSecureStorage();
}
