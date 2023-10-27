import 'package:go_router/go_router.dart';

import 'package:amaz_corp_mobile/feature/user/screen/login_screen.dart';
import 'package:amaz_corp_mobile/feature/user/screen/register_screen.dart';

enum UserRouteName {
  login,
  register,
}

class UserRoute {
  static List<GoRoute> create() {
    return [
      GoRoute(
        path: 'login',
        name: UserRouteName.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: 'register',
        name: UserRouteName.register.name,
        builder: (context, state) => const RegisterScreen(),
      ),
    ];
  }
}
