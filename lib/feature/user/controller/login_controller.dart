import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/core/user/domain/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  Future<void> login(
    Credential credential,
    VoidCallback onSuccess,
  ) async {
    state = const AsyncValue.loading();

    try {
      await _login(credential);
      onSuccess.call();
      state = const AsyncValue.data(null);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<void> _login(Credential credential) async {
    final userService = ref.read(userServiceProvider);
    await userService.login(credential);
  }
}
