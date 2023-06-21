import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/feature/user/controller/login_controller.dart';
import 'package:amaz_corp_mobile/shared/async_value_ui.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({
    super.key,
    this.onLogin,
  });

  final VoidCallback? onLogin;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String get username => _usernameController.text;
  String get password => _passwordController.text;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(VoidCallback onSuccess) async {
    final controller = ref.read(loginControllerProvider.notifier);
    await controller.login(Credential(username, password), onSuccess);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      loginControllerProvider,
      (previous, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(loginControllerProvider);

    return Layout(
      title: 'Login',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login', style: Theme.of(context).textTheme.headlineMedium),
              Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    controller: _usernameController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => context.go('/register'),
                    icon: const Icon(Icons.app_registration),
                    label: const Text('Register'),
                  ),
                  PrimaryButton(
                    text: 'Login',
                    isLoading: state.isLoading,
                    onPressed: () => _submit(() => context.go('/location')),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
