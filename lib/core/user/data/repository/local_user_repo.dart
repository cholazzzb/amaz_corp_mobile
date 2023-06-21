import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/core/user/domain/repository/fss_local_user_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_user_repo.g.dart';

abstract class LocalUserRepo {
  Future<Token?> getToken();
  Future<void> setToken(Token token);

  Future<bool> isLoggedIn();
  Future<void> setIsLoggedIn(bool isLoggedIn);
}

@Riverpod(keepAlive: true)
LocalUserRepo localUserRepo(LocalUserRepoRef ref) {
  return FssLocalUserRepo();
}
