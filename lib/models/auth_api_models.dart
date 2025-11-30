// Models for the custom API authentication flow

class ApiResponse<T> {
  final String message;
  final String status;
  final int code;
  final T data;

  ApiResponse({
    required this.message,
    required this.status,
    required this.code,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return ApiResponse<T>(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      code: json['code'] ?? 0,
      data: fromJsonT(json['data']),
    );
  }

  // Helper method for string data
  factory ApiResponse.withStringData(Map<String, dynamic> json) {
    return ApiResponse<T>(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      code: json['code'] ?? 0,
      data: json['data'] as T,
    );
  }

  // Helper method to check if the response is successful
  bool get isSuccess => status == 'SUCCESS' && code == 0;
}

// Model for OTP verification response which contains JWT tokens
class OtpVerificationResponse {
  final String token;
  final String refreshToken;

  OtpVerificationResponse({required this.token, required this.refreshToken});

  factory OtpVerificationResponse.fromJson(dynamic data) {
    // Check if data is a Map containing accessToken and refreshToken
    if (data is Map<String, dynamic>) {
      return OtpVerificationResponse(
        token: data['accessToken'] ?? '',
        refreshToken: data['refreshToken'] ?? '',
      );
    }
    // Fallback for old API format where data is directly the token string
    return OtpVerificationResponse(token: data.toString(), refreshToken: '');
  }
}

class GoogleSignInResponse {
  final String jwtToken;
  final String accessToken;

  GoogleSignInResponse({required this.jwtToken, required this.accessToken});

  factory GoogleSignInResponse.fromJson(dynamic data) {
    // Check if data is a Map containing accessToken and refreshToken
    if (data is Map<String, dynamic>) {
      return GoogleSignInResponse(
        jwtToken: data['accessToken'] ?? '',
        accessToken: data['refreshToken'] ?? '',
      );
    }
    // Fallback for old API format where data is directly the token string
    return GoogleSignInResponse(jwtToken: data.toString(), accessToken: '');
  }
}

class AppleSignInResponse {
  final String jwtToken;
  final String accessToken;

  AppleSignInResponse({required this.jwtToken, required this.accessToken});

  factory AppleSignInResponse.fromJson(dynamic data) {
    if (data is Map<String, dynamic>) {
      return AppleSignInResponse(
        jwtToken: data['accessToken'] ?? '',
        accessToken: data['refreshToken'] ?? '',
      );
    }
    // Fallback for old API format where data is directly the token string
    return AppleSignInResponse(jwtToken: data.toString(), accessToken: '');
  }
}

// Model for token refresh response
class TokenRefreshResponse {
  final String accessToken;
  final String refreshToken;

  TokenRefreshResponse({required this.accessToken, required this.refreshToken});

  factory TokenRefreshResponse.fromJson(dynamic data) {
    if (data is Map<String, dynamic>) {
      return TokenRefreshResponse(
        accessToken: data['accessToken'] ?? '',
        refreshToken: data['refreshToken'] ?? '',
      );
    }
    throw FormatException('Invalid token refresh response format');
  }
}
