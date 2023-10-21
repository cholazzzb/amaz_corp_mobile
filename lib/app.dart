import 'package:amaz_corp_mobile/app_dependencies.dart';
import 'package:amaz_corp_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadApp extends ConsumerWidget {
  const LoadApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<AppDependencies>>(
      appDependenciesProvider,
      (_, state) {
        if (state.hasValue) {
          FlutterNativeSplash.remove();
        }
      },
    );

    final appDependencies = ref.watch(appDependenciesProvider);
    return appDependencies.when(
      data: (_) => const MyApp(),
      // loading screen is handled by the native splash screen
      loading: () => const SizedBox.shrink(),
      error: (error, st) {
        return const SizedBox.shrink();
      },
    );
  }
}
