import 'package:aroundu/constants/appRoutes.dart';
import 'package:aroundu/models/profile.model.dart';
import 'package:aroundu/utils/api_service/api.service.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:aroundu/views/auth/auth.service.dart';
import 'package:aroundu/views/auth/auth_api.service.dart';
import 'package:aroundu/views/dashboard/dashboard.view.dart';
import 'package:aroundu/views/onboarding/view.onboarding.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/urls.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  late final ApiService userApiService;
  late final AuthService authService;
  late final AuthApiService authApiService;

  late Rx<String> userName = ''.obs;
  late Rx<String> userEmail = ''.obs;

  // late final ChatsController chatsController;

  @override
  void onInit() {
    super.onInit();

    userApiService = ApiService();
    authService = AuthService();
    authApiService = AuthApiService();
    // chatsController = Get.put(ChatsController());

    // Refresh token on app start if user is logged in
    if (authService.isLoggedIn) {
      refreshTokenOnStart();
    }
  }

  // Refresh token on app start
  Future<void> refreshTokenOnStart() async {
    try {
      kLogger.trace("Refreshing token on app start");
      await authApiService.refreshToken();
    } catch (e) {
      kLogger.error("Error refreshing token on app start", error: e);
    }
  }

  void updateLoadingState() {
    isLoading.value = !isLoading.value;
  }

  Future<void> checkUserOnboardingStatus({String destination = "new"}) async {
    final profile = await userApiService.getUserProfileData();

    // Store user ID from profile
    final userId = profile["userId"];
    await GetStorage().write("userUID", userId);
    await authService.storeUserId(userId);

    if (profile["status"] == "ONBOARDED") {
      kLogger.trace(
        "User's profile is completed! Current status is [${profile["status"]}].",
      );
      //getting and updating token
      // final token = await FirebaseMessaging.instance.getToken();
      // final storedToken = await GetStorage().read("fcmToken");
      // if (token != null) {
      //   if (storedToken == null || token != storedToken) {
      //     final response = await ApiService().post(
      //       ApiConstants.updateDeviceToken,
      //       body: {"deviceToken": token},
      //     );
      //     if (response.statusCode == 200) {
      //       await GetStorage().write("fcmToken", token);
      //       kLogger.trace("Device Token : $token");
      //     }
      //   } else {
      //     kLogger.trace("Device Token not available");
      //   }
      // }

      //initialize connection with sockets
      // chatsController.setCurrentUserId(userId);
      // await chatsController.initializeSocket(userId);

      // Ensure socket is connected before proceeding
      await Future.delayed(const Duration(milliseconds: 500));

      kLogger.trace("auth Going to `DashboardView`");

      Get.offAllNamed(AppRoutes.dashboard);
      if (destination != 'new') {
        Get.toNamed(AppRoutes.lobby.replaceAll(':lobbyId', destination));
      }

      //📝 NOTE: early return to avoid running code below
      return;
    }

    kLogger.trace("User's profile is not completed! Going to `OnboardingView`");

    Get.offNamed(
      AppRoutes.onboarding
          .replaceAll(':startingPageIndex', '0')
          .replaceAll(':destination', destination),
      arguments: [
        true,
        profile["status"] ?? "",
        userName.value, // No display name in custom auth
        "",
        "2004-02-10T18:30:00.000+00:00",
        "",
        <ProfileInterest>[],
        <UserInterest>[],
        <String>[],
        <Prompts>[],
        "MALE",
        userEmail.value,
      ],
    );

    //📝 NOTE: early return to avoid running code below
    return;
  }
}
