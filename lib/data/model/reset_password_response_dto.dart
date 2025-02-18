import 'package:online_exam_app/domain/entity/reset_password_response_entity.dart';

class ResetPasswordResponseDto extends ResetPasswordResponseEntity {
  ResetPasswordResponseDto({super.message, super.token,this.code});
  num? code;
  ResetPasswordResponseDto.formJson(Map<String,dynamic >json){
    message = json['message'];
    token = json['token'];
    code = json['code'];
  }
}
