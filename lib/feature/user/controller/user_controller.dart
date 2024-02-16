import 'package:amaz_corp_mobile/core/user/domain/service/user_service.dart';
import 'package:amaz_corp_mobile/core/user/entity/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller.g.dart';

@riverpod
class GetListUserByUsernameController
    extends _$GetListUserByUsernameController {
  @override
  FutureOr<List<UserQuery>> build() => Future.value([]);

  Future<void> getListUser({
    required String username,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final users = await _getListUser(username);
      return users;
    });
  }

  Future<List<UserQuery>> _getListUser(String username) async {
    final svc = ref.read(userServiceProvider);
    return await svc.getListUserByUsername(username);
  }
}
