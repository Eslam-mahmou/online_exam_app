import '../../domain/entity/change_password_response_entity.dart';

class ChangePasswordResponseDto extends ChangePasswordResponseEntity {
  ChangePasswordResponseDto({
    super.message,
    super.token,
  });

  ChangePasswordResponseDto.formJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
  }
}
