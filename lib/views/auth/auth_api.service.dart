import 'dart:convert';

import 'package:aroundu/constants/urls.dart';
import 'package:aroundu/utils/api_service/api.service.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:aroundu/views/auth/auth.service.dart';
import 'package:aroundu/models/auth_api_models.dart';
import 'package:dio/dio.dart';

class AuthApiService {
  static final AuthApiService _instance = AuthApiService._internal();
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();

  factory AuthApiService() {
    return _instance;
  }

  AuthApiService._internal();

  // Send OTP to the provided mobile number
  Future<ApiResponse<String>> sendOtp(String mobile) async {
    try {
      final response = await _apiService.post(
        'user/api/v1/auth/sendOtp',
        body: {'mobile': mobile},
      );

      // Store the mobile number for later use
      await _authService.storeMobile(mobile);

      return ApiResponse.withStringData(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Resend OTP to the stored mobile number
  Future<ApiResponse<String>> resendOtp() async {
    try {
      final mobile = _authService.getMobile();
      if (mobile.isEmpty) {
        throw Exception('Mobile number not found');
      }

      final response = await _apiService.post(
        'user/api/v1/auth/resentOtp',
        body: {'mobile': mobile},
      );

      return ApiResponse.withStringData(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Verify OTP and store the JWT token
  Future<ApiResponse<OtpVerificationResponse>> verifyOtp(String otp) async {
    try {
      final mobile = _authService.getMobile();
      if (mobile.isEmpty) {
        throw Exception('Mobile number not found');
      }

      final response = await _apiService.post(
        'user/api/v1/auth/verifyOtp',
        body: {'mobile': mobile, 'otp': otp},
      );

      final apiResponse = ApiResponse<OtpVerificationResponse>.fromJson(
        response.data,
        (data) => OtpVerificationResponse.fromJson(data),
      );

      // Store the JWT token if verification is successful
      if (apiResponse.isSuccess) {
        await _authService.storeToken(apiResponse.data.token);
        await _authService.storeRefreshToken(apiResponse.data.refreshToken);
        await _authService.updateLastTokenRefresh();
      }

      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse<GoogleSignInResponse>> googleSignIn(
    String identityToken,
  ) async {
    try {
      final response = await _apiService.post(
        'user/api/v1/auth/google',
        body: {'idToken': identityToken},
      );

      final apiResponse = ApiResponse<GoogleSignInResponse>.fromJson(
        response.data,
        (data) => GoogleSignInResponse.fromJson(data),
      );

      // Store the JWT token if verification is successful
      if (apiResponse.isSuccess) {
        await _authService.storeToken(apiResponse.data.jwtToken);
        await _authService.storeRefreshToken(apiResponse.data.accessToken);
        await _authService.updateLastTokenRefresh();
      }

      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse<AppleSignInResponse>> appleSignIn(
    String identityToken,
  ) async {
    try {
      final response = await _apiService.post(
        'user/api/v1/auth/apple',
        body: {'idToken': identityToken},
      );

      final apiResponse = ApiResponse<AppleSignInResponse>.fromJson(
        response.data,
        (data) => AppleSignInResponse.fromJson(data),
      );

      // Store the JWT token if verification is successful
      if (apiResponse.isSuccess) {
        await _authService.storeToken(apiResponse.data.jwtToken);
        await _authService.storeRefreshToken(apiResponse.data.accessToken);
        await _authService.updateLastTokenRefresh();
      }

      return apiResponse;
    } catch (e) {
      rethrow;
    }
  }

  // Refresh the access token using the refresh token
  Future<bool> refreshToken() async {
    try {
      kLogger.trace("refreshing token");
      // Check if we need to refresh to prevent loops
      if (!_authService.isTokenRefreshNeeded) {
        return false;
      }

      final refreshToken = _authService.getRefreshToken();
      if (refreshToken.isEmpty) {
        return false;
      }

      // Create a new Dio instance to avoid using the interceptors
      final dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.arounduBaseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      final response = await dio.post(
        'user/api/v1/auth/refreshToken',
        data: jsonEncode({'refreshToken': refreshToken}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      kLogger.trace(response.data.toString());

      if (response.statusCode == 200 && response.data['status'] == 'SUCCESS') {
        final tokenResponse = TokenRefreshResponse.fromJson(
          response.data['data'],
        );
        await _authService.storeToken(tokenResponse.accessToken);
        await _authService.storeRefreshToken(tokenResponse.refreshToken);
        await _authService.updateLastTokenRefresh();
        return true;
      }

      return false;
    } catch (e) {
      // If refresh fails, we don't want to throw an error
      // Just return false to indicate failure
      return false;
    }
  }
}
