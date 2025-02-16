import 'package:injectable/injectable.dart';

import '../common/result.dart';
import '../entity/sign_up_request.dart';
import '../entity/sign_up_response.dart';
import '../repository/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<Result<UserModel>> execute(SignUpRequest data) async {
    return await _authRepository.signUp(data);
  }
}