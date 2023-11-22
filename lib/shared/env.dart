import 'package:flutter_dotenv/flutter_dotenv.dart';

enum ENV { dev, prod }

class Environment {
  static void _check() {
    if (!dotenv.isInitialized) {
      throw StateError('Environment is not already initialized!');
    }
  }

  static String getBaseUrl() {
    _check();
    return dotenv.env["BASE_URL"] ?? "";
  }

  static String getEnv() {
    _check();
    return dotenv.env["ENV"] ?? ENV.dev.name;
  }
}

Future<void> loadEnv() async {
  await dotenv.load(fileName: ".env");
}
