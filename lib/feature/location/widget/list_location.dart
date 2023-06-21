import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/user/screen/login_screen.dart';
import 'package:amaz_corp_mobile/shared/exception/auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListLocation extends ConsumerWidget {
  const ListLocation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(getAllLocationsProvider(
      () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      ),
    ));
    return locationAsync.when(
      data: (data) => const Center(child: Text('Data')),
      error: (e, st) {
        if (e == UnauthorizedException) {
          print("PUFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF!");
          return Center(
            child: Text(
              e.toString(),
            ),
          );
        }
        return Center(
          child: Text(
            e.toString(),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
