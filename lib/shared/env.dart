import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static void _check() {
    if (!dotenv.isInitialized) {
      throw Error();
    }
  }

  static String getBaseUrl() {
    _check();
    return dotenv.env["BASE_URL"] ?? "";
  }
}

void loadEnv() async {
  await dotenv.load(fileName: ".env");
}
