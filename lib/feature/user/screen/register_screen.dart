import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/feature/user/controller/register_controller.dart';
import 'package:amaz_corp_mobile/feature/user/screen/login_screen.dart';
import 'package:amaz_corp_mobile/shared/layout/plain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum Status {
  idle,
  loading,
  success,
  error,
}

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({
    super.key,
    this.onRegister,
  });

  final VoidCallback? onRegister;

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
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

  Future<void> _submit(VoidCallback? onSuccess) async {
    final controller = ref.read(registerControllerProvider.notifier);
    await controller.register(Credential(username, password), onSuccess);
  }

  final _formKey = GlobalKey<FormState>();
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'username is required';
    }
    if (value.length < 5) {
      return 'username must at least 5 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PlainLayout(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Amaz Corp',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Register',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        controller: _usernameController,
                        validator: usernameValidator,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        controller: _passwordController,
                      )
                    ],
                  )),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submit(() => context.push("/locations"));
                      }
                    },
                    icon: const Icon(Icons.app_registration),
                    label: const Text('Register'),
                  ),
                  const SizedBox(width: 12.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Login'),
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
