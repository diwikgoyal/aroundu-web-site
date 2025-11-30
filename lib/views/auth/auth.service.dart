import 'package:get_storage/get_storage.dart';

// Custom User class to mimic Firebase User properties
class CustomUser {
  final String uid;
  final String? displayName;
  final String? phoneNumber;

  CustomUser({required this.uid, this.displayName, this.phoneNumber});
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  static const String _tokenKey = 'jwt_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _mobileKey = 'user_mobile';
  static const String _displayNameKey = 'display_name';
  static const String _lastTokenRefreshKey = 'last_token_refresh';

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  // Check if user is logged in
  bool get isLoggedIn =>
      GetStorage().hasData(_tokenKey) && GetStorage().read(_tokenKey) != null;

  // Store JWT token
  Future<void> storeToken(String token) async {
    await GetStorage().write(_tokenKey, token);
  }

  // Get JWT token
  String getToken() {
    return GetStorage().read(_tokenKey) ?? '';
  }

  // Store refresh token
  Future<void> storeRefreshToken(String token) async {
    await GetStorage().write(_refreshTokenKey, token);
  }

  // Get refresh token
  String getRefreshToken() {
    return GetStorage().read(_refreshTokenKey) ?? '';
  }

  // Store last token refresh timestamp
  Future<void> updateLastTokenRefresh() async {
    await GetStorage().write(
      _lastTokenRefreshKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  // Check if token refresh is needed (to prevent loops)
  bool get isTokenRefreshNeeded {
    final lastRefresh = GetStorage().read(_lastTokenRefreshKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    // Only refresh if more than 5 seconds have passed since last refresh
    return (now - lastRefresh) > 5000;
  }

  // Store user mobile number
  Future<void> storeMobile(String mobile) async {
    await GetStorage().write(_mobileKey, mobile);
  }

  // Get user mobile number
  String getMobile() {
    return GetStorage().read(_mobileKey) ?? '';
  }

  // Store user ID (extracted from token or received from API)
  Future<void> storeUserId(String userId) async {
    await GetStorage().write(_userIdKey, userId);
  }

  // Get user ID
  String getUserId() {
    return GetStorage().read(_userIdKey) ?? '';
  }

  // Clear all auth data (logout)
  Future<void> clearAuthData() async {
    await GetStorage().remove(_tokenKey);
    await GetStorage().remove(_refreshTokenKey);
    await GetStorage().remove(_userIdKey);
    await GetStorage().remove(_mobileKey);
    await GetStorage().remove(_lastTokenRefreshKey);
  }

  // Get auth headers for API requests
  Future<Map<String, dynamic>> getAuthHeaders() async {
    final token = getToken();
    return {"Authorization": "Bearer $token"};
  }

  // Get current user (mimics Firebase Auth's currentUser)
  CustomUser? get currentUser {
    if (!isLoggedIn) return null;

    final userId = getUserId();
    final mobile = getMobile();

    if (userId.isEmpty) return null;

    return CustomUser(
      uid: userId,
      phoneNumber: mobile,
      displayName: GetStorage().read(_displayNameKey),
    );
  }

  // Store display name if needed
  Future<void> storeDisplayName(String? name) async {
    if (name != null) {
      await GetStorage().write(_displayNameKey, name);
    }
  }
}
