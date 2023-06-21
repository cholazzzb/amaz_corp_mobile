import 'package:amaz_corp_mobile/shared/exception/app_exception.dart';

class UnauthorizedException extends AppException {
  UnauthorizedException() : super('auth-unauthorized', 'Unauthorized');
}
