
import 'package:dio/dio.dart';
import 'package:online_exam_app/core/errors/dio_error.dart';
import 'package:online_exam_app/domain/common/result.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return Success(result);
  } catch (ex) {
    if (ex is DioException) {
      return Error(ServerFailure.fromDioError(ex).toString());
    }
    else if (ex is ServerFailure) {
      return Error(ServerFailure(ex.errorMessage).toString());
    }
    else {
      return Error(NetworkFailure(ex.toString()).toString());
    }
  }
}
// on DioException catch (ex) {
//   switch (ex.type) {
//     case DioExceptionType.connectionTimeout:
//       return Error(ServerFailure('connection timeout with apiServer'));
//     case DioExceptionType.sendTimeout:
//       return Error(ServerFailure('send timeout with apiServer'));
//     case DioExceptionType.receiveTimeout:
//       return Error(ServerFailure('receive timeout with apiServer'));
//     case DioExceptionType.badCertificate:
//     // case DioExceptionType.badResponse:
//     //   return Error(ServerFailure.BadfromResponse(
//     //       ex.response!.statusCode!, ex.response!.data));
//     case DioExceptionType.cancel:
//       return Error(ServerFailure('Requst to ApiServer was canceld'));
//     case DioExceptionType.connectionError:
//       return Error(ServerFailure('no internet connection ,please try again'));
//     case DioExceptionType.unknown:
//       return Error(ServerFailure('Unexpected error ,please try later!'));
//     case DioExceptionType.badResponse:
//       {
//         if ((ex.response!.statusCode == 400 ||
//             ex.response!.statusCode == 401 ||
//             ex.response!.statusCode == 403)) {
//           return Error(ServerFailure(ex.response!.data["message"]));
//         } else if (ex.response!.statusCode == 409) {
//           return Error(ServerFailure("Account Already Exists"));
//         } else if (ex.response!.statusCode == 404) {
//           return Error(ServerFailure(
//               'Your request not found please try again later!'));
//         } else if (ex.response!.statusCode == 500) {
//           return Error(ServerFailure(
//               'Internal server error, please try again later!'));
//         }
//         // else if (statusCode ==409){
//         //   return Error(erverFailure("Account Already Exists"));
//         // }
//         else {
//           return Error(
//               ServerFailure('Opps there was an error ,please try again'));
//         }
//       }
//     default:
//       return Error(
//           ServerFailure('Opps there was an error ,please try again'));
//   }
// } catch (ex) {
//   return Error(NetworkFailure(ex.toString()));
// }