import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/constant_manager.dart';

@injectable
@singleton
class ApiManager {
  static ApiManager? _this;

  ApiManager._() {
    // initializeInterceptors();
  }

  factory ApiManager() {
    _this ??= ApiManager._();
    return _this!;
  }

  Dio dio = Dio();

  Future<Response> getData(String endPoint,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return await dio.get(AppConstants.baseUrl + endPoint,
        queryParameters: queryParameters,
        options: Options(validateStatus: (status) => true, headers: headers));
  }

  Future<Response> postData(String endPoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    return await dio.post(AppConstants.baseUrl + endPoint,
        data: body,
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ));
  }

  Future<Response> deleteData(String endPoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    return await dio.delete(AppConstants.baseUrl + endPoint,
        data: body,
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ));
  }

  Future<Response> putData(String endPoint, Map<String, dynamic> body,
      Map<String, dynamic>? headers) async {
    log("Sending PUT request to: ${AppConstants.baseUrl + endPoint}");
    log("Request Body: ${jsonEncode(body)}");
    log("Request Headers: $headers");
    return await dio.put(AppConstants.baseUrl + endPoint,
        data: body,
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ));
  }

  Future<Response> patchData(String endPoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    log("Sending PATCH request to: ${AppConstants.baseUrl + endPoint}");
    log("Request Body: ${jsonEncode(body)}");
    log("Request Headers: $headers");

    return await dio.patch(AppConstants.baseUrl + endPoint,
        data: body,
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ));
  }

  initializeInterceptors() {
    dio.interceptors.clear();
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 120,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("send request: ${options.baseUrl} path: ${options.path}");
          debugPrint("headers: ${options.headers}");
          debugPrint("query parameters: ${options.queryParameters}");
          debugPrint("data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("status code: ${response.statusCode}");
          debugPrint("data: ${response.data}");
        },
        onError: (DioException e, handler) {
          debugPrint(" message: ${e.message}");
          debugPrint("status code: ${e.response?.statusCode}");
          debugPrint("error type: ${e.type}");
          debugPrint("data: ${e.response?.data}");
          debugPrint("error: ${e.error}");
          debugPrint("path: ${e.requestOptions.path}");
          debugPrint("response: ${e.response}");
          return handler.next(e);
        },
      ),
    );
  }
}
