import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FssLocalUserRepo implements LocalUserRepo {
  final storage = const FlutterSecureStorage();

  @override
  Future<void> setToken(Token token) async {
    try {
      await storage.write(key: 'token', value: token);
      return;
    } on Exception catch (err) {
      print("err save token: $err");
    }
  }

  @override
  Future<String> getToken() async {
    String? res = await storage.read(key: 'token');
    if (res == null) {
      return "";
    }
    return res;
  }
}
