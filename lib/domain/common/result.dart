import 'package:online_exam_app/core/errors/dio_error.dart';

sealed class Result<T>{}
class Success<T> extends Result<T>{
  T? data;
  Success(this.data);
}
class Error<T> extends Result<T>{
  DioFailure? exception;
  Error(this.exception);
}
