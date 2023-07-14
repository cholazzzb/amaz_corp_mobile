import 'dart:io';

import 'package:dotenv/dotenv.dart';

class Environment {
  static final Environment _environment = Environment._internal();
  late final DotEnv _env;
  late final String baseUrl;

  factory Environment() {
    return _environment;
  }

  Environment._internal() {
    _env = DotEnv(includePlatformEnvironment: true)..load(['.env']);
    final envBaseUrl = _env["BASE_URL"];
    if (envBaseUrl == null) {
      exit(1);
    }
    baseUrl = envBaseUrl;
  }
}
