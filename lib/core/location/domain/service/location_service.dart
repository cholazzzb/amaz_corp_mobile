import 'package:amaz_corp_mobile/core/location/data/datasource/remote_location_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

class LocationService {
  LocationService(this.ref);
  final Ref ref;
}

@Riverpod(keepAlive: true)
LocationService locationService(LocationServiceRef ref) {
  return LocationService(ref);
}

@riverpod
Future<int> getAllLocations(
  GetAllLocationsRef ref,
  VoidCallback onUnauthorizedError,
) async {
  try {
    return await ref.read(remoteLocationRepoProvider).getAllLocations();
  } on DioException catch (err) {
    if (err.response?.statusCode == 401) {
      onUnauthorizedError();
    }
    return 1;
  }
}
