import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum FssKey {
  token,
  isLoggedIn,
}

class FssLocalUserRepo implements LocalUserRepo {
  final storage = const FlutterSecureStorage();

  @override
  Future<String> getToken() async {
    String? res = await storage.read(key: FssKey.token.name);
    if (res == null) {
      return "";
    }
    return res;
  }

  @override
  Future<void> setToken(Token token) async {
    try {
      await storage.write(key: FssKey.token.name, value: token);
      return;
    } on Exception catch (err) {
      print("err save token: $err");
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    String? res = await storage.read(key: FssKey.isLoggedIn.name);
    if (res == null) {
      return false;
    }
    return res == "true";
  }

  @override
  Future<void> setIsLoggedIn(bool isLoggedIn) async {
    try {
      String value = isLoggedIn ? "true" : "false";
      await storage.write(key: FssKey.isLoggedIn.name, value: value);
      return;
    } on Exception catch (err) {
      print("err save token: $err");
    }
  }
}
