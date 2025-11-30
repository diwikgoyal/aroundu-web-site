import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/api_service/api.service.dart';
import '../../utils/logger.utils.dart';

class SignInService {
  static final logger = Logger();

  late final ApiService apiService;
  static final SignInService _instance = SignInService._internal();

  factory SignInService() {
    return _instance;
  }

  SignInService._internal() {
    apiService = ApiService();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Get current user ID
  String getCurrentUserId() => _firebaseAuth.currentUser?.uid ?? '';

  Future<UserCredential?> signInAuthWithGoogle() async {
    try {
      // Sign out before a new sign-in attempt
      await _firebaseAuth.signOut();

      if (kIsWeb) {
        // Web-specific Google Sign-In implementation using Firebase Auth
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();

        // Set custom parameters for web OAuth
        googleProvider.setCustomParameters({
          'client_id':
              '44553271030-2k6qtv5q3nssdl384v5umahev7pk0tb2.apps.googleusercontent.com',
        });

        // Add scopes for web
        googleProvider.addScope('email');
        googleProvider.addScope('profile');

        // Use popup sign-in for web
        return await _firebaseAuth.signInWithPopup(googleProvider);
      } else {
        await _googleSignIn.initialize(
          clientId:
              '44553271030-2k6qtv5q3nssdl384v5umahev7pk0tb2.apps.googleusercontent.com',
        );

        final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
          scopeHint: ['email', 'profile'], // Specify required scopes
        );

        final GoogleSignInAuthentication googleAuth = googleUser.authentication;

        // Get authorization for Firebase scopes if needed
        final authClient = _googleSignIn.authorizationClient;
        final authorization = await authClient.authorizationForScopes([
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ]);

        final credential = GoogleAuthProvider.credential(
          accessToken: authorization?.accessToken,
          idToken: googleAuth.idToken,
        );

        return await FirebaseAuth.instance.signInWithCredential(credential);
      }

      //
    } on FirebaseAuthException catch (e, st) {
      // More specific error handling for different platforms

      String errorMessage = 'Authentication failed';

      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage =
              'An account already exists with a different sign-in method.';
          break;
        case 'invalid-credential':
          errorMessage = 'The credential is invalid or has expired.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Google Sign-In is not enabled for this app.';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
          break;
        default:
          errorMessage = 'Authentication failed: ${e.message}';
      }

      debugPrint("Google Sign-In Error ==>$e -------------- $st");

      // final error = AppError(
      //   message: errorMessage,
      //   type: ErrorType.auth,
      //   stackTrace: st,
      //   originalError: e,
      // );

      // logger.fetal(error.message, error: error, stackTrace: error.stackTrace);
      kLogger.trace("Google Sign-In Error ==>$errorMessage -------------- $st");

      return null;

      //
    } catch (e, st) {
      String errorMessage = 'Google Sign-In failed + $e';

      if (e.toString().contains('network_error') ||
          e.toString().contains('ApiException')) {
        errorMessage =
            'Network error or Google Play Services issue. Please check your connection and try again.';
      } else {
        errorMessage =
            'An unexpected error occurred during Google Sign-In + $e';
      }

      kLogger.trace("Google Sign-In Error ==>$errorMessage -------------- $st");

      // final error = AppError(
      //   message: errorMessage,
      //   type: ErrorType.auth,
      //   stackTrace: st,
      //   originalError: e,
      // );

      // Safe sign out on error
      try {
        await signOut();
      } catch (signOutError) {
        logger.error(
          'Failed to sign out after Google Sign-In error',
          error: signOutError,
        );
      }

      // logger.fetal(error, error: error, stackTrace: error.stackTrace);
      return null;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      // Sign out before a new sign-in attempt
      await _firebaseAuth.signOut();

      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCrendential = await SignInWithApple.getAppleIDCredential(
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.polar.aroundu-service',
          redirectUri: Uri.parse(
            'https://aroundu-community.firebaseapp.com/__/auth/handler',
          ),
        ),
        nonce: nonce,
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthProvider = OAuthProvider('apple.com').credential(
        idToken: appleCrendential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCrendential.authorizationCode,
      );

      return await _firebaseAuth.signInWithCredential(oAuthProvider);

      //
    } on FirebaseAuthException catch (e, st) {
      String errorMessage = 'Apple Sign-In authentication failed';

      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage =
              'An account already exists with a different sign-in method.';
          break;
        case 'invalid-credential':
          errorMessage = 'The Apple credential is invalid or has expired.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Apple Sign-In is not enabled for this app.';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
          break;
        default:
          errorMessage = 'Apple Sign-In failed: ${e.message}';
      }

      debugPrint("Apple Sign-In Error ==>$e -------------- $st");

      // final error = AppError(
      //   message: errorMessage,
      //   type: ErrorType.auth,
      //   stackTrace: st,
      //   originalError: e,
      // );

      // logger.fetal(error.message, error: error, stackTrace: error.stackTrace);
      kLogger.trace("Apple Sign-In Error ==>$errorMessage -------------- $st");

      return null;

      //
    } catch (e, st) {
      String errorMessage = 'Apple Sign-In failed';

      if (e.toString().contains('SignInWithAppleAuthorizationException')) {
        errorMessage = 'Apple Sign-In was cancelled or failed authorization.';
      } else if (e.toString().contains('network_error')) {
        errorMessage =
            'Network error during Apple Sign-In. Please check your connection.';
      } else {
        errorMessage = 'An unexpected error occurred during Apple Sign-In + $e';
      }

      kLogger.trace("Apple Sign-In Error ==>$errorMessage -------------- $st");

      // Safe sign out on error
      try {
        await signOut();
      } catch (signOutError) {
        logger.error(
          'Failed to sign out after Apple Sign-In error',
          error: signOutError,
        );
      }

      // logger.fetal(error.message, error: error, stackTrace: error.stackTrace);

      return null;
    }
  }

  // Sign out from both Firebase and Google
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      logger.info('Firebase sign out successful');
    } catch (e, st) {
      logger.error('Firebase sign out failed', error: e, stackTrace: st);
    }

    try {
      if (!kIsWeb) {
        await _googleSignIn.signOut();
        logger.info('Google sign out successful');
      }
    } catch (e, st) {
      logger.error('Google sign out failed', error: e, stackTrace: st);
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
