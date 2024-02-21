import 'package:amaz_corp_mobile/app.dart';
import 'package:amaz_corp_mobile/feature/user/screen/welcome_screen.dart';
import 'package:amaz_corp_mobile/routing/app_router.dart';
import 'package:amaz_corp_mobile/shared/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  await loadEnv();
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  if (Environment.getEnv() == ENV.dev.name) {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  }

  OneSignal.initialize('corp.toro.amaz_corp_mobile');
  OneSignal.Notifications.requestPermission(true);

  runApp(
    const ProviderScope(
      child: LoadApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.read(goRouterProvider);
    return MaterialApp.router(
      title: 'Amaz Corp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreen();
  }
}
