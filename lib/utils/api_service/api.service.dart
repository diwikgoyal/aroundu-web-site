import 'dart:convert';
import 'dart:io';

import 'package:aroundu/constants/urls.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:aroundu/views/auth/auth.service.dart';
import 'package:aroundu/views/auth/auth_api.service.dart';
import 'package:aroundu/views/lobby/lobby.view.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

///
/// A singleton service class to handle communications w/ API's
///
class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.arounduBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // dio.interceptors.add(
    //   PrettyDioLogger(
    //     requestBody: true,
    //     responseBody: true,
    //     error: true,
    //   ),
    // );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('🔵 REQUEST: ${options.method} ${options.uri}');
          if (options.data != null) {
            print('📤 Request Body: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // print(
          //   '🟢 RESPONSE: ${response.statusCode} ${response.requestOptions.uri}',
          // );
          // Safely log response without causing UTF-8 issues
          if (response.data != null) {
            try {
              final dataStr = response.data.toString();
              final safeStr = dataStr
                  .replaceAll('\uFFFD', '')
                  .replaceAll('�', '');
              print(
                '📥 Response Body: ${safeStr.length > 500 ? '${safeStr.substring(0, 500)}...' : safeStr}',
              );
            } catch (e) {
              print('📥 Response Body: [Could not safely log response]');
            }
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          print('🔴 ERROR: ${error.message}');
          return handler.next(error);
        },
      ),
    );

    // Add token refresh interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          // Handle UTF-8 encoding issues in response
          if (response.data is String) {
            try {
              // Clean any replacement characters
              final cleanedData = (response.data as String)
                  .replaceAll('\uFFFD', '')
                  .replaceAll('�', '');

              // Try to parse as JSON if it's a string
              if (cleanedData.trim().startsWith('{') ||
                  cleanedData.trim().startsWith('[')) {
                response.data = jsonDecode(cleanedData);
              } else {
                response.data = cleanedData;
              }
            } catch (e) {
              // If JSON parsing fails, keep the cleaned string
              response.data = (response.data as String)
                  .replaceAll('\uFFFD', '')
                  .replaceAll('�', '');
            }
          } else if (response.data is Map || response.data is List) {
            // Recursively clean nested data
            response.data = _cleanResponseData(response.data);
          }

          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {

          // If the error is 401 Unauthorized, try to refresh the token
          if (error.response?.statusCode == 401) {
           
            // Try to refresh the token
            final authApiService = AuthApiService();
            final refreshed = await authApiService.refreshToken();

            if (refreshed) {
              // If token refresh was successful, retry the original request
              final options = error.requestOptions;
              // Update the Authorization header with the new token
              options.headers["Authorization"] =
                  "Bearer ${authService.getToken()}";

              // Create a new request with the updated headers
              final response = await dio.fetch(options);
              return handler.resolve(response);
            }
          }
          // If token refresh failed or error is not 401, continue with the error
          return handler.next(error);
        },
      ),
    );

    // //TODO: Warning : remove this code
    // // WARNING: TESTING CONFIGURATION ONLY
    // // This configuration bypasses security measures and routes traffic through a proxy
    // // Remove before releasing to production
    // // Configure the HTTP client adapter:
    // // Update to the new IOHttpClientAdapter
    // final adapter = IOHttpClientAdapter();

    // // Use createHttpClient instead of onHttpClientCreate
    // adapter.createHttpClient = () {
    //   final client = HttpClient();

    //   // Configure the proxy IP address and port
    //   client.findProxy = (uri) {
    //     // return "PROXY 192.168.169.28:8080"; // Change 8080 to your proxy's port if needed
    //     return "PROXY 10.0.2.2:8080"; // Change 8080 to your proxy's port if needed
    //   };

    //   // Bypass SSL certificate verification (for testing only)
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;

    //   return client;
    // };

    // // Assign the adapter to dio
    // dio.httpClientAdapter = adapter;
  }

  // static const String kBaseUrl = "https://api.aroundu.in/";
  late final Dio dio;
  final AuthService authService = AuthService();

  // Helper method to clean response data recursively
  dynamic _cleanResponseData(dynamic data) {
    if (data is String) {
      return data.replaceAll('\uFFFD', '').replaceAll('�', '');
    } else if (data is Map) {
      final cleaned = <String, dynamic>{};
      data.forEach((key, value) {
        cleaned[key] = _cleanResponseData(value);
      });
      return cleaned;
    } else if (data is List) {
      return data.map((item) => _cleanResponseData(item)).toList();
    }
    return data;
  }

  // TODO: I'll need to handle the connection timeout error as well
  // TODO: I'll need to handle the API error's as well
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final headers = await authService.getAuthHeaders();

    final response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );

    return response;
  }

  // TODO: I'll need to handle the connection timeout error as well
  // TODO: I'll need to handle the API error's as well
  Future<Response> post(
    String path, {
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.post(
      path,
      data: body,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          ...await authService.getAuthHeaders(),
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
      ),
    );

    // Clean response data to remove replacement characters
    // if (response.data != null) {
    //   response.data = _cleanResponseData(response.data);
    // }
    return response;
  }

  Future<Response> patch(
    String path, {
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.patch(
      path,
      data: jsonEncode(body),
      queryParameters: queryParameters,
      options: Options(headers: await authService.getAuthHeaders()),
    );

    return response;
  }

  Future<Response> put(
    String path, {
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.put(
      path,
      data: jsonEncode(body),
      queryParameters: queryParameters,
      options: Options(headers: await authService.getAuthHeaders()),
    );

    return response;
  }

  // TODO: Need to handle error's here
  Future<Map<String, dynamic>> getUserProfileData() async {
    final res = await get("user/api/v1/getProfile");
    // final data = jsonDecode(res.data.toString());

    return res.data as Map<String, dynamic>;
  }
}
