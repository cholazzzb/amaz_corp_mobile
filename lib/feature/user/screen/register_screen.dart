import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/feature/user/controller/register_controller.dart';
import 'package:amaz_corp_mobile/feature/user/screen/validator.dart';
import 'package:amaz_corp_mobile/routing/user_router.dart';
import 'package:amaz_corp_mobile/shared/async_value_ui.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/error/error_bottom_sheet_500.dart';
import 'package:amaz_corp_mobile/shared/layout/plain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  bool _showPassword = false;

  @override
  void initState() {
    _showPassword = false;
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _submit(VoidCallback onSuccess) async {
    final controller = ref.read(registerControllerProvider.notifier);
    await controller.register(Credential(username, password), onSuccess);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      registerControllerProvider,
      (prev, state) => state.showErrorBottomSheet(
        context,
        child: ErrorBottomSheet500(
          onPressClose: () => Navigator.pop(context),
        ),
      ),
    );

    void onSuccessRegister() {
      context.goNamed(UserRouteName.login.name);

      final snackBar = SnackBar(
        backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
        content: const Text("Register Success!"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

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
                      decoration: const InputDecoration(labelText: 'Username'),
                      controller: _usernameController,
                      validator: usernameValidator,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: _showPassword
                              ? const Icon(Icons.remove_red_eye_outlined)
                              : const Icon(Icons.remove_red_eye_rounded),
                          onPressed: () => setState(() {
                            _showPassword = !_showPassword;
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submit(onSuccessRegister);
                      }
                    },
                    icon: const Icon(Icons.app_registration),
                    label: const Text('Register'),
                  ),
                  const SizedBox(width: 12.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.goNamed(UserRouteName.login.name);
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
