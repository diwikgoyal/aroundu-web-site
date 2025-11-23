import 'package:aroundu/models/house.model.dart';
import 'package:aroundu/models/lobby.dart';
import 'package:aroundu/models/profile.model.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:aroundu/views/auth/auth.view.dart';
import 'package:aroundu/views/auth/otp.screen.dart';
import 'package:aroundu/views/auth/phone_number.screen.dart';
import 'package:aroundu/views/dashboard/dashboard.view.dart';
import 'package:aroundu/views/filters/lobbyFilter.view.dart';
import 'package:aroundu/views/filters/lobbyFilterResult.view.dart';
import 'package:aroundu/views/house/house.details.view.dart';
import 'package:aroundu/views/landingPage.dart';
import 'package:aroundu/views/lobby/access.req.expanded.view.dart';
import 'package:aroundu/views/lobby/access_request.view.dart';
import 'package:aroundu/views/lobby/access_request_user.lobby.view.dart';
import 'package:aroundu/views/lobby/checkout.view.lobby.dart';
import 'package:aroundu/views/lobby/invite.lobby.view.dart';
import 'package:aroundu/views/lobby/lobby.noAuth.checkout.view.dart';
import 'package:aroundu/views/lobby/lobby.quick.checkout.dart';
import 'package:aroundu/views/lobby/lobby.transaction.status.view.dart';
import 'package:aroundu/views/lobby/lobby.view.dart';
import 'package:aroundu/views/lobby/lobby_settings_screen.dart';
import 'package:aroundu/views/lobby/shared.lobby.extended.view.dart';
import 'package:aroundu/views/lobby/widgets/featured_Conversation.dart';
import 'package:aroundu/views/lobby/widgets/view_all_explore.dart';
import 'package:aroundu/views/notifications/notifications.view.dart';
import 'package:aroundu/views/offer/apply.offer.dart';
import 'package:aroundu/views/onboarding/view.onboarding.dart';
import 'package:aroundu/views/payment/gateway_service/Cashfree/cashfree.payment.dart';
import 'package:aroundu/views/profile/user_profile_followed_view.dart';
import 'package:aroundu/views/scanner/scanner_view.dart';
import 'package:aroundu/views/scanner/share_qr_screen.dart';
import 'package:aroundu/views/search/search.view.dart';
import 'package:aroundu/views/splash.view.dart';
import 'package:get/get.dart';

class AppRoutes {
  // Route name constants
  static const String landing = '/';
  static const String splash = '/splash';
  static const String dashboard = '/dashboard';
  static const String auth = '/auth/:destination'; //new,lobby
  static const String phoneNumber = '/phone';
  static const String otp = '/otp';
  static const String search = '/search';
  static const String filter = '/filter';
  static const String filterResult = '/filter/results';
  static const String viewAllLobbies = '/lobby/all';
  static const String viewAllHouses = '/house/all';
  static const String quickLobbyCheckout = '/lobby/:lobbyId/checkout/quick';
  static const String checkOutPublicLobbyView = '/checkout';
  static const String noAuthCheckoutLobbyView = '/lobby/:lobbyId/checkout/simple';

  static const String transactionStatus = "/lobby/:lobbyId/status/:transactionId";
  static const String scanQrScreen = '/scan-qr';
  static const String shareQrScreen = '/qr';
  static const String lobbySettings = '/lobby/settings';
  static const String sharedAccessRequestCardExtendedView = '/lobby/access-request-extended/:accessReqId';
  static const String featuredConversations = '/lobby/featured-conversations';

  //notifications
  static const String notifications = '/notifications';
  static const String notificationsGeneral = '/notifications/general';
  static const String notificationsRequests = '/notifications/requests';
  static const String notificationsInvitations = '/notifications/invitations';

  //profile
  static const String myProfile = '/myProfile';
  static const String otherProfile = '/otherProfile/:userId';

  //house
  static const String house = '/house/:houseId';

  //lobby
  static const String lobby = '/lobby/:lobbyId';
  static const String lobbyRequests = '/lobby/requests/:lobbyId/:title';
  static const String lobbyAccessRequest = '/lobby/access-request';
  static const String lobbyAccessRequestShare = '/lobby/access-request-share';
  static const String detailAccessRequest = '/lobby/access-request-detail';
  static const String downloadAccessRequestData = '/lobby/access-request-download';
  static const String accessRequestFormFillView = '/lobby/access-request-form-fill';
  static const String applyOffers = '/lobby/offers/:lobbyId';
  static const String inviteExternalAttendees = '/lobby/external-attendees';
  static const String inviteFriends = '/invite/friends';
  static const String onboarding = '/onboarding/:startingPageIndex/:destination';
  static const String cashfree = '/cashfree';

  // Define all routes as GetPage objects
  static final List<GetPage> routes = [
    GetPage(name: landing, page: () => AppLandingPage(), transition: Transition.fadeIn),
    GetPage(name: splash, page: () => SplashView(), transition: Transition.fadeIn),
    GetPage(
      name: auth,
      page: () => AuthView(destination: Get.parameters['destination'] ?? 'new'),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(name: dashboard, page: () => DashboardView(), transition: Transition.rightToLeftWithFade),
    GetPage(name: notifications, page: () => NotificationsView(), transition: Transition.rightToLeftWithFade),
    GetPage(name: myProfile, page: () => ProfileDetailsFollowedScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(
      name: phoneNumber,
      page: () => PhoneNumberScreen(onContinue: Get.arguments['onContinue']),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: otp,
      page: () => OtpScreen(
        phoneNumber: Get.arguments != null ? Get.arguments['phoneNumber'] ?? '' : '',
        onVerify: Get.arguments != null ? Get.arguments['onVerify'] ?? (String _) {} : (String _) {},
        onResendOtp: Get.arguments != null ? Get.arguments['onResendOtp'] ?? () {} : () {},
      ),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(name: search, page: () => SearchView(), transition: Transition.rightToLeftWithFade),
    GetPage(name: filter, page: () => LobbyFilterView(), transition: Transition.rightToLeftWithFade),
    GetPage(
      name: filterResult,
      page: () => LobbyFilterResultView(results: Get.arguments != null ? Get.arguments['results'] : FilterResponse()),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: viewAllLobbies,
      page: () => ViewAllLobbiesExplore(
        title: Get.arguments != null ? Get.arguments['title'] ?? "" : "",
        lobbies: Get.arguments != null ? Get.arguments['lobbies'] ?? <Lobby>[] : <Lobby>[],
      ),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: viewAllHouses,
      page: () => ViewAllHousesExplore(
        title: Get.arguments != null ? Get.arguments['title'] ?? "" : "",
        houses: Get.arguments != null ? Get.arguments['houses'] ?? <House>[] : <House>[],
      ),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: lobbyAccessRequest,
      page: () => UserLobbyAccessRequest(
        lobby: Get.arguments != null ? Get.arguments['lobby'] : null,
        isIndividual: Get.arguments != null ? Get.arguments['isIndividual'] ?? true : true,
        selectedTickets: Get.arguments != null ? Get.arguments['selectedTickets'] : [],
      ),
    ),
    GetPage(
      name: lobbyAccessRequestShare,
      page: () => UserLobbyAccessRequestShare(
        friends: Get.arguments != null ? Get.arguments['friends'] ?? [] : [],
        squads: Get.arguments != null ? Get.arguments['squads'] ?? [] : [],
        lobbyId: Get.arguments != null ? Get.arguments['lobbyId'] ?? "" : "",
        lobbyHasForm: Get.arguments != null ? Get.arguments['lobbyHasForm'] ?? false : false,
        lobbyIsPrivate: Get.arguments != null ? Get.arguments['lobbyIsPrivate'] ?? false : false,
        requestText: Get.arguments != null ? Get.arguments['requestText'] ?? "" : "",
        formModel: Get.arguments != null ? Get.arguments['formModel'] : null,
        selectedTickets: Get.arguments != null ? Get.arguments['selectedTickets'] : [],
      ),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: lobby,
      page: () {
        final param = Get.parameters['ref'];
        return LobbyView(lobbyId: Get.parameters['lobbyId'] ?? "", referralSource: param);
      },
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: house,
      page: () => HouseDetailsView(houseId: Get.parameters['houseId'] ?? ""),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: detailAccessRequest,
      page: () => AccessRequestPage(
        request: Get.arguments != null ? Get.arguments['request'] : null,
        lobbyId: Get.arguments != null ? Get.arguments['lobbyId'] : "",
        isGroup: Get.arguments != null ? Get.arguments['isGroup'] : false,
      ),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: downloadAccessRequestData,
      page: () => FileOptionsDialog(fileUrl: Get.arguments != null ? Get.arguments['fileUrl'] ?? "" : ""),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: applyOffers,
      page: () => ApplyOffers(lobbyId: Get.parameters['lobbyId'] ?? ""),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: inviteFriends,
      page: () => InviteFriendsView(lobby: Get.arguments != null ? Get.arguments['lobby'] : null),
    ),
    GetPage(
      name: quickLobbyCheckout,
      page: () {
        final param = Get.parameters['ref'];
        return LobbyQuickCheckoutView(lobbyId: Get.parameters['lobbyId'] ?? "", referralSource: param);
      },
    ),
    GetPage(
      name: noAuthCheckoutLobbyView,
      page: () {
        final param = Get.parameters['ref'];
        return LobbyNoAuthCheckoutView(lobbyId: Get.parameters['lobbyId'] ?? "", referralSource: param);
      },
    ),
    GetPage(
      name: checkOutPublicLobbyView,
      page: () => CheckOutPublicLobbyView(
        lobby: Get.arguments != null ? Get.arguments['lobby'] : null,
        formModel: Get.arguments != null ? Get.arguments['formModel'] : null,
        requestText: Get.arguments != null ? Get.arguments['requestText'] : "",
        selectedTickets: Get.arguments != null ? Get.arguments['selectedTickets'] : [],
      ),
    ),
    GetPage(
      name: transactionStatus,
      page: () => LobbytransactionStatusView(
        lobbyId: Get.parameters['lobbyId'] ?? "",
        transactionId: Get.parameters['transactionId'] ?? "",
      ),
    ),

    GetPage(
      name: scanQrScreen,
      page: () => ScanQrScreen(
        lobby: Get.arguments != null ? Get.arguments['lobby'] : null,
        lobbyId: Get.arguments != null ? Get.arguments['lobbyId'] : "",
      ),
    ),
    GetPage(
      name: shareQrScreen,
      page: () => SharedQrScreen(qrId:  Get.parameters['qrId'] ?? ""),
    ),
    GetPage(
      name: lobbyRequests,
      page: () =>
          AccessRequestsView(lobbyId: Get.parameters['lobbyId'] ?? "", pageTitle: Get.parameters['title'] ?? ""),
    ),
    GetPage(
      name: lobbySettings,
      page: () => LobbySettingsScreen(lobby: Get.arguments != null ? Get.arguments['lobby'] : null),
    ),
    GetPage(
      name: sharedAccessRequestCardExtendedView,
      page: () => SharedAccessRequestCardExtendedView(accessReqId: Get.parameters['accessReqId'] ?? ""),
    ),
    GetPage(
      name: featuredConversations,
      page: () => DetailedViewOfFeaturedConversation(lobby: Get.arguments != null ? Get.arguments['lobby'] : null),
    ),
    GetPage(
      name: onboarding,
      page: () => OnboardingView(
        startingPageIndex: Get.parameters != null ? int.parse(Get.parameters['startingPageIndex'] ?? "0") : 0,
        destination: Get.parameters != null ? Get.parameters['destination'] ?? "new" : "new",
      ),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: cashfree,
      page: () => CashFreePaymentView(
        userId: Get.arguments != null ? Get.arguments['userId'] ?? "" : "",
        lobby: Get.arguments != null ? Get.arguments['lobby'] : null,
        formModel: Get.arguments != null ? Get.arguments['formModel'] : null,
        formList: Get.arguments != null ? Get.arguments['formList'] : [],
        requestText: Get.arguments != null ? Get.arguments['requestText'] : "",
        // selectedTickets: Get.arguments != null ? Get.arguments['selectedTickets'] : [],
      ),
    ),
    GetPage(
      name: accessRequestFormFillView,
      page: () => AccessRequestFormFillView(
        lobbyId: Get.arguments != null ? Get.arguments['lobbyId'] : "",
        groupId: Get.arguments != null ? Get.arguments['groupId'] : "",
        isPrivate: Get.arguments != null ? Get.arguments['isPrivate'] : true,
      ),
    ),
    // GetPage(
    //   name: otherProfile,
    //   page: () {
    //     // Get the userId parameter from the URL
    //     final userId = Get.parameters['userId'];
    //     // You would typically pass this to a profile view that shows other users
    //     // For now, we'll just use the ProfileView as a placeholder
    //     return ProfileView();
    //   },
    //   transition: Transition.rightToLeftWithFade,
    // ),
    // Add more routes as needed
  ];
}
