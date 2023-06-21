/// Base class for all all client-side errors that can be generated by the app
class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}
