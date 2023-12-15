import 'package:amaz_corp_mobile/core/user/data/dto/user_dto.dart';
import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/core/user/domain/repository/http_remote_user_repo.dart';
import 'package:amaz_corp_mobile/core/user/user_entity.dart';
import 'package:amaz_corp_mobile/shared/api/dio_factory.dart';
import 'package:amaz_corp_mobile/shared/env.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_user_repo.g.dart';

abstract class RemoteUserRepo
    implements RemoteUserRepoCommand, RemoteUserRepoQuery {}

abstract class RemoteUserRepoCommand {
  Future<Either<Exception, UserDTO>> postRegister(
    String username,
    String password,
  );
  Future<Token> postLogin(String username, String password);
}

abstract class RemoteUserRepoQuery {
  Future<List<UserQuery>> getListUserByUsername(String req);
}

@riverpod
RemoteUserRepo remoteUserRepo(RemoteUserRepoRef ref) {
  final baseUrl = Environment.getBaseUrl();

  return HttpRemoteUserRepo(
    DioFactory(
      baseUrl: baseUrl,
      interceptor: InterceptorType.auth,
    ).create(),
  );
}
