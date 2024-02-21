import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum FssKey {
  token,
  isLoggedIn,
  memberId,
}

class FssLocalUserRepo implements LocalUserRepo {
  final FlutterSecureStorage storage;

  FssLocalUserRepo({required this.storage});

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
    await storage.write(key: FssKey.token.name, value: token);
  }

  @override
  Future<void> removeToken() async {
    await storage.delete(key: FssKey.token.name);
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
    } on Exception {
      //
    }
  }

  @override
  Future<String> getMemberId() async {
    String? res = await storage.read(key: FssKey.memberId.name);
    if (res == null) {
      return "";
    }
    return res;
  }

  @override
  Future<void> setMemberId(String memberId) async {
    try {
      await storage.write(key: FssKey.memberId.name, value: memberId);
    } on Exception {
      //
    }
  }
}
