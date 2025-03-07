import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/domain/entity/sign_up_request.dart';
import 'package:online_exam_app/domain/entity/sign_up_response.dart';
import 'package:online_exam_app/domain/repository/auth_repository.dart';
import 'package:online_exam_app/domain/use_case/auth_use_case.dart';

import 'auth_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late AuthUseCase useCase;
  late AuthRepository repo;
  setUp(
    () {
      repo = MockAuthRepository();
      useCase = AuthUseCase(repo);
    },
  );
  group('Auth use case test', () {
    var email = "solomm";
    var password = "ASDasd@123";
    test(
      "when call call_login from use case it should "
      "call login from repo",
      () async {
        var result = Success<LoginResponseEntity>(LoginResponseEntity(
            message: "error", token: "token", user: UserLoginResponseEntity()));
        provideDummy<Result<LoginResponseEntity>>(result);
        when(repo.login(email, password)).thenAnswer(
          (_) async => result,
        );
        var actual = await useCase.callLogin(email, password);
        verify(repo.login(email, password)).called(1);
        expect(actual,equals(result));
      },
    );
    test(
        "when call execute from use case it should "
        "call sign up from repo", () async {
      var result = Success<UserModel>(UserModel(
              username: '',
              firstName: '',
              lastName: '',
              email: email,
              phone: '',
              password: password));
      provideDummy<Result<UserModel>>(result);
      when(repo.signUp(SignUpRequest(
              username: '',
              firstName: '',
              lastName: '',
              email: email,
              password:password,
              rePassword: password,
              phone: '')))
          .thenAnswer(
        (_) async => result,
      );
      var actual=await useCase.execute(SignUpRequest(
          username: '',
          firstName: '',
          lastName: '',
          email: email,
          password:password,
          rePassword: password,
          phone: ''));
      verify(repo.signUp(SignUpRequest(
          username: '',
          firstName: '',
          lastName: '',
          email: email,
          password:password,
          rePassword: password,
          phone: ''))).called(1);
      expect(actual, equals(result));
    });
  });
}
