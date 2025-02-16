import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';

abstract class AuthRepository {
  Future<Result<LoginResponseEntity>> login(String email,String password);
}