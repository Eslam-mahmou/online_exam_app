import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:online_exam_app/data/repository_impl/auth_repository_impl.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late AuthRepositoryImpl auth;
  late AuthRemoteDataSource authRemoteDataSource;
  setUp(
    () {
      authRemoteDataSource = MockAuthRemoteDataSource();
      auth = AuthRepositoryImpl(authRemoteDataSource);
    },
  );
  group(
    "Auth Repository impl test",
    () {
      var email="";
      var password = "";
      test("When call login from auth repo impl "
          "it should call login from auth remote data source ", () async {
       var result=Response(requestOptions: RequestOptions(),);
        provideDummy<Response>(result);
            when(authRemoteDataSource.login(email, password)).thenAnswer(
              (_) async=>result ,
            );
            var actual = await auth.login(email, password);
            verify(authRemoteDataSource.login(email, password)).called(1);
            expect(actual, equals(result));
          },);
    },
  );
}
