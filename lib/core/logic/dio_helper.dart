import 'package:dio/dio.dart';
import 'end_points.dart';

class DioHelper {
  final Dio dio;

  DioHelper({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

  }

  Future postData(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future getData(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      rethrow;
    }
  }
}