import 'package:amaz_corp_mobile/core/user/data/dto/user_dto.dart';
import 'package:amaz_corp_mobile/core/user/domain/entity/user_entity.dart';

class UserMapper {
  static UserEntity mapDTOtoEntity(UserDTO dto) {
    return UserEntity(username: dto.username, password: dto.password);
  }
}
