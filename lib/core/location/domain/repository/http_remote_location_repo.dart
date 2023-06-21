import 'package:amaz_corp_mobile/core/location/data/datasource/remote_location_repo.dart';
import 'package:dio/dio.dart';

class HttpRemoteLocationRepo implements RemoteLocationRepo {
  const HttpRemoteLocationRepo(this._dio);

  final Dio _dio;

  @override
  Future<int> getAllLocations() async {
    const uri = 'api/v1/buildings/all';

    final response = await _dio.get(uri);
    return response.data;
  }
}
