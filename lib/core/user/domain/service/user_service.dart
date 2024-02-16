import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/remote_user_repo.dart';
import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/core/user/entity/user_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_service.g.dart';

class UserService {
  UserService(this.ref);
  final Ref ref;

  Future<void> login(Credential credential) async {
    final localUserRepo = ref.watch(localUserRepoProvider);
    final remoteUserRepo = ref.read(remoteUserRepoProvider);

    final token = await remoteUserRepo.postLogin(
      credential.username,
      credential.password,
    );

    await localUserRepo.setToken(token);
    await localUserRepo.setIsLoggedIn(true);
  }

  Future<void> register(Credential credential) async {
    final remoteUserRepo = ref.read(remoteUserRepoProvider);

    await remoteUserRepo.postRegister(
      credential.username,
      credential.password,
    );
  }

  Future<void> logout(VoidCallback cb) async {
    final localUserRepo = ref.watch(localUserRepoProvider);
    await localUserRepo.clearStorage();
    cb.call();
  }

  Future<List<UserQuery>> getListUserByUsername(
    String username,
  ) async {
    return await ref
        .read(remoteUserRepoProvider)
        .getListUserByUsername(username);
  }
}

@Riverpod(keepAlive: true)
UserService userService(UserServiceRef ref) {
  return UserService(ref);
}
