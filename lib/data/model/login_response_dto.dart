import 'package:online_exam_app/domain/entity/login_response_entity.dart';

class LoginResponseDto extends LoginResponseEntity{
  LoginResponseDto({
      super.message,
      super.token,
      super.user,});

  LoginResponseDto.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? UserLoginResponseDTO.fromJson(json['user']) : null;
  }
}

class UserLoginResponseDTO extends UserLoginResponseEntity{
  UserLoginResponseDTO({
      super.id,
      super.username,
      super.firstName,
      super.lastName,
      super.email,
      super.phone,
    super.isVerified,
  });

  UserLoginResponseDTO.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    isVerified = json['isVerified'];
  }


}