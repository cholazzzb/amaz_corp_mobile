import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/core/user/domain/service/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<void> build() {}

  Future<void> register(Credential credential) async {
    state = const AsyncValue.loading();
    await AsyncValue.guard(() => _register(credential));
  }

  Future<void> _register(Credential credential) async {
    final userService = ref.read(userServiceProvider);
    await userService.register(credential);
  }
}
