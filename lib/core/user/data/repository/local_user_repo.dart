import 'package:amaz_corp_mobile/app_dependencies.dart';
import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/core/user/domain/repository/fss_local_user_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_user_repo.g.dart';

abstract class LocalUserRepo {
  Future<Token?> getToken();
  Future<void> setToken(Token token);
  Future<void> removeToken();

  Future<bool> isLoggedIn();
  Future<void> setIsLoggedIn(bool isLoggedIn);

  Future<String> getMemberId();
  Future<void> setMemberId(String memberId);
}

@Riverpod(keepAlive: true)
LocalUserRepo localUserRepo(LocalUserRepoRef ref) {
  final fssDB = ref.watch(appDependenciesProvider).requireValue.fssDB;
  return FssLocalUserRepo(storage: fssDB);
}
