import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/core/user/domain/service/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  Future<void> login(Credential credential) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _login(credential));
  }

  Future<void> _login(Credential credential) async {
    final userService = ref.read(userServiceProvider);
    await userService.login(credential);
  }
}
