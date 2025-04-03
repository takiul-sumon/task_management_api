import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkClient {
  static final Logger _logger = Logger();
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _preRequestLog(url);
      Response response = await get(uri);
      _postRequestLog(
        url,
        response.statusCode,
        headers: response.headers,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errormessage = decodedJson['data'] ?? "Something went wrong";
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errormessage,
        );
      }
    } catch (e) {
      _postRequestLog(url, -1);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _preRequestLog(url, body: body);
      _logger.i('Url => $url');
      Response response = await post(
        uri,
        headers: {'Content-type': 'Application/json'},
        body: jsonEncode(body),
      );
      _postRequestLog(
        url,
        response.statusCode,
        headers: response.headers,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessange = decodedJson['data'] ?? "Something went wrong";
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessange,
        );
      }
    } catch (e) {
      _postRequestLog(url, -1, errorMessage: e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void _preRequestLog(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'Url: $url\n'
      'body:$body\n',
    );
  }

  static void _postRequestLog(
    String url,
    int statusCode, {
    Map<String, dynamic>? headers,
    dynamic responseBody,
    dynamic errorMessage,
  }) {
    if (errorMessage != null) {
      _logger.e(
        'Url: $url\n'
        'statusCode:$statusCode\n'
        'headers:$headers\n'
        'responseBody:$responseBody\n',
      );
    }
    _logger.i(
      'Url: $url\n'
      'statusCode:$statusCode\n'
      'headers:$headers\n'
      'responseBody:$responseBody\n',
    );
  }
}
