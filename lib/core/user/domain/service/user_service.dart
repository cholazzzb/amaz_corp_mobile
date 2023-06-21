import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/remote_user_repo.dart';
import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_service.g.dart';

class UserService {
  UserService(this.ref);
  final Ref ref;

  Future<void> login(Credential credential) async {
    final localUserRepo = ref.watch(localUserRepoProvider);
    final remoteUserRepo = ref.read(remoteUserRepoProvider);

    final result = await remoteUserRepo.postLogin(
      credential.username,
      credential.password,
    );
    localUserRepo.setToken(result.right);
  }
}

@Riverpod(keepAlive: true)
UserService userService(UserServiceRef ref) {
  return UserService(ref);
}
