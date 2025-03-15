import 'package:dio/dio.dart';
abstract class DioFailure {
  final String errorMessage;

  DioFailure(this.errorMessage);
}

class ServerFailure extends DioFailure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('connection timeout with apiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('send timeout with apiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('receive timeout with apiServer');
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        return ServerFailure.badFromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Requst to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('no internet connection ,please try again');
      case DioExceptionType.unknown:
        return ServerFailure('Unexpected error ,please try later!');
      default:
        return ServerFailure('Opps there was an error ,please try again');
    }
  }

  factory ServerFailure.badFromResponse(int statusCode, dynamic response) {
    if ((statusCode == 400 || statusCode == 401 || statusCode == 403)) {
      return ServerFailure(response["message"]);
    }else if (statusCode ==409){
      return ServerFailure("Account Already Exists");
    }
    else if (statusCode == 404) {
      return ServerFailure('Your request not found please try again later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error, please try again later!');

    }
    // else if (statusCode ==409){
    //   return ServerFailure("Account Already Exists");
    // }
    else {
      return ServerFailure('Opps there was an error ,please try again');
    }
  }
}

class NetworkFailure extends ServerFailure {
  NetworkFailure(super.errMessage);

  final message = "Network error, please try again";
}
