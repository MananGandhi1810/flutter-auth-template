import 'dart:convert';

import 'package:auth_template/models/network_response.dart';
import 'package:dio/dio.dart';

class NetworkService {
  final Dio _dio = Dio();

  Future<NetworkResponseModel> get(
    String url, {
    String? token,
  }) async {
    Response res = await _dio.get(
      url,
      options: Options(
        headers: token != null ? {"Authorization": "Bearer $token"} : {},
        validateStatus: (_) => true,
      ),
    );
    return NetworkResponseModel(
      statusCode: res.statusCode ?? 200,
      success: res.data['success'],
      message: res.data['message'],
      data: res.data['data'],
    );
  }

  Future<NetworkResponseModel> post(
    String url,
    Map data, {
    String? token,
  }) async {
    Response res = await _dio.post(
      url,
      data: data,
      options: Options(
        headers: token != null ? {"Authorization": "Bearer $token"} : {},
        validateStatus: (_) => true,
      ),
    );
    return NetworkResponseModel(
      statusCode: res.statusCode ?? 200,
      success: res.data['success'],
      message: res.data['message'],
      data: res.data['data'],
    );
  }
}
