import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:aroundu/constants/appRoutes.dart';
import 'package:aroundu/constants/colors_palette.dart';
import 'package:aroundu/designs/colors.designs.dart';
import 'package:aroundu/designs/fonts.designs.dart';
import 'package:aroundu/models/detailed.lobby.model.dart';
import 'package:aroundu/models/house.model.dart';
import 'package:aroundu/utils/api_service/api.service.dart';
import 'package:aroundu/utils/appDownloadCard.dart';
import 'package:aroundu/utils/custome_snackbar.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:aroundu/utils/share_util.dart';
import 'package:aroundu/views/auth/auth.service.dart';
import 'package:aroundu/views/auth/auth_api.service.dart';
import 'package:aroundu/views/dashboard/home.view.dart';
import 'package:aroundu/views/landingPage.dart';
import 'package:aroundu/views/ledger/lobby_ledger.dart';
import 'package:aroundu/views/lobby/access_request.view.dart';
import 'package:aroundu/views/lobby/add_tier_pricing.dart';
import 'package:aroundu/views/lobby/lobby_settings_screen.dart';
import 'package:aroundu/views/lobby/lobby_content_section.dart';
import 'package:aroundu/views/lobby/lobby_ticket_options_attendee.view.dart';
import 'package:aroundu/views/lobby/markdown_editor.dart';
import 'package:aroundu/views/lobby/provider/activate_lobby_provider.dart';
import 'package:aroundu/views/lobby/provider/get_price_provider.dart';
import 'package:aroundu/views/lobby/provider/lobbies_providers.dart';
import 'package:aroundu/views/lobby/provider/lobby_access_provider.dart';
import 'package:aroundu/views/lobby/provider/lobby_details_provider.dart';
import 'package:aroundu/views/lobby/provider/save_lobby_provider.dart';
import 'package:aroundu/views/lobby/provider/selected_tickets_provider.dart';
import 'package:aroundu/views/lobby/shared.lobby.extended.view.dart';
import 'package:aroundu/views/lobby/widgets/featured_Conversation.dart';
import 'package:aroundu/views/lobby/widgets/feedback.dart';
import 'package:aroundu/views/lobby/widgets/infoCard.dart';
import 'package:aroundu/views/lobby/widgets/mediaGallery.dart';
import 'package:aroundu/views/lobby/widgets/rich_text_display.dart';
import 'package:aroundu/views/lobby/widgets/small_edit_sheet.lobby.dart';
import 'package:aroundu/views/offer/offerViewer.dart';
import 'package:aroundu/views/profile/controllers/controller.profile.dart';
import 'package:aroundu/views/scanner/scanner_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/login_required_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/urls.dart';
import '../../designs/icons.designs.dart';
import '../../designs/utils.designs.dart';
import '../../designs/widgets/button.widget.designs.dart';
import '../../designs/widgets/icon.widget.designs.dart';
import '../../designs/widgets/space.widget.designs.dart';
import '../../designs/widgets/text.widget.designs.dart';
import '../../models/lobby.dart';
import '../../models/offers_model.dart';
import '../dashboard/dashboard.view.dart';
import '../profile/controllers/controller.groups.profiledart.dart';
import 'access_request_user.lobby.view.dart';
import 'attendee.screen.dart';
import 'checkout.view.lobby.dart';
import 'co_host.lobby.view.dart';
import 'invite.lobby.view.dart';

final housesForLobbiesProvider = FutureProvider.family<List<House>, String>((ref, lobbyId) async {
  try {
    String url = ApiConstants.getHouses;
    Map<String, dynamic> queryParameters = {'lobbyId': lobbyId};

    final response = await ApiService().get(url, queryParameters: queryParameters);

    if (response.data != null) {
      final houses = response.data.map<House>((json) {
        final house = House.fromJson(json);
        return house;
      }).toList();
      return houses;
    } else {
      throw Exception("Failed to load houses");
    }
  } catch (e) {
    kLogger.error("Error fetching houses: $e");
    throw Exception("Failed to fetch houses");
  }
});

final isLocationsExpandedProvider = StateProvider.family<bool, String>((ref, houseId) => false);

final isAuthProvider = StateProvider.family<bool, String>((ref, lobbyId) => false);

class LobbyView extends ConsumerStatefulWidget {
  const LobbyView({super.key, required this.lobbyId, this.referralSource});
  final String lobbyId;
  final String? referralSource;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LobbyViewState();
}

class _LobbyViewState extends ConsumerState<LobbyView> {
  late bool isSaved;

  // final urls = [
  final List<Color> avatarColors = [
    Colors.indigo[100]!,
    Colors.purple[100]!,
    Colors.deepOrange[100]!,
    Colors.teal[200]!,
  ];

  late GroupController groupController;
  late ProfileController profileController;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      kLogger.error('Flutter Error: ${details.exception}');
      kLogger.error('Stack trace: ${details.stack}');
    };

    Future.microtask(() async {
      await ref.read(lobbyDetailsProvider(widget.lobbyId).notifier).fetchLobbyDetails(widget.lobbyId);

      // Update isSaved after data is loaded
      final lobbyData = ref.read(lobbyDetailsProvider(widget.lobbyId)).value;
      if (lobbyData != null) {
        setState(() {
          isSaved = lobbyData.lobby.isSaved;
        });
      }
    });
  }

  // Function to handle bookmark toggle on tap
  Future<void> _onBookmarkTap({required String lobbyId}) async {
    // Call the provider to toggle the bookmark and pass current isSaved value
    await ref.read(toggleBookmarkProvider(itemId: lobbyId, isSaved: isSaved, entityType: "LOBBY").future);

    // After API call, toggle the local isSaved state
    setState(() {
      isSaved = !isSaved;
    });
  }

  Future<void> _onJoinOrRequest({required BuildContext context, required Lobby lobby}) async {
    // final lobby = widget.lobbyDetail.lobby;
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    // If user is ADMIN, directly go to invite people view
    if (lobby.userStatus == "ADMIN") {
      InviteOptionsModal.show(
        context,
        onInviteFriends: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(color: DesignColors.accent)],
                ),
              );
            },
          );
          // await groupController.fetchGroups();
          // await profileController.getFriends();
          Navigator.of(context, rootNavigator: true).pop();
          await Get.toNamed(
            AppRoutes.inviteFriends,
            arguments: {
              'lobby': lobby,
              // 'friends': profileController.friendsList,
              // 'squads': groupController.groups,
            },
          );
          ref.read(lobbyDetailsProvider(lobby.id).notifier).reset();
          await ref.read(lobbyDetailsProvider(lobby.id).notifier).fetchLobbyDetails(lobby.id);
        },
        onInviteExternalMembers: () async {
          FancyAppDownloadDialog.show(
            context,
            title: "Unlock Premium Features",
            message: "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
            appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
            playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
            // cancelButtonText: "Maybe Later",
            onCancel: () {
              print("User chose to skip download");
            },
          );
          // await Get.to(() => InviteExternalMembers(lobby: lobby));
          // ref.read(lobbyDetailsProvider(lobby.id).notifier).reset();
          // await ref
          //     .read(lobbyDetailsProvider(lobby.id).notifier)
          //     .fetchLobbyDetails(lobby.id);
        },
      );
    }
    // If user is VISITOR and lobby is private, show request options
    else if (lobby.userStatus == "VISITOR") {
      List<SelectedTicket> selectedTickets = [];
      if (lobby.isPrivate) {
        await JoinOptionsModal.show(
          context,
          onJoinWithFriends: () async {
            final GlobalKey<State> dialogKey = GlobalKey<State>();

            if (lobby.isAdvancedPricing) {
              // ['selectedTickets']
              final ticket = await Get.to(
                () => TicketOptionsForAttendee(
                  ticketOptions: lobby.ticketOptions,
                  lobbyTitle: lobby.title,
                  isMultiplePricing: lobby.allowMultiplePricingOptions,
                  lobbyId: lobby.id,
                ),
              );
              if (ticket == null || ticket['shouldProceed'] == false) {
                ref.read(selectedTicketsProvider.notifier).clearAll();
                return;
              } else {
                selectedTickets = ticket['selectedTickets'] as List<SelectedTicket>;
              }
            }

            // Show loading dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  key: dialogKey,
                  backgroundColor: Colors.transparent,
                  content: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator(color: DesignColors.accent)],
                  ),
                );
              },
            );

            await Future.wait([groupController.fetchGroups(), profileController.getFriends()]);
            if (context.mounted) {
              if (dialogKey.currentContext != null && Navigator.canPop(dialogKey.currentContext!)) {
                Navigator.pop(dialogKey.currentContext!);
              }
            }
            await Get.toNamed(
              AppRoutes.lobbyAccessRequest,
              arguments: {'lobby': lobby, 'isIndividual': false, 'selectedTickets': selectedTickets},
            );

            ref.read(lobbyDetailsProvider(lobby.id).notifier).reset();
            await ref.read(lobbyDetailsProvider(lobby.id).notifier).fetchLobbyDetails(lobby.id);
          },
          onJoinAsIndividual: () async {
            if (lobby.isAdvancedPricing) {
              // ['selectedTickets']
              final ticket = await Get.to(
                () => TicketOptionsForAttendee(
                  ticketOptions: lobby.ticketOptions,
                  lobbyTitle: lobby.title,
                  isMultiplePricing: lobby.allowMultiplePricingOptions,
                  lobbyId: lobby.id,
                ),
              );
              if (ticket == null || ticket['shouldProceed'] == false) {
                ref.read(selectedTicketsProvider.notifier).clearAll();
                return;
              } else {
                selectedTickets = ticket['selectedTickets'] as List<SelectedTicket>;
              }
            }
            await Get.toNamed(
              AppRoutes.lobbyAccessRequest,
              arguments: {'lobby': lobby, 'selectedTickets': selectedTickets},
            );

            ref.read(lobbyDetailsProvider(lobby.id).notifier).reset();
            await ref.read(lobbyDetailsProvider(lobby.id).notifier).fetchLobbyDetails(lobby.id);
          },
        );
      } else {
        if (lobby.isAdvancedPricing) {
          // ['selectedTickets']
          final ticket = await Get.to(
            () => TicketOptionsForAttendee(
              ticketOptions: lobby.ticketOptions,
              lobbyTitle: lobby.title,
              isMultiplePricing: lobby.allowMultiplePricingOptions,
              lobbyId: lobby.id,
            ),
          );
          if (ticket == null || ticket['shouldProceed'] == false) {
            ref.read(selectedTicketsProvider.notifier).clearAll();
            return;
          } else {
            selectedTickets = ticket['selectedTickets'] as List<SelectedTicket>;
          }
        }
        if (lobby.hasForm) {
          await Get.toNamed(
            AppRoutes.lobbyAccessRequest,
            arguments: {'lobby': lobby, 'selectedTickets': selectedTickets},
          );

          ref.read(lobbyDetailsProvider(lobby.id).notifier).reset();
          await ref.read(lobbyDetailsProvider(lobby.id).notifier).fetchLobbyDetails(lobby.id);
        } else {
          //only price
          if (lobby.priceDetails?.price != 0.0 && lobby.lobbyType == "PUBLIC") {
            // Show loading dialog while fetching pricing data
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [CircularProgressIndicator(color: DesignColors.accent)],
                  ),
                );
              },
            );

            // Fetch pricing data
            await ref
                .read(pricingProvider(lobby.id).notifier)
                .fetchPricing(lobby.id, groupSize: 1, selectedTickets: selectedTickets);

            // Close the loading dialog
            Navigator.of(context, rootNavigator: true).pop();

            final pricingState = ref.read(pricingProvider(lobby.id));
            final pricingData = pricingState.pricingData;

            if (pricingData != null && pricingData.status == 'SUCCESS') {
              await Get.toNamed(
                AppRoutes.checkOutPublicLobbyView,
                arguments: {'lobby': lobby, 'selectedTickets': selectedTickets},
              );

              ref.read(lobbyDetailsProvider(lobby.id).notifier).reset();
              await ref.read(lobbyDetailsProvider(lobby.id).notifier).fetchLobbyDetails(lobby.id);
            } else {
              // Show error message if pricing data couldn't be fetched
              CustomSnackBar.show(context: context, message: "Something went wrong", type: SnackBarType.error);
            }
          }
          //nothing
          else {
            // Show loading dialog while fetching pricing data
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [CircularProgressIndicator(color: DesignColors.accent)],
                  ),
                );
              },
            );

            // Fetch pricing data
            await ref.read(pricingProvider(lobby.id).notifier).fetchPricing(lobby.id, groupSize: 1);

            // Close the loading dialog
            Navigator.of(context, rootNavigator: true).pop();

            final pricingState = ref.read(pricingProvider(lobby.id));
            final pricingData = pricingState.pricingData;

            // Check if pricing data is available
            if (pricingData != null && pricingData.status == 'SUCCESS' && pricingData.total == 0.0) {
              final response = await ref.read(
                handleLobbyAccessProvider(lobby.id, lobby.isPrivate, text: "", hasForm: false).future,
              );
              if (response != null && response['status'] == 'SUCCESS') {
                Get.dialog(
                  Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset(
                                'assets/animations/success_badge.json',
                                repeat: false,
                                fit: BoxFit.fitHeight,
                                height: 0.2 * sh,
                                width: 0.9 * sw,
                              ),
                              Space.h(height: 8),
                              DesignText(
                                text: "  Congratulations 🎉",
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF323232),
                              ),
                              Space.h(height: 8),
                              DesignText(
                                text: "you have successfully joined the lobby",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF444444),
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Lottie.asset(
                          'assets/animations/confetti.json',
                          repeat: false,
                          fit: BoxFit.fill,
                          // height: 0.8.sw,
                        ),
                      ],
                    ),
                  ),
                  barrierDismissible: true,
                );
                Fluttertoast.showToast(msg: "successfully joined the lobby");
              }
              ref.read(lobbyDetailsProvider(lobby.id).notifier).reset();
              await ref.read(lobbyDetailsProvider(lobby.id).notifier).fetchLobbyDetails(lobby.id);
            } else {
              // Show error message if pricing data couldn't be fetched
              CustomSnackBar.show(context: context, message: "Something went wrong", type: SnackBarType.error);
            }

            // Get.back();
          }
        }
      }
    } else {
      CustomSnackBar.show(context: context, message: "Unexpected user status.", type: SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final lobbyDetailsAsync = ref.watch(lobbyDetailsProvider(widget.lobbyId));

    final isauth =
        ((authService.getToken() != null && authService.getToken().isNotEmpty) &&
        (authService.getRefreshToken() != null && authService.getRefreshToken().isNotEmpty));

    Future.microtask(() {
      print("isAuth in init : $isauth");
      if (isauth) {
        groupController = Get.put(GroupController());
        profileController = Get.put(ProfileController());
        ref.read(isAuthProvider(widget.lobbyId).notifier).state = true;
      } else {
        ref.read(isAuthProvider(widget.lobbyId).notifier).state = false;
      }
    });

    return lobbyDetailsAsync.when(
      data: (lobbyData) {
        List<UserSummary> userInfos = <UserSummary>[];
        List<UserSummary> displayAvatars = <UserSummary>[];
        int remainingCount = 0;
        if (lobbyData != null) {
          isSaved = lobbyData.lobby.isSaved;
          userInfos = lobbyData.lobby.userSummaries ?? [];

          displayAvatars = userInfos.take(3).toList();
          remainingCount = lobbyData.lobby.currentMembers - displayAvatars.length;
          print(lobbyData.lobby.userStatus);
        }
        final deviceType = DesignUtils.getDeviceType(context);
        return lobbyData == null
            ? Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.white70),
                    onPressed: () {
                      Get.back();
                    },
                    icon: DesignIcon.icon(icon: Icons.arrow_back_ios_sharp, size: 20),
                  ),
                  backgroundColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                ),
                body: RefreshIndicator(
                  key: Key("nullDataStateRefreshIndicator"),
                  onRefresh: () async {
                    ref.read(lobbyDetailsProvider(widget.lobbyId).notifier).reset();
                    await ref.read(lobbyDetailsProvider(widget.lobbyId).notifier).fetchLobbyDetails(widget.lobbyId);
                  },
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 0.85 * sh,
                      child: Center(
                        child: DesignText(
                          text: "Lobby Not Found !!!",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF444444),
                          maxLines: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(
                key: scaffoldKey,
                extendBodyBehindAppBar: deviceType == DeviceScreenType.phone,
                appBar: AppBar(
                  leading: IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.white70),
                    onPressed: () {
                      Get.back();
                    },
                    icon: DesignIcon.icon(icon: Icons.arrow_back_ios_sharp, size: 20),
                  ),
                  actions: [
                    // For FULL or CLOSED lobbies with privileged users
                    if ((lobbyData.lobby.lobbyStatus == "FULL" || lobbyData.lobby.lobbyStatus == "CLOSED") &&
                        lobbyData.lobby.userStatus == "MEMBER")
                      IconButton(
                        style: IconButton.styleFrom(backgroundColor: Colors.white70),
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            elevation: 4,
                            builder: (context) => LobbyAttendingStatusBottomSheet(lobby: lobbyData.lobby),
                          );
                        },
                        icon: DesignIcon.icon(icon: Icons.edit_calendar_outlined, color: Color(0xFF323232)),
                      ),

                    // For ACTIVE lobby with MEMBER status
                    if (lobbyData.lobby.lobbyStatus == "ACTIVE" && lobbyData.lobby.userStatus == "MEMBER")
                      IconButton(
                        style: IconButton.styleFrom(backgroundColor: Colors.white70),
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            elevation: 4,
                            builder: (context) => LobbyAttendingStatusBottomSheet(lobby: lobbyData.lobby),
                          );
                        },
                        icon: DesignIcon.icon(icon: Icons.edit_calendar_outlined, color: Color(0xFF323232)),
                      ),

                    if (lobbyData.lobby.userStatus == "MEMBER" && lobbyData.lobby.lobbyStatus != "PAST")
                      IconButton(
                        style: IconButton.styleFrom(backgroundColor: Colors.white70),
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.scanQrScreen,
                            arguments: {'lobbyId': lobbyData.lobby.id, 'lobby': lobbyData.lobby},
                          );
                        },
                        icon: DesignIcon.icon(icon: Icons.qr_code_scanner, color: Color(0xFF323232)),
                      ),

                    // Existing buttons
                    IconButton(
                      style: IconButton.styleFrom(backgroundColor: Colors.white70),
                      onPressed: () async {
                        HapticFeedback.selectionClick();
                        await ShareUtility.showShareBottomSheet(
                          context: context,
                          entityType: EntityType.lobby,
                          entity: lobbyData.lobby,
                        );
                      },
                      icon: DesignIcon.icon(icon: Icons.share, color: Color(0xFF323232)),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(backgroundColor: Colors.white70),
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        _onBookmarkTap(lobbyId: lobbyData.lobby.id);
                      },
                      icon: DesignIcon.icon(
                        icon: isSaved ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                        size: 18,
                        color: isSaved ? DesignColors.accent : Color(0xFF323232),
                      ),
                    ),
                    if (lobbyData.lobby.userStatus == "ADMIN")
                      IconButton(
                        style: IconButton.styleFrom(backgroundColor: Colors.white70),
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          scaffoldKey.currentState?.openEndDrawer();
                        },
                        icon: DesignIcon.icon(icon: Icons.more_vert_rounded, color: Color(0xFF323232)),
                      ),
                  ],
                  backgroundColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                ),
                bottomNavigationBar: Container(
                  height: 0.09 * sh,
                  constraints: BoxConstraints(minHeight: 64),
                  // color: DesignColors.accent.withValues(alpha: 0.5),
                  // padding: EdgeInsets.only(
                  //   left: 0.05 * sw,
                  //   right: 0.05 * sw,
                  //   bottom: 0.02 * sh,
                  //   top: 0.005 * sh,
                  // ),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildBottomNavigationBarLeftSideWidget(lobbyDetail: lobbyData),

                      // Right side button (expanded to fill remaining space)
                      Expanded(child: _buildBottomNavigationBarRightSideWidget(lobbyDetail: lobbyData)),
                    ],
                  ),
                ),
                endDrawer: Drawer(
                  backgroundColor: DesignColors.bg,
                  width: 0.65 * sw,
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 0.12 * sh, horizontal: 0.05 * sw),
                    children: [
                      ListTile(
                        leading: DesignIcon.custom(icon: DesignIcons.pencil, size: 16, color: const Color(0xFFEC4B5D)),
                        title: DesignText(
                          text: 'Edit',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF323232),
                        ),
                        onTap: () async {
                          if (lobbyData.lobby.isAdvancedPricing) {
                            FancyAppDownloadDialog.show(
                              context,
                              title: "Unlock Premium Features",
                              message:
                                  "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                              appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                              playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                              // cancelButtonText: "Maybe Later",
                              onCancel: () {
                                print("User chose to skip download");
                              },
                            );
                          } else {
                            showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              // constraints: BoxConstraints(
                              //   minHeight: 0.9.sh,
                              // ),
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: LobbySmallEditSheet(lobby: lobbyData.lobby),
                                );
                              },
                            );
                          }
                        },
                      ),
                      Space.h(height: 8),

                      ListTile(
                        leading: DesignIcon.custom(
                          icon: DesignIcons.personAdd,
                          size: 16,
                          color: const Color(0xFFEC4B5D),
                        ),
                        title: DesignText(
                          text: (lobbyData.lobby.lobbyType == 'PUBLIC') ? 'Form Submissions' : 'Access Requests',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF323232),
                        ),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.lobbyRequests
                                .replaceAll(':lobbyId', lobbyData.lobby.id)
                                .replaceAll(':title', (lobbyData.lobby.lobbyType == 'PUBLIC') ? 'Forms' : 'Requests'),
                          );
                          // Get.to(() => const AccessRequestPage());
                        },
                      ),
                      Space.h(height: 8),
                      ListTile(
                        leading: DesignIcon.icon(
                          icon: Icons.local_offer_outlined,
                          size: 16,
                          color: const Color(0xFFEC4B5D),
                        ),
                        title: DesignText(
                          text: 'Lobby Ledger',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF323232),
                        ),
                        onTap: () {
                          // Get.to(
                          //   () => LobbyLedgerPage(lobbyId: lobbyData.lobby.id),
                          // );
                          FancyAppDownloadDialog.show(
                            context,
                            title: "Unlock Premium Features",
                            message:
                                "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                            appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                            playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                            // cancelButtonText: "Maybe Later",
                            onCancel: () {
                              print("User chose to skip download");
                            },
                          );
                        },
                      ),
                      Space.h(height: 8),

                      ListTile(
                        leading: DesignIcon.icon(
                          icon: Icons.settings_outlined,
                          size: 16,
                          color: const Color(0xFFEC4B5D),
                        ),
                        title: DesignText(
                          text: 'Settings',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF323232),
                        ),
                        onTap: () {
                          Get.toNamed(AppRoutes.lobbySettings, arguments: {'lobby': lobbyData.lobby});
                        },
                      ),
                      Space.h(height: 8),
                    ],
                  ),
                ),
                body: RefreshIndicator(
                  key: Key("normalStateRefreshIndicator"),
                  onRefresh: () async {
                    ref.read(lobbyDetailsProvider(lobbyData.lobby.id).notifier).reset();
                    await ref
                        .read(lobbyDetailsProvider(lobbyData.lobby.id).notifier)
                        .fetchLobbyDetails(lobbyData.lobby.id);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: responsiveLayout(lobbyData: lobbyData, sh: sh, sw: sw),
                  ),
                ),
              );
      },
      error: (error, stack) {
        Future.microtask(() {
          ref.read(isAuthProvider(widget.lobbyId).notifier).state = false;
        });
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.white70),
              onPressed: () {
                Get.back();
              },
              icon: DesignIcon.icon(icon: Icons.arrow_back_ios_sharp, size: 20),
            ),
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
          ),
          body: RefreshIndicator(
            key: Key("errorStateRefreshIndicator"),
            onRefresh: () async {
              ref.read(lobbyDetailsProvider(widget.lobbyId).notifier).reset();
              await ref.read(lobbyDetailsProvider(widget.lobbyId).notifier).fetchLobbyDetails(widget.lobbyId);
            },
            child: SingleChildScrollView(
              child: SizedBox(
                height: 0.85 * sh,
                child: Column(
                  children: [
                    Center(
                      child: DesignText(
                        text: "Something went wrong \n Please try again !!!",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF444444),
                        maxLines: 10,
                      ),
                    ),
                    Space.h(height: 32),
                    DesignButton(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: DesignText(text: "Retry", fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      onPress: () async {
                        await authService.storeToken("");
                        final authApiService = AuthApiService();
                        final refreshed = await authApiService.refreshToken();

                        if (refreshed) {
                          ref.read(lobbyDetailsProvider(widget.lobbyId).notifier).reset();
                          await ref
                              .read(lobbyDetailsProvider(widget.lobbyId).notifier)
                              .fetchLobbyDetails(widget.lobbyId);
                        } else {
                          authService.clearAuthData();
                          ref.read(lobbyDetailsProvider(widget.lobbyId).notifier).reset();
                          await ref
                              .read(lobbyDetailsProvider(widget.lobbyId).notifier)
                              .fetchLobbyDetails(widget.lobbyId);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            style: IconButton.styleFrom(backgroundColor: Colors.white70),
            onPressed: () {
              Get.back();
            },
            icon: DesignIcon.icon(icon: Icons.arrow_back_ios_sharp, size: 20),
          ),
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 0.85 * sh,
            child: Center(child: CircularProgressIndicator(color: DesignColors.accent)),
          ),
        ),
      ),
    );
  }

  Widget responsiveLayout({required LobbyDetails lobbyData, required double sw, required double sh}) {
    return SimpleScreenBuilder(
      mobileLayout: mobileLayout(lobbyData: lobbyData, sh: sh, sw: sw),
      desktopLayout: desktopLayout(lobbyData: lobbyData, sh: sh, sw: sw),
    );
  }

  Widget mobileLayout({required LobbyDetails lobbyData, required double sw, required double sh}) {
    final isAuth = ref.watch(isAuthProvider(lobbyData.lobby.id));

    List<UserSummary> userInfos = <UserSummary>[];
    List<UserSummary> displayAvatars = <UserSummary>[];
    int remainingCount = 0;
    if (lobbyData != null) {
      isSaved = lobbyData.lobby.isSaved;
      userInfos = lobbyData.lobby.userSummaries ?? [];

      displayAvatars = userInfos.take(3).toList();
      remainingCount = lobbyData.lobby.currentMembers - displayAvatars.length;
      print(lobbyData.lobby.userStatus);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 0.6 * sh, minHeight: 0.2 * sh),
              child: MediaGallery.fromUrls(
                lobbyData.lobby.mediaUrls.isNotEmpty
                    ? lobbyData.lobby.mediaUrls
                    : [
                        "https://media.istockphoto.com/id/1329350253/vector/image-vector-simple-mountain-landscape-photo-adding-photos-to-the-album.jpg?s=612x612&w=0&k=20&c=3iXykf5ZQI2eBo0DaQ7W-e_8E5rhFEammFqO9XCisnI=",
                      ],
              ),
            ),
            Positioned(
              top: 0.1 * sh,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 12, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: (() {
                    switch (lobbyData.lobby.lobbyStatus) {
                      case "UPCOMING":
                        return Color(0xFF52D17C);
                      case "PAST":
                        return Color(0xFFF97853);
                      case "CLOSED":
                        return Color(0xFF3E79A1);
                      case "FULL":
                        return Color(0xFFF97853);
                      default:
                        return Color(0xFF52D17C);
                    }
                  })(),
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
                ),
                child: Row(
                  children: [
                    DesignIcon.custom(
                      icon: (() {
                        switch (lobbyData.lobby.lobbyStatus) {
                          case "UPCOMING":
                            return DesignIcons.upcoming;
                          case "PAST":
                            return DesignIcons.past;
                          case "CLOSED":
                            return DesignIcons.closed;
                          case "FULL":
                            return DesignIcons.past;
                          default:
                            return DesignIcons.running;
                        }
                      })(),
                      color: (lobbyData.lobby.lobbyStatus == 'ACTIVE') ? Colors.white : null,
                    ),
                    Space.w(width: 8),
                    DesignText(
                      text: (() {
                        switch (lobbyData.lobby.lobbyStatus) {
                          case "UPCOMING":
                            return "Upcoming";
                          case "PAST":
                            return "Past";
                          case "CLOSED":
                            return "Closed";
                          case "ACTIVE":
                            return "Active";
                          case "FULL":
                            return "Full";
                          default:
                            return "Join Now!";
                        }
                      })(),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.02 * sh,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: Color(0xFF5750E2), borderRadius: BorderRadius.circular(24)),
                    child: DesignText(
                      text: "${lobbyData.subCategory.iconUrl}    ${lobbyData.subCategory.name}",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  if (lobbyData.lobby.lobbyStatus != "PAST" && lobbyData.lobby.lobbyStatus != "CLOSED")
                    IconButton(
                      style: IconButton.styleFrom(backgroundColor: Colors.black38),
                      onPressed: () {},
                      icon: DesignIcon.icon(
                        icon: (lobbyData.lobby.isPrivate) ? Icons.lock_outline_rounded : Icons.lock_open_outlined,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  if (lobbyData.lobby.lobbyStatus == "PAST" || lobbyData.lobby.lobbyStatus == "CLOSED")
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.white),
                      child: Row(
                        children: [
                          DesignIcon.custom(icon: DesignIcons.star, color: null, size: 14),
                          Space.w(width: 4),
                          DesignText(
                            text: "${lobbyData.lobby.rating.average} (${lobbyData.lobby.rating.count})",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF444444),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: DesignUtils.scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (() {
                String combinedStatus = lobbyData.lobby.userStatus;

                switch (lobbyData.lobby.lobbyStatus) {
                  case "PAST":
                    combinedStatus = "${lobbyData.lobby.userStatus}_${lobbyData.lobby.lobbyStatus}";
                  case "UPCOMING":
                  case "CLOSED":
                    combinedStatus = "${lobbyData.lobby.userStatus}_${lobbyData.lobby.lobbyStatus}";

                  default: // ACTIVE
                }

                switch (combinedStatus) {
                  case "MEMBER":
                    return SizedBox.shrink();
                  case "ADMIN_PAST":
                    return SizedBox.shrink();
                  case "ADMIN":
                    if (lobbyData.lobby.priceDetails.originalPrice > 0.0) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              FancyAppDownloadDialog.show(
                                context,
                                title: "Unlock Premium Features",
                                message:
                                    "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                // cancelButtonText: "Maybe Later",
                                onCancel: () {
                                  print("User chose to skip download");
                                },
                              );

                              //   Get.to(
                              //   () => EditOfferScreen(
                              //     lobbyId: lobbyData.lobby.id,
                              //   ),
                              // );
                            },
                            child: const CustomOfferCard(
                              boldText: "Add Custom Offers",
                              normalText: "to attract more attendees to your lobby now.",
                            ),
                          ),
                          Space.h(height: 24),
                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  case "VISITOR_PAST":
                    return SizedBox.shrink();
                  default:
                    return OfferSwiper(lobbyId: lobbyData.lobby.id);
                }
              })(),

              (() {
                String combinedStatus = lobbyData.lobby.userStatus;

                switch (lobbyData.lobby.lobbyStatus) {
                  case "PAST":
                    combinedStatus = "${lobbyData.lobby.userStatus}_${lobbyData.lobby.lobbyStatus}";
                  case "UPCOMING":
                  case "CLOSED":
                    combinedStatus = "${lobbyData.lobby.userStatus}_${lobbyData.lobby.lobbyStatus}";

                  default: // ACTIVE
                }

                switch (combinedStatus) {
                  case "MEMBER":
                    return SizedBox.shrink();
                  case "ADMIN_PAST":
                    return SizedBox.shrink();
                  case "ADMIN":
                    if (lobbyData.lobby.priceDetails.originalPrice > 0.0) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // await Get.to(
                              //   () => AddTierPricingPage(
                              //     lobbyDetail: lobbyData,
                              //     lobbyId: lobbyData.lobby.id,
                              //   ),
                              // );

                              // ref
                              //     .read(
                              //       lobbyDetailsProvider(
                              //         lobbyData.lobby.id,
                              //       ).notifier,
                              //     )
                              //     .reset();
                              // await ref
                              //     .read(
                              //       lobbyDetailsProvider(
                              //         lobbyData.lobby.id,
                              //       ).notifier,
                              //     )
                              //     .fetchLobbyDetails(lobbyData.lobby.id);
                              FancyAppDownloadDialog.show(
                                context,
                                title: "Unlock Premium Features",
                                message:
                                    "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                // cancelButtonText: "Maybe Later",
                                onCancel: () {
                                  print("User chose to skip download");
                                },
                              );
                            },
                            child: const CustomOfferCard(boldText: "Add tier pricing ", normalText: "to your lobby"),
                          ),
                          Space.h(height: 24),
                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  default:
                    return SizedBox.shrink();
                }
              })(),

              DesignText(
                text: lobbyData.lobby.title,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                maxLines: 2,
                color: const Color(0xFF444444),
              ),
              // Space.h(height: 8.h),
              // DesignText(
              //   text: lobbyData.lobby.description,
              //   fontSize: 12,
              //   fontWeight: FontWeight.w300,
              //   maxLines: 10,
              //   color: const Color(0xFF323232),
              // ),
              Space.h(height: 16),

              Wrap(
                runSpacing: 12,
                direction: Axis.vertical,
                children: [
                  if (lobbyData.lobby.filter.otherFilterInfo.dateInfo != null) ...[
                    InfoItemWithTitle(
                      iconUrl: lobbyData.lobby.filter.otherFilterInfo.dateInfo!.iconUrl,
                      title: lobbyData.lobby.filter.otherFilterInfo.dateInfo!.title,
                      subTitle: lobbyData.lobby.filter.otherFilterInfo.dateInfo!.formattedDate ?? "",
                    ),
                    const Space.h(height: 4),
                  ],
                  if (lobbyData.lobby.filter.otherFilterInfo.dateRange != null) ...[
                    InfoItemWithTitle(
                      iconUrl: lobbyData.lobby.filter.otherFilterInfo.dateRange!.iconUrl,
                      title: lobbyData.lobby.filter.otherFilterInfo.dateRange!.title,
                      subTitle: lobbyData.lobby.filter.otherFilterInfo.dateRange!.formattedDateCompactView,
                    ),
                    const Space.h(height: 4),
                  ],

                  if (lobbyData.lobby.filter.otherFilterInfo.pickUp != null ||
                      lobbyData.lobby.filter.otherFilterInfo.destination != null) ...[
                    InfoItemWithTitle(
                      iconUrl: lobbyData.lobby.filter.otherFilterInfo.pickUp!.iconUrl,
                      title: lobbyData.lobby.filter.otherFilterInfo.pickUp?.title ?? "",
                      subTitle: lobbyData.lobby.filter.otherFilterInfo.pickUp!.locationResponse?.areaName ?? "",
                    ),
                    const Space.h(height: 4),
                    InfoItemWithTitle(
                      iconUrl: lobbyData.lobby.filter.otherFilterInfo.pickUp!.iconUrl,
                      title: lobbyData.lobby.filter.otherFilterInfo.destination?.title ?? "",
                      subTitle: lobbyData.lobby.filter.otherFilterInfo.destination!.locationResponse?.areaName ?? "",
                    ),
                    if (lobbyData.lobby.filter.otherFilterInfo.pickUp != null ||
                        lobbyData.lobby.filter.otherFilterInfo.destination != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 8,
                            shadowColor: const Color(0x143E79A1),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // constraints:
                              //     BoxConstraints(minWidth: 0.15.sw),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                              child: InfoItemWithIcon(
                                iconUrl: "googleMaps",
                                text: "Show directions",
                                fontSize: 10,
                                iconSize: 14,
                                iconColor: null,
                                onTap: () async {
                                  double latPickUp = 0.0;
                                  double lngPickUp = 0.0;
                                  double latDestination = 0.0;
                                  double lngDestination = 0.0;

                                  if (lobbyData.lobby.filter.otherFilterInfo.pickUp?.locationResponse != null ||
                                      lobbyData.lobby.filter.otherFilterInfo.destination?.locationResponse != null) {
                                    if (lobbyData.lobby.userStatus != "MEMBER" &&
                                        lobbyData.lobby.userStatus != "ADMIN") {
                                      latPickUp =
                                          (lobbyData
                                              .lobby
                                              .filter
                                              .otherFilterInfo
                                              .pickUp
                                              ?.locationResponse!
                                              .exactLocation
                                              .lat) ??
                                          0.0;
                                      lngPickUp =
                                          (lobbyData
                                              .lobby
                                              .filter
                                              .otherFilterInfo
                                              .pickUp
                                              ?.locationResponse!
                                              .exactLocation
                                              .lon) ??
                                          0.0;
                                      latDestination =
                                          (lobbyData
                                              .lobby
                                              .filter
                                              .otherFilterInfo
                                              .destination
                                              ?.locationResponse!
                                              .exactLocation
                                              .lat) ??
                                          0.0;
                                      lngDestination =
                                          (lobbyData
                                              .lobby
                                              .filter
                                              .otherFilterInfo
                                              .destination
                                              ?.locationResponse!
                                              .exactLocation
                                              .lon) ??
                                          0.0;
                                    } else {
                                      latPickUp =
                                          (lobbyData
                                              .lobby
                                              .filter
                                              .otherFilterInfo
                                              .pickUp
                                              ?.locationResponse!
                                              .exactLocation
                                              .lat) ??
                                          0.0;
                                      lngPickUp =
                                          (lobbyData
                                              .lobby
                                              .filter
                                              .otherFilterInfo
                                              .pickUp
                                              ?.locationResponse!
                                              .exactLocation
                                              .lon) ??
                                          0.0;
                                      latDestination =
                                          (lobbyData
                                              .lobby
                                              .filter
                                              .otherFilterInfo
                                              .destination
                                              ?.locationResponse!
                                              .exactLocation
                                              .lat) ??
                                          0.0;
                                      lngDestination =
                                          (lobbyData
                                              .lobby
                                              .filter
                                              .otherFilterInfo
                                              .destination
                                              ?.locationResponse!
                                              .exactLocation
                                              .lon) ??
                                          0.0;
                                    }
                                  }

                                  // Only proceed if we have valid coordinates
                                  if (latPickUp != 0.0 ||
                                      lngPickUp != 0.0 ||
                                      latDestination != 0.0 ||
                                      lngDestination != 0.0) {
                                    Uri? mapsUri;
                                    bool launched = false;

                                    kLogger.trace(
                                      "latP : $latPickUp \n lngP : $lngPickUp \n latD : $latDestination \n lngD : $lngDestination",
                                    );

                                    // Check if running on web
                                    if (kIsWeb) {
                                      // For web, always use Google Maps web interface
                                      mapsUri = Uri.parse(
                                        'https://www.google.com/maps/dir/?api=1&origin=$latPickUp,$lngPickUp&destination=$latDestination,$lngDestination',
                                      );

                                      try {
                                        await launchUrl(
                                          mapsUri,
                                          mode: LaunchMode.platformDefault, // Use platformDefault for web
                                          webOnlyWindowName: '_blank', // Open in new tab
                                        );
                                        launched = true;
                                      } catch (e) {
                                        kLogger.error('Error launching directions URL on web: $e');
                                      }
                                    } else {
                                      // Mobile platform handling
                                      if (Platform.isAndroid) {
                                        // Try Google Maps app first
                                        mapsUri = Uri.parse(
                                          'https://www.google.com/maps/dir/?api=1&origin=$latPickUp,$lngPickUp&destination=$latDestination,$lngDestination',
                                        );
                                        if (await canLaunchUrl(mapsUri)) {
                                          await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                          launched = true;
                                        }
                                      } else if (Platform.isIOS) {
                                        // Try Google Maps on iOS first
                                        mapsUri = Uri.parse(
                                          'comgooglemaps://?saddr=$latPickUp,$lngPickUp&daddr=$latDestination,$lngDestination&directionsmode=driving',
                                        );
                                        if (await canLaunchUrl(mapsUri)) {
                                          await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                          launched = true;
                                        } else {
                                          // Fall back to Apple Maps
                                          mapsUri = Uri.parse(
                                            'https://maps.apple.com/?saddr=$latPickUp,$lngPickUp&daddr=$latDestination,$lngDestination&dirflg=d',
                                          );
                                          if (await canLaunchUrl(mapsUri)) {
                                            await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                            launched = true;
                                          }
                                        }
                                      }

                                      // If none of the above worked, fall back to web browser
                                      if (!launched) {
                                        mapsUri = Uri.parse(
                                          'https://www.google.com/maps/dir/?api=1&origin=$latPickUp,$lngPickUp&destination=$latDestination,$lngDestination',
                                        );
                                        try {
                                          await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                        } catch (e) {
                                          kLogger.error('Error launching URL: $e');
                                        }
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          // Space.w(width: 8.w),
                          if (lobbyData.lobby.filter.otherFilterInfo.locationInfo != null &&
                              (lobbyData.lobby.filter.otherFilterInfo.locationInfo!.hideLocation) &&
                              (lobbyData.lobby.userStatus != "MEMBER" || lobbyData.lobby.userStatus != "ADMIN"))
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text("Approximate Location Shown 🌍"),
                                      content: const Text(
                                        "The admin has chosen to hide the exact location. You're seeing an approximate location within a 1 km radius. Once you join the lobby, the exact location will be visible.",
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text("Got it!"),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Dismiss the dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.info_outline, size: 18),
                            ),
                        ],
                      ),
                    ],
                    const Space.h(height: 4),
                  ],
                ],
              ),
              // Space.h(height: 8.h),
              if (lobbyData.lobby.filter.otherFilterInfo.locationInfo != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          double lat = 0.0;
                          double lng = 0.0;

                          if (lobbyData.lobby.filter.otherFilterInfo.locationInfo != null &&
                              lobbyData.lobby.filter.otherFilterInfo.locationInfo!.locationResponses.isNotEmpty) {
                            if ((lobbyData.lobby.filter.otherFilterInfo.locationInfo!.hideLocation) &&
                                (lobbyData.lobby.userStatus != "MEMBER" && lobbyData.lobby.userStatus != "ADMIN")) {
                              lat =
                                  lobbyData
                                      .lobby
                                      .filter
                                      .otherFilterInfo
                                      .locationInfo
                                      ?.locationResponses
                                      .first
                                      .approxLocation
                                      ?.lat ??
                                  0.0;
                              lng =
                                  lobbyData
                                      .lobby
                                      .filter
                                      .otherFilterInfo
                                      .locationInfo
                                      ?.locationResponses
                                      .first
                                      .approxLocation
                                      ?.lon ??
                                  0.0;
                            } else {
                              lat =
                                  lobbyData
                                      .lobby
                                      .filter
                                      .otherFilterInfo
                                      .locationInfo
                                      ?.locationResponses
                                      .first
                                      .exactLocation
                                      ?.lat ??
                                  0.0;
                              lng =
                                  lobbyData
                                      .lobby
                                      .filter
                                      .otherFilterInfo
                                      .locationInfo
                                      ?.locationResponses
                                      .first
                                      .exactLocation
                                      ?.lon ??
                                  0.0;
                            }
                          }

                          // Only proceed if we have valid coordinates
                          if (lat != 0.0 || lng != 0.0) {
                            Uri? mapsUri;
                            bool launched = false;

                            kLogger.trace("lat : $lat \n lng : $lng");

                            // Check if running on web
                            if (kIsWeb) {
                              // For web, always use Google Maps web interface
                              mapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

                              try {
                                await launchUrl(
                                  mapsUri,
                                  mode: LaunchMode.platformDefault, // Use platformDefault for web
                                  webOnlyWindowName: '_blank', // Open in new tab
                                );
                                launched = true;
                              } catch (e) {
                                kLogger.error('Error launching maps URL on web: $e');
                              }
                            } else {
                              // Mobile platform handling (your existing code)
                              if (Platform.isAndroid) {
                                // Try Android's native maps app first
                                mapsUri = Uri.parse('http://maps.google.com/maps?z=12&t=m&q=$lat,$lng');
                                if (await canLaunchUrl(mapsUri)) {
                                  await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                  launched = true;
                                }
                              } else if (Platform.isIOS) {
                                // Try Google Maps on iOS first
                                mapsUri = Uri.parse('comgooglemaps://?center=$lat,$lng&zoom=12&q=$lat,$lng');
                                if (await canLaunchUrl(mapsUri)) {
                                  await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                  launched = true;
                                } else {
                                  // Fall back to Apple Maps
                                  mapsUri = Uri.parse(
                                    'https://maps.apple.com/?q=${Uri.encodeFull("Location")}&sll=$lat,$lng&z=12',
                                  );
                                  if (await canLaunchUrl(mapsUri)) {
                                    await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                    launched = true;
                                  }
                                }
                              }

                              // If none of the above worked, fall back to web browser
                              if (!launched) {
                                mapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
                                try {
                                  await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                } catch (e) {
                                  kLogger.error('Error launching URL: $e');
                                }
                              }
                            }
                          }
                        },
                        child: DesignText(
                          text:
                              "📍 ${((lobbyData.lobby.filter.otherFilterInfo.locationInfo!.hideLocation) && (lobbyData.lobby.filter.otherFilterInfo.locationInfo!.locationResponses.firstOrNull?.fuzzyAddress.isNotEmpty ?? false) && (lobbyData.lobby.userStatus != "MEMBER") && (lobbyData.lobby.userStatus != "ADMIN"))
                                  ? lobbyData.lobby.filter.otherFilterInfo.locationInfo!.locationResponses.firstOrNull?.fuzzyAddress
                                  : (lobbyData.lobby.filter.otherFilterInfo.locationInfo?.googleSearchResponses?.isNotEmpty == true)
                                  ? lobbyData.lobby.filter.otherFilterInfo.locationInfo!.googleSearchResponses.first.description
                                  : 'No location details available'}",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF3E79A1),
                          maxLines: 10,
                        ),
                      ),
                    ),
                    // Space.w(width: 8.w),
                    if (lobbyData.lobby.filter.otherFilterInfo.locationInfo != null &&
                        (lobbyData.lobby.filter.otherFilterInfo.locationInfo!.hideLocation) &&
                        (lobbyData.lobby.userStatus != "MEMBER" || lobbyData.lobby.userStatus != "ADMIN"))
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text("Approximate Location Shown 🌍"),
                                content: const Text(
                                  "The admin has chosen to hide the exact location. You're seeing an approximate location within a 1 km radius. Once you join the lobby, the exact location will be visible.",
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("Got it!"),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Dismiss the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.info_outline, size: 20),
                      ),
                  ],
                ),
              ],

              if (lobbyData.lobby.filter.otherFilterInfo.multipleLocations != null) ...[
                Space.h(height: 16),
                DesignText(
                  text: lobbyData.lobby.filter.otherFilterInfo.multipleLocations?.title ?? 'Multiple Location',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF444444),
                  maxLines: 10,
                ),
                Space.h(height: 8),
                _buildLocationSection(lobby: lobbyData.lobby),
              ],

              Space.h(height: 8),
              if ((lobbyData.lobby.lobbyStatus == 'PAST') &&
                  lobbyData.lobby.userStatus == 'MEMBER' &&
                  !lobbyData.lobby.ratingGiven) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(color: const Color(0x143E79A1), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DesignText(
                          text: "Tell us about your experience, so we can improve further in future.",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          maxLines: 3,
                          color: const Color(0xFF444444),
                        ),
                      ),
                      Space.w(width: 24),
                      OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => FeedbackWidget(
                              onSubmit: (emoji, rating) {
                                print("Selected Emoji: $emoji");
                                print("Selected Rating: $rating");
                              },
                              lobbyId: lobbyData.lobby.id,
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFEC4B5D)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        ),
                        child: DesignText(
                          text: "Feedback",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFEC4B5D),
                        ),
                      ),
                    ],
                  ),
                ),
                Space.h(height: 24),
              ],

              RichTextDisplay(
                controller: TextEditingController(text: lobbyData.lobby.description),
                hintText: '',
                // lobbyId: lobbyData.lobby.id,
                maxHeight: 10 * Get.height,
                scrollable: false,
              ),

              // Space.h(height: 8.h),
              ScrollableInfoCards(
                cards: [
                  InfoCard(
                    icon: Icons.payment,
                    title: (lobbyData.lobby.priceDetails.originalPrice > 0.0) ? "Refund Policies :" : "Pricing ",
                    subtitle: (lobbyData.lobby.priceDetails.isRefundAllowed)
                        ? "Up to 2 days before the lobby."
                        : (lobbyData.lobby.priceDetails.originalPrice > 0.0)
                        ? "refund not allowed for this lobby"
                        : "This Lobby is Free",
                  ),
                  InfoCard(
                    icon: Icons.groups,
                    title: "Lobby Size",
                    subtitle: "Maximum: ${lobbyData.lobby.totalMembers}",
                  ),
                  if (lobbyData.lobby.filter.otherFilterInfo.range != null)
                    InfoCard(
                      icon: Icons.cake,
                      title: lobbyData.lobby.filter.otherFilterInfo.range?.title ?? "Age Limit",
                      subtitle:
                          "${lobbyData.lobby.filter.otherFilterInfo.range?.min ?? 0} to ${lobbyData.lobby.filter.otherFilterInfo.range?.max ?? 0} ",
                    ),
                ],
              ),

              if (lobbyData.lobby.userStatus != "MEMBER" || (lobbyData.lobby.houseDetail != null)) ...[
                Space.h(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      // Wrap the GestureDetector in Expanded
                      child: GestureDetector(
                        onTap: () async {
                          FancyAppDownloadDialog.show(
                            context,
                            title: "Unlock Premium Features",
                            message:
                                "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                            appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                            playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                            // cancelButtonText: "Maybe Later",
                            onCancel: () {
                              print("User chose to skip download");
                            },
                          );

                          // if (lobbyData.lobby.houseDetail !=
                          //     null) {
                          //   if (lobbyData
                          //           .lobby
                          //           .houseDetail!
                          //           .houseId !=
                          //       "") {
                          //     Get.to(
                          //       () => HouseDetailPage(
                          //         houseId:
                          //             lobbyData
                          //                 .lobby
                          //                 .houseDetail!
                          //                 .houseId,
                          //       ),
                          //     );
                          //   }
                          // } else {
                          //   if (lobbyData
                          //           .lobby
                          //           .adminSummary
                          //           .userId !=
                          //       "") {
                          //     final uid =
                          //         await GetStorage().read(
                          //           "userUID",
                          //         ) ??
                          //         '';
                          //     Get.to(
                          //       () =>
                          //           (uid ==
                          //                   lobbyData
                          //                       .lobby
                          //                       .adminSummary
                          //                       .userId)
                          //               ? ProfileDetailsFollowedScreen()
                          //               : ProfileDetailsScreen(
                          //                 userId:
                          //                     lobbyData
                          //                         .lobby
                          //                         .adminSummary
                          //                         .userId,
                          //               ),
                          //     );
                          //   }
                          // }
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: const Color(0xFFEAEFF2),
                              child: ClipOval(
                                child: Image.network(
                                  (lobbyData.lobby.houseDetail != null)
                                      ? lobbyData.lobby.houseDetail!.profilePhoto
                                      : lobbyData.lobby.adminSummary.profilePictureUrl,
                                  fit: BoxFit.cover,
                                  width: 32,
                                  height: 32,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.person, size: 16);
                                  },
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              // Wrap RichText with Flexible
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Hosted by ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                        color: const Color(0xFF444444),
                                      ),
                                    ),
                                    TextSpan(
                                      text: (lobbyData.lobby.houseDetail != null)
                                          ? lobbyData.lobby.houseDetail!.name
                                          : lobbyData.lobby.adminSummary.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        color: const Color(0xFF444444),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (lobbyData.lobby.userStatus == "ADMIN")
                      SizedBox(
                        width: 124,
                        child: DesignButton(
                          padding: EdgeInsets.all(12),
                          onPress: () {
                            //   Get.to(
                            //   () => CoHostSelectionView(
                            //     lobbyDetails: lobbyData,
                            //   ),
                            // );
                            FancyAppDownloadDialog.show(
                              context,
                              title: "Unlock Premium Features",
                              message:
                                  "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                              appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                              playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                              // cancelButtonText: "Maybe Later",
                              onCancel: () {
                                print("User chose to skip download");
                              },
                            );
                          },
                          bgColor: const Color(0x143E79A1),
                          child: Row(
                            children: [
                              DesignIcon.icon(
                                icon: Icons.person_add_outlined,
                                color: const Color(0xFF3E79A1),
                                size: 16,
                              ),
                              Space.w(width: 4),
                              DesignText(
                                text: "Invite Co-host",
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF3E79A1),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
              Space.h(height: 24),
              if (lobbyData.lobby.setting.showMembers) ...[
                if (userInfos.isEmpty)
                  DesignText(
                    text: "Attendee",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF323232),
                  ),
                if (lobbyData.lobby.setting.showLobbyMembers) ...[
                  lobbyData.lobby.userStatus == "MEMBER"
                      ? SizedBox(
                          height: 70,
                          child: Row(
                            children: [
                              // Host section - Taking up 40% of space
                              Expanded(
                                flex: 40,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DesignText(
                                      text: "Host",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF323232),
                                    ),
                                    Space.h(height: 4),
                                    GestureDetector(
                                      onTap: () async {
                                        FancyAppDownloadDialog.show(
                                          context,
                                          title: "Unlock Premium Features",
                                          message:
                                              "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                          appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                          playStoreUrl:
                                              "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                          // cancelButtonText: "Maybe Later",
                                          onCancel: () {
                                            print("User chose to skip download");
                                          },
                                        );

                                        // if (lobbyData
                                        //         .lobby
                                        //         .houseDetail !=
                                        //     null) {
                                        //   if (lobbyData
                                        //           .lobby
                                        //           .houseDetail!
                                        //           .houseId !=
                                        //       "") {
                                        //     Get.to(
                                        //       () => HouseDetailPage(
                                        //         houseId:
                                        //             lobbyData
                                        //                 .lobby
                                        //                 .houseDetail!
                                        //                 .houseId,
                                        //       ),
                                        //     );
                                        //   }
                                        // } else {
                                        //   if (lobbyData
                                        //           .lobby
                                        //           .adminSummary
                                        //           .userId !=
                                        //       "") {
                                        //     final uid =
                                        //         await GetStorage().read(
                                        //           "userUID",
                                        //         ) ??
                                        //         '';
                                        //     Get.to(
                                        //       () =>
                                        //           (uid ==
                                        //                   lobbyData
                                        //                       .lobby
                                        //                       .adminSummary
                                        //                       .userId)
                                        //               ? ProfileDetailsFollowedScreen()
                                        //               : ProfileDetailsScreen(
                                        //                 userId:
                                        //                     lobbyData
                                        //                         .lobby
                                        //                         .adminSummary
                                        //                         .userId,
                                        //                 // isFriend: widget.lobbyDetail.lobby
                                        //                 //     .adminSummary.isFriend,
                                        //                 // isRequestSent: widget
                                        //                 //     .lobbyDetail
                                        //                 //     .lobby
                                        //                 //     .adminSummary
                                        //                 //     .requestSent,
                                        //                 // isRequestReceived: widget
                                        //                 //     .lobbyDetail
                                        //                 //     .lobby
                                        //                 //     .adminSummary
                                        //                 //     .requestReceived,
                                        //               ),
                                        //     );
                                        //   }
                                        // }
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: const Color(0xFFEAEFF2),
                                            child: ClipOval(
                                              child: Image.network(
                                                (lobbyData.lobby.houseDetail != null)
                                                    ? lobbyData.lobby.houseDetail!.profilePhoto
                                                    : lobbyData.lobby.adminSummary.profilePictureUrl,
                                                fit: BoxFit.cover,
                                                width: 40,
                                                height: 40,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Icon(Icons.person, size: 18);
                                                },
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 24,
                                                      height: 24,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        value: loadingProgress.expectedTotalBytes != null
                                                            ? loadingProgress.cumulativeBytesLoaded /
                                                                  loadingProgress.expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Space.w(width: 16),
                                          Flexible(
                                            // Wrapped in Flexible to handle overflow
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                DesignText(
                                                  text: (lobbyData.lobby.houseDetail != null)
                                                      ? lobbyData.lobby.houseDetail!.name
                                                      : lobbyData.lobby.adminSummary.userName,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xFF323232),
                                                  maxLines: 1,
                                                ),
                                                Space.h(height: 2),
                                                DesignText(
                                                  text:
                                                      "Joined | ${DateFormat('MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(lobbyData.lobby.createdDate))}",
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,
                                                  maxLines: 2,
                                                  color: const Color(0xFF444444),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Vertical Divider - Taking up 20% of space
                              const Expanded(
                                flex: 20,
                                child: Center(child: VerticalDivider(color: Color(0xFFBBBCBD), thickness: 1)),
                              ),

                              // Attendee section - Taking up 40% of space
                              Expanded(
                                flex: 40,
                                child: GestureDetector(
                                  onTap: () {
                                    FancyAppDownloadDialog.show(
                                      context,
                                      title: "Unlock Premium Features",
                                      message:
                                          "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                      appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                      playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                      // cancelButtonText: "Maybe Later",
                                      onCancel: () {
                                        print("User chose to skip download");
                                      },
                                    );
                                    // if (lobbyData.lobby.setting?.showLobbyMembers !=
                                    //         false ||
                                    //     lobbyData.lobby.userStatus == "ADMIN") {
                                    //   Get.to(
                                    //     () => AttendeeScreen(lobbyDetails: lobbyData),
                                    //   );
                                    // } else {
                                    //   Fluttertoast.showToast(
                                    //     msg:
                                    //         "The lobby host has disabled attendee view",
                                    //   );
                                    // }
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            DesignText(
                                              text: "Attendee ",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF323232),
                                            ),
                                            DesignText(
                                              text: "(${lobbyData.lobby.currentMembers})",
                                              fontSize: 8,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF444444),
                                            ),
                                          ],
                                        ),
                                        Space.h(height: 4),
                                        Expanded(
                                          child: SizedBox(
                                            width: userInfos.length >= 4
                                                ? 0.3 * sw
                                                : userInfos.length == 3
                                                ? 0.24
                                                : userInfos.length == 2
                                                ? 0.18 * sw
                                                : userInfos.length == 1
                                                ? 0.12 * sw
                                                : 0.1 * sw,
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              alignment: AlignmentDirectional.center,
                                              children: List.generate(
                                                remainingCount > 0 ? displayAvatars.length + 1 : displayAvatars.length,
                                                (index) {
                                                  print("remainingCount `$remainingCount");
                                                  final positionIndex = displayAvatars.length - 1 - index;

                                                  if (index == displayAvatars.length && remainingCount > 0) {
                                                    return Positioned(
                                                      left: index * 20,
                                                      child: CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor: Colors.teal[200],
                                                        child: Text(
                                                          '+$remainingCount',
                                                          style: const TextStyle(color: Colors.white, fontSize: 16),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  final url = displayAvatars[index].profilePictureUrl;
                                                  return Positioned(
                                                    left: index * 20,
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: avatarColors[index],
                                                      child: url!.isEmpty
                                                          ? const Icon(Icons.person, color: Colors.white)
                                                          : ClipRRect(
                                                              borderRadius: BorderRadius.circular(20),
                                                              child: Image.network(
                                                                url,
                                                                width: 40,
                                                                height: 40,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 56,
                          child: Row(
                            mainAxisAlignment: (userInfos.length == 1)
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.spaceAround, // This will add space around the elements
                            children: [
                              // Combined stack and column in a Row
                              userInfos.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        FancyAppDownloadDialog.show(
                                          context,
                                          title: "Unlock Premium Features",
                                          message:
                                              "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                          appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                          playStoreUrl:
                                              "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                          // cancelButtonText: "Maybe Later",
                                          onCancel: () {
                                            print("User chose to skip download");
                                          },
                                        );
                                        // if (lobbyData.lobby.setting?.showLobbyMembers !=
                                        //         false ||
                                        //     lobbyData.lobby.userStatus == "ADMIN") {
                                        //   Get.to(
                                        //     () =>
                                        //         AttendeeScreen(lobbyDetails: lobbyData),
                                        //   );
                                        // } else {
                                        //   Fluttertoast.showToast(
                                        //     msg:
                                        //         "The lobby host has disabled attendee view",
                                        //   );
                                        // }
                                      },
                                      child: Row(
                                        children: [
                                          // Stack of avatars
                                          SizedBox(
                                            width: userInfos.length >= 4
                                                ? 0.3 * sw
                                                : userInfos.length == 3
                                                ? 0.24 * sw
                                                : userInfos.length == 2
                                                ? 0.18 * sw
                                                : userInfos.length == 1
                                                ? 0.12 * sw
                                                : 0.1 * sw, // Adjust width as needed
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              alignment: AlignmentDirectional.centerEnd,
                                              children: List.generate(
                                                remainingCount > 0 ? displayAvatars.length + 1 : displayAvatars.length,
                                                (index) {
                                                  final positionIndex = displayAvatars.length - 1 - index;

                                                  // Show the '+remainingCount' for more avatars
                                                  if (index == displayAvatars.length && remainingCount > 0) {
                                                    return Positioned(
                                                      left: index * 24,
                                                      child: CircleAvatar(
                                                        radius: 24,
                                                        backgroundColor: Colors.teal[200],
                                                        child: Text(
                                                          '+$remainingCount',
                                                          style: const TextStyle(color: Colors.white, fontSize: 16),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  final url = displayAvatars[index].profilePictureUrl;
                                                  // Regular avatar logic
                                                  return Positioned(
                                                    left: index * 24,
                                                    child: CircleAvatar(
                                                      radius: 24,
                                                      backgroundColor: avatarColors[index],
                                                      child: url == null || url.isEmpty
                                                          ? const Icon(Icons.person, color: Colors.white)
                                                          : ClipRRect(
                                                              borderRadius: BorderRadius.circular(24),
                                                              child: Image.network(
                                                                url,
                                                                width: 48,
                                                                height: 48,
                                                                fit: BoxFit.cover,
                                                                errorBuilder: (context, error, stackTrace) {
                                                                  return const Icon(Icons.person, color: Colors.white);
                                                                },
                                                                loadingBuilder: (context, child, loadingProgress) {
                                                                  if (loadingProgress == null) {
                                                                    return child;
                                                                  }
                                                                  return const Center(
                                                                    child: CircularProgressIndicator(
                                                                      color: Colors.white,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: 32),

                                          // Column for the text
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              DesignText(
                                                text: "Attendee",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF323232),
                                              ),
                                              SizedBox(height: 4),
                                              DesignText(
                                                text:
                                                    "${lobbyData.lobby.currentMembers} ${lobbyData.lobby.currentMembers == 1 ? "person is" : "people are"} joining this lobby ",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF444444),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : DesignText(
                                      text: "No Attendees",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF444444),
                                    ),
                              if (userInfos.length == 1 &&
                                  (((lobbyData.lobby.lobbyStatus != 'PAST') &&
                                          (lobbyData.lobby.lobbyStatus != 'CLOSED')) ||
                                      (lobbyData.lobby.userStatus == 'MEMBER'))) ...[
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    FancyAppDownloadDialog.show(
                                      context,
                                      title: "Unlock Premium Features",
                                      message:
                                          "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                      appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                      playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                      // cancelButtonText: "Maybe Later",
                                      onCancel: () {
                                        print("User chose to skip download");
                                      },
                                    );
                                    //   Get.to(
                                    //   () => AttendeeScreen(lobbyDetails: lobbyData),
                                    // );
                                  },
                                  child: DesignText(
                                    text: "View All",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF3E79A1),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                  Space.h(height: 34),
                ] else if (lobbyData.lobby.userStatus == 'MEMBER') ...[
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        // Host section - Taking up 40% of space
                        Expanded(
                          flex: 40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DesignText(
                                text: "Host",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF323232),
                              ),
                              Space.h(height: 4),
                              GestureDetector(
                                onTap: () async {
                                  FancyAppDownloadDialog.show(
                                    context,
                                    title: "Unlock Premium Features",
                                    message:
                                        "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                    appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                    playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                    // cancelButtonText: "Maybe Later",
                                    onCancel: () {
                                      print("User chose to skip download");
                                    },
                                  );

                                  // if (lobbyData
                                  //         .lobby
                                  //         .houseDetail !=
                                  //     null) {
                                  //   if (lobbyData
                                  //           .lobby
                                  //           .houseDetail!
                                  //           .houseId !=
                                  //       "") {
                                  //     Get.to(
                                  //       () => HouseDetailPage(
                                  //         houseId:
                                  //             lobbyData
                                  //                 .lobby
                                  //                 .houseDetail!
                                  //                 .houseId,
                                  //       ),
                                  //     );
                                  //   }
                                  // } else {
                                  //   if (lobbyData
                                  //           .lobby
                                  //           .adminSummary
                                  //           .userId !=
                                  //       "") {
                                  //     final uid =
                                  //         await GetStorage().read(
                                  //           "userUID",
                                  //         ) ??
                                  //         '';
                                  //     Get.to(
                                  //       () =>
                                  //           (uid ==
                                  //                   lobbyData
                                  //                       .lobby
                                  //                       .adminSummary
                                  //                       .userId)
                                  //               ? ProfileDetailsFollowedScreen()
                                  //               : ProfileDetailsScreen(
                                  //                 userId:
                                  //                     lobbyData
                                  //                         .lobby
                                  //                         .adminSummary
                                  //                         .userId,
                                  //                 // isFriend: widget.lobbyDetail.lobby
                                  //                 //     .adminSummary.isFriend,
                                  //                 // isRequestSent: widget
                                  //                 //     .lobbyDetail
                                  //                 //     .lobby
                                  //                 //     .adminSummary
                                  //                 //     .requestSent,
                                  //                 // isRequestReceived: widget
                                  //                 //     .lobbyDetail
                                  //                 //     .lobby
                                  //                 //     .adminSummary
                                  //                 //     .requestReceived,
                                  //               ),
                                  //     );
                                  //   }
                                  // }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: const Color(0xFFEAEFF2),
                                      child: ClipOval(
                                        child: Image.network(
                                          (lobbyData.lobby.houseDetail != null)
                                              ? lobbyData.lobby.houseDetail!.profilePhoto
                                              : lobbyData.lobby.adminSummary.profilePictureUrl,
                                          fit: BoxFit.cover,
                                          width: 40,
                                          height: 40,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Icon(Icons.person, size: 18);
                                          },
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                            loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Space.w(width: 16),
                                    Flexible(
                                      // Wrapped in Flexible to handle overflow
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          DesignText(
                                            text: (lobbyData.lobby.houseDetail != null)
                                                ? lobbyData.lobby.houseDetail!.name
                                                : lobbyData.lobby.adminSummary.userName,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF323232),
                                            maxLines: 1,
                                          ),
                                          Space.h(height: 2),
                                          DesignText(
                                            text:
                                                "Joined | ${DateFormat('MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(lobbyData.lobby.createdDate))}",
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400,
                                            maxLines: 2,
                                            color: const Color(0xFF444444),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Vertical Divider - Taking up 20% of space
                        const Expanded(
                          flex: 20,
                          child: Center(child: VerticalDivider(color: Color(0xFFBBBCBD), thickness: 1)),
                        ),

                        // Attendee section - Taking up 40% of space
                        Expanded(
                          flex: 40,
                          child: GestureDetector(
                            onTap: () {
                              FancyAppDownloadDialog.show(
                                context,
                                title: "Unlock Premium Features",
                                message:
                                    "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                // cancelButtonText: "Maybe Later",
                                onCancel: () {
                                  print("User chose to skip download");
                                },
                              );
                              // if (lobbyData.lobby.setting?.showLobbyMembers !=
                              //         false ||
                              //     lobbyData.lobby.userStatus == "ADMIN") {
                              //   Get.to(
                              //     () => AttendeeScreen(lobbyDetails: lobbyData),
                              //   );
                              // } else {
                              //   Fluttertoast.showToast(
                              //     msg:
                              //         "The lobby host has disabled attendee view",
                              //   );
                              // }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      DesignText(
                                        text: "Attendee ",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF323232),
                                      ),
                                      DesignText(
                                        text: "(${lobbyData.lobby.currentMembers})",
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF444444),
                                      ),
                                    ],
                                  ),
                                  Space.h(height: 4),
                                  Expanded(
                                    child: SizedBox(
                                      width: userInfos.length >= 4
                                          ? 0.3 * sw
                                          : userInfos.length == 3
                                          ? 0.24
                                          : userInfos.length == 2
                                          ? 0.18 * sw
                                          : userInfos.length == 1
                                          ? 0.12 * sw
                                          : 0.1 * sw,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: AlignmentDirectional.center,
                                        children: List.generate(
                                          remainingCount > 0 ? displayAvatars.length + 1 : displayAvatars.length,
                                          (index) {
                                            print("remainingCount `$remainingCount");
                                            final positionIndex = displayAvatars.length - 1 - index;

                                            if (index == displayAvatars.length && remainingCount > 0) {
                                              return Positioned(
                                                left: index * 20,
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.teal[200],
                                                  child: Text(
                                                    '+$remainingCount',
                                                    style: const TextStyle(color: Colors.white, fontSize: 16),
                                                  ),
                                                ),
                                              );
                                            }
                                            final url = displayAvatars[index].profilePictureUrl;
                                            return Positioned(
                                              left: index * 20,
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: avatarColors[index],
                                                child: url!.isEmpty
                                                    ? const Icon(Icons.person, color: Colors.white)
                                                    : ClipRRect(
                                                        borderRadius: BorderRadius.circular(20),
                                                        child: Image.network(
                                                          url,
                                                          width: 40,
                                                          height: 40,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Space.h(height: 34),
                ],
              ],

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(lobbyData.lobby.filter.filterInfoList.length, (index) {
                      final item = lobbyData.lobby.filter.filterInfoList[index];

                      // Format the options list as a string
                      String formattedOptions = item.options.take(3).join(', ');
                      if (item.options.length > 3) {
                        formattedOptions += '...';
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildDetailCard(
                            context,
                            icon: item.iconUrl ?? "",
                            title: item.title,
                            subtitle: formattedOptions,
                          ),
                          if (index != (lobbyData.lobby.filter.filterInfoList.length - 1))
                            Divider(color: Colors.grey.shade300, height: 2.0),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              Space.h(height: 34),
              Row(
                children: [
                  if (lobbyData.lobby.content != null)
                    DesignText(
                      text: lobbyData.lobby.content?.title ?? "Guidelines",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                ],
              ),
              if (lobbyData.lobby.content != null) ...[
                Space.h(height: 16),
                NewLobbyContentSection(content: lobbyData.lobby.content!, height: 356),
              ],
              Space.h(height: 16),
              ResponsiveAppDownloadCard(
                appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                onClose: () {
                  FancyAppDownloadDialog.show(
                    context,
                    title: "Unlock Premium Features",
                    message: "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                    appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                    playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                    // cancelButtonText: "Maybe Later",
                    onCancel: () {
                      print("User chose to skip download");
                    },
                  );
                  // Get.to(()=> AppLandingPage());
                },
              ),
              // Row(
              //   children: [
              //     if (lobbyData.lobby.content == null &&
              //         lobbyData.lobby.userStatus == "ADMIN")
              //       DesignText(
              //         text: lobbyData.lobby.content?.title ?? "Add Guidelines",
              //         fontSize: 18,
              //         fontWeight: FontWeight.w600,
              //       )
              //     else if (lobbyData.lobby.content != null)
              //       DesignText(
              //         text: lobbyData.lobby.content?.title ?? "Guidelines",
              //         fontSize: 18,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     const Spacer(),
              //     if (lobbyData.lobby.userStatus == "ADMIN")
              //       InkWell(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder:
              //                   (_) => NewMarkdownEditorPage(
              //                     lobbyId: lobbyData.lobby.id,
              //                     initialTitle:
              //                         lobbyData.lobby.content?.title ?? '',
              //                     initialBody:
              //                         lobbyData.lobby.content?.body ?? '',
              //                     isHost: true, // set false for viewers
              //                   ),
              //             ),
              //           );
              //         },
              //         child: DesignText(
              //           text:
              //               (lobbyData.lobby.content != null) ? "Edit" : "Add",
              //           fontSize: 12,
              //           fontWeight: FontWeight.w500,
              //           color: const Color(0xFF3E79A1),
              //         ),
              //       ),
              //   ],
              // ),
              // if (lobbyData.lobby.content != null) ...[
              //   Space.h(height: 16),
              //   NewLobbyContentSection(content: lobbyData.lobby.content!),
              // ],

              // Space.h(height: 16),
              // FeaturedConversation(
              //   lobby: lobbyData.lobby,
              //   lobbyDetail: lobbyData,
              // ),

              // Space.h(height: 16),
            ],
          ),
        ),
        if (isAuth) const LobbiesList(lobbyType: LobbyType.recommendations, title: "Recommended Lobbies"),
        Space.h(height: 34),
        // LobbyHousesList(lobbyId: lobbyData.lobby.id),
        // Space.h(height: 16.h),
      ],
    );
  }

  Widget desktopLayout({required LobbyDetails lobbyData, required double sw, required double sh}) {
    final isAuth = ref.watch(isAuthProvider(lobbyData.lobby.id));
    List<UserSummary> userInfos = <UserSummary>[];
    List<UserSummary> displayAvatars = <UserSummary>[];
    int remainingCount = 0;
    if (lobbyData != null) {
      isSaved = lobbyData.lobby.isSaved;
      userInfos = lobbyData.lobby.userSummaries ?? [];

      displayAvatars = userInfos.take(3).toList();
      remainingCount = lobbyData.lobby.currentMembers - displayAvatars.length;
      print(lobbyData.lobby.userStatus);
    }
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DesignText(
            text: lobbyData.lobby.title,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            maxLines: 2,
            color: const Color(0xFF444444),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // Wrap the GestureDetector in Expanded
                child: GestureDetector(
                  onTap: () async {
                    FancyAppDownloadDialog.show(
                      context,
                      title: "Unlock Premium Features",
                      message:
                          "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                      appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                      playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                      // cancelButtonText: "Maybe Later",
                      onCancel: () {
                        print("User chose to skip download");
                      },
                    );

                    // if (lobbyData.lobby.houseDetail !=
                    //     null) {
                    //   if (lobbyData
                    //           .lobby
                    //           .houseDetail!
                    //           .houseId !=
                    //       "") {
                    //     Get.to(
                    //       () => HouseDetailPage(
                    //         houseId:
                    //             lobbyData
                    //                 .lobby
                    //                 .houseDetail!
                    //                 .houseId,
                    //       ),
                    //     );
                    //   }
                    // } else {
                    //   if (lobbyData
                    //           .lobby
                    //           .adminSummary
                    //           .userId !=
                    //       "") {
                    //     final uid =
                    //         await GetStorage().read(
                    //           "userUID",
                    //         ) ??
                    //         '';
                    //     Get.to(
                    //       () =>
                    //           (uid ==
                    //                   lobbyData
                    //                       .lobby
                    //                       .adminSummary
                    //                       .userId)
                    //               ? ProfileDetailsFollowedScreen()
                    //               : ProfileDetailsScreen(
                    //                 userId:
                    //                     lobbyData
                    //                         .lobby
                    //                         .adminSummary
                    //                         .userId,
                    //               ),
                    //     );
                    //   }
                    // }
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: const Color(0xFFEAEFF2),
                        child: ClipOval(
                          child: Image.network(
                            (lobbyData.lobby.houseDetail != null)
                                ? lobbyData.lobby.houseDetail!.profilePhoto
                                : lobbyData.lobby.adminSummary.profilePictureUrl,
                            fit: BoxFit.cover,
                            width: 32,
                            height: 32,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.person, size: 16);
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        // Wrap RichText with Flexible
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hosted by ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF444444),
                                ),
                              ),
                              TextSpan(
                                text: (lobbyData.lobby.houseDetail != null)
                                    ? lobbyData.lobby.houseDetail!.name
                                    : lobbyData.lobby.adminSummary.name,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF444444),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // if (lobbyData.lobby.userStatus == "ADMIN")
              //   SizedBox(
              //     width: 124,
              //     child: DesignButton(
              //       padding: EdgeInsets.all(12),
              //       onPress:
              //           () => Get.to(
              //             () => CoHostSelectionView(lobbyDetails: lobbyData),
              //           ),
              //       bgColor: const Color(0x143E79A1),
              //       child: Row(
              //         children: [
              //           DesignIcon.icon(
              //             icon: Icons.person_add_outlined,
              //             color: const Color(0xFF3E79A1),
              //             size: 16,
              //           ),
              //           Space.w(width: 4),
              //           DesignText(
              //             text: "Invite Co-host",
              //             fontSize: 10,
              //             fontWeight: FontWeight.w500,
              //             color: const Color(0xFF3E79A1),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    // left: 16,
                    top: 16,
                    bottom: 16,
                    right: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 0.7 * sh),
                        child: Stack(
                          children: [
                            MediaGallery.fromUrls(
                              lobbyData.lobby.mediaUrls.isNotEmpty
                                  ? lobbyData.lobby.mediaUrls
                                  : [
                                      "https://media.istockphoto.com/id/1329350253/vector/image-vector-simple-mountain-landscape-photo-adding-photos-to-the-album.jpg?s=612x612&w=0&k=20&c=3iXykf5ZQI2eBo0DaQ7W-e_8E5rhFEammFqO9XCisnI=",
                                    ],
                            ),
                            Positioned(
                              top: 0.1 * sh,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.only(left: 16, right: 12, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                  color: (() {
                                    switch (lobbyData.lobby.lobbyStatus) {
                                      case "UPCOMING":
                                        return Color(0xFF52D17C);
                                      case "PAST":
                                        return Color(0xFFF97853);
                                      case "CLOSED":
                                        return Color(0xFF3E79A1);
                                      case "FULL":
                                        return Color(0xFFF97853);
                                      default:
                                        return Color(0xFF52D17C);
                                    }
                                  })(),
                                  borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
                                ),
                                child: Row(
                                  children: [
                                    DesignIcon.custom(
                                      icon: (() {
                                        switch (lobbyData.lobby.lobbyStatus) {
                                          case "UPCOMING":
                                            return DesignIcons.upcoming;
                                          case "PAST":
                                            return DesignIcons.past;
                                          case "CLOSED":
                                            return DesignIcons.closed;
                                          case "FULL":
                                            return DesignIcons.past;
                                          default:
                                            return DesignIcons.running;
                                        }
                                      })(),
                                      color: (lobbyData.lobby.lobbyStatus == 'ACTIVE') ? Colors.white : null,
                                    ),
                                    Space.w(width: 8),
                                    DesignText(
                                      text: (() {
                                        switch (lobbyData.lobby.lobbyStatus) {
                                          case "UPCOMING":
                                            return "Upcoming";
                                          case "PAST":
                                            return "Past";
                                          case "CLOSED":
                                            return "Closed";
                                          case "ACTIVE":
                                            return "Active";
                                          case "FULL":
                                            return "Full";
                                          default:
                                            return "Join Now!";
                                        }
                                      })(),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0.02 * sh,
                              left: 16,
                              right: 16,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF5750E2),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: DesignText(
                                      text: "${lobbyData.subCategory.iconUrl}    ${lobbyData.subCategory.name}",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (lobbyData.lobby.lobbyStatus != "PAST" && lobbyData.lobby.lobbyStatus != "CLOSED")
                                    IconButton(
                                      style: IconButton.styleFrom(backgroundColor: Colors.black38),
                                      onPressed: () {},
                                      icon: DesignIcon.icon(
                                        icon: (lobbyData.lobby.isPrivate)
                                            ? Icons.lock_outline_rounded
                                            : Icons.lock_open_outlined,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  if (lobbyData.lobby.lobbyStatus == "PAST" || lobbyData.lobby.lobbyStatus == "CLOSED")
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          DesignIcon.custom(icon: DesignIcons.star, color: null, size: 14),
                                          Space.w(width: 4),
                                          DesignText(
                                            text: "${lobbyData.lobby.rating.average} (${lobbyData.lobby.rating.count})",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF444444),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      RichTextDisplay(
                        controller: TextEditingController(text: lobbyData.lobby.description),
                        hintText: '',
                        // maxHeight: 0.4 * sh,
                        // lobbyId: lobbyData.lobby.id,
                        maxHeight: 10 * Get.height,
                        scrollable: false,
                      ),
                      SizedBox(height: 16),
                      if (lobbyData.lobby.setting.showMembers) ...[
                        if (lobbyData.lobby.setting.showLobbyMembers) ...[
                          GestureDetector(
                            onTap: () {
                              FancyAppDownloadDialog.show(
                                context,
                                title: "Unlock Premium Features",
                                message:
                                    "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                // cancelButtonText: "Maybe Later",
                                onCancel: () {
                                  print("User chose to skip download");
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF9F9F9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      DesignText(
                                        text: "Attendees (${lobbyData.lobby.currentMembers})",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF323232),
                                      ),
                                      DesignText(
                                        text: "View all",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF3E79A1),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: displayAvatars.take(3).map((user) {
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: min(0.12 * sw, 140),
                                          maxWidth: max(0.12 * sw, 100),
                                          minHeight: min(0.16 * sh, 140),
                                          maxHeight: max(0.16 * sh, 140),
                                        ),
                                        child: Card(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  radius: 24,
                                                  backgroundColor: const Color(0xFFEAEFF2),
                                                  backgroundImage: user.profilePictureUrl.isNotEmpty
                                                      ? NetworkImage(user.profilePictureUrl)
                                                      : null,
                                                  child: user.profilePictureUrl.isEmpty
                                                      ? Icon(Icons.person, size: 24)
                                                      : null,
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  user.name,
                                                  style: TextStyle(fontSize: 12),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  if (remainingCount > 0)
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        "+$remainingCount more attendees",
                                        style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ] else if (lobbyData.lobby.userStatus == 'MEMBER') ...[
                          GestureDetector(
                            onTap: () {
                              FancyAppDownloadDialog.show(
                                context,
                                title: "Unlock Premium Features",
                                message:
                                    "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                // cancelButtonText: "Maybe Later",
                                onCancel: () {
                                  print("User chose to skip download");
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF9F9F9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      DesignText(
                                        text: "Attendees (${lobbyData.lobby.currentMembers})",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF323232),
                                      ),
                                      DesignText(
                                        text: "View all",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF3E79A1),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: displayAvatars.take(3).map((user) {
                                      return ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: min(0.12 * sw, 140),
                                          maxWidth: max(0.12 * sw, 100),
                                          minHeight: min(0.16 * sh, 140),
                                          maxHeight: max(0.16 * sh, 140),
                                        ),
                                        child: Card(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  radius: 24,
                                                  backgroundColor: const Color(0xFFEAEFF2),
                                                  backgroundImage: user.profilePictureUrl.isNotEmpty
                                                      ? NetworkImage(user.profilePictureUrl)
                                                      : null,
                                                  child: user.profilePictureUrl.isEmpty
                                                      ? Icon(Icons.person, size: 24)
                                                      : null,
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  user.name,
                                                  style: TextStyle(fontSize: 12),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  if (remainingCount > 0)
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        "+$remainingCount more attendees",
                                        style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ],

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(lobbyData.lobby.filter.filterInfoList.length, (index) {
                              final item = lobbyData.lobby.filter.filterInfoList[index];

                              // Format the options list as a string
                              String formattedOptions = item.options.take(3).join(', ');
                              if (item.options.length > 3) {
                                formattedOptions += '...';
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  buildDetailCard(
                                    context,
                                    icon: item.iconUrl ?? "",
                                    title: item.title,
                                    subtitle: formattedOptions,
                                  ),
                                  if (index != (lobbyData.lobby.filter.filterInfoList.length - 1))
                                    Divider(color: Colors.grey.shade300, height: 2.0),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                      Space.h(height: 34),
                      Row(
                        children: [
                          if (lobbyData.lobby.content != null)
                            DesignText(
                              text: lobbyData.lobby.content?.title ?? "Guidelines",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                        ],
                      ),
                      if (lobbyData.lobby.content != null) ...[
                        Space.h(height: 16),
                        NewLobbyContentSection(content: lobbyData.lobby.content!, height: 356),
                      ],
                      Space.h(height: 16),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    // right: 16,
                    top: 16,
                    bottom: 16,
                    left: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isAuth)
                        (() {
                          String combinedStatus = lobbyData.lobby.userStatus;

                          switch (lobbyData.lobby.lobbyStatus) {
                            case "PAST":
                              combinedStatus = "${lobbyData.lobby.userStatus}_${lobbyData.lobby.lobbyStatus}";
                            case "UPCOMING":
                            case "CLOSED":
                              combinedStatus = "${lobbyData.lobby.userStatus}_${lobbyData.lobby.lobbyStatus}";

                            default: // ACTIVE
                          }

                          switch (combinedStatus) {
                            case "MEMBER":
                              return SizedBox.shrink();
                            case "ADMIN_PAST":
                              return SizedBox.shrink();
                            case "ADMIN":
                              if (lobbyData.lobby.priceDetails.originalPrice > 0.0 &&
                                  !lobbyData.lobby.isAdvancedPricing) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        FancyAppDownloadDialog.show(
                                          context,
                                          title: "Unlock Premium Features",
                                          message:
                                              "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                          appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                          playStoreUrl:
                                              "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                          // cancelButtonText: "Maybe Later",
                                          onCancel: () {
                                            print("User chose to skip download");
                                          },
                                        );

                                        //   Get.to(
                                        //   () => EditOfferScreen(
                                        //     lobbyId: lobbyData.lobby.id,
                                        //   ),
                                        // );
                                      },
                                      child: const CustomOfferCard(
                                        boldText: "Add Custom Offers",
                                        normalText: "to attract more attendees to your lobby now.",
                                      ),
                                    ),
                                    Space.h(height: 24),
                                  ],
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            case "VISITOR_PAST":
                              return SizedBox.shrink();
                            default:
                              return OfferSwiper(lobbyId: lobbyData.lobby.id);
                          }
                        })(),

                      (() {
                        String combinedStatus = lobbyData.lobby.userStatus;

                        switch (lobbyData.lobby.lobbyStatus) {
                          case "PAST":
                            combinedStatus = "${lobbyData.lobby.userStatus}_${lobbyData.lobby.lobbyStatus}";
                          case "UPCOMING":
                          case "CLOSED":
                            combinedStatus = "${lobbyData.lobby.userStatus}_${lobbyData.lobby.lobbyStatus}";

                          default: // ACTIVE
                        }

                        switch (combinedStatus) {
                          case "MEMBER":
                            return SizedBox.shrink();
                          case "ADMIN_PAST":
                            return SizedBox.shrink();
                          case "ADMIN":
                            if (lobbyData.lobby.priceDetails.originalPrice > 0.0 &&
                                !lobbyData.lobby.isAdvancedPricing) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      FancyAppDownloadDialog.show(
                                        context,
                                        title: "Unlock Premium Features",
                                        message:
                                            "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                                        appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                                        playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                                        // cancelButtonText: "Maybe Later",
                                        onCancel: () {
                                          print("User chose to skip download");
                                        },
                                      );
                                      // await Get.to(
                                      //   () => AddTierPricingPage(
                                      //     lobbyDetail: lobbyData,
                                      //     lobbyId: lobbyData.lobby.id,
                                      //   ),
                                      // );

                                      // ref
                                      //     .read(
                                      //       lobbyDetailsProvider(
                                      //         lobbyData.lobby.id,
                                      //       ).notifier,
                                      //     )
                                      //     .reset();
                                      // await ref
                                      //     .read(
                                      //       lobbyDetailsProvider(
                                      //         lobbyData.lobby.id,
                                      //       ).notifier,
                                      //     )
                                      //     .fetchLobbyDetails(
                                      //       lobbyData.lobby.id,
                                      //     );
                                    },
                                    child: const CustomOfferCard(
                                      boldText: "Add tier pricing ",
                                      normalText: "to your lobby",
                                    ),
                                  ),
                                  Space.h(height: 24),
                                ],
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          default:
                            return SizedBox.shrink();
                        }
                      })(),

                      Container(
                        decoration: BoxDecoration(color: Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              runSpacing: 12,
                              direction: Axis.vertical,
                              children: [
                                if (lobbyData.lobby.filter.otherFilterInfo.dateInfo != null) ...[
                                  InfoItemWithTitle(
                                    iconUrl: lobbyData.lobby.filter.otherFilterInfo.dateInfo!.iconUrl,
                                    title: lobbyData.lobby.filter.otherFilterInfo.dateInfo!.title,
                                    subTitle: lobbyData.lobby.filter.otherFilterInfo.dateInfo!.formattedDate ?? "",
                                  ),
                                  const Space.h(height: 4),
                                ],
                                if (lobbyData.lobby.filter.otherFilterInfo.dateRange != null) ...[
                                  InfoItemWithTitle(
                                    iconUrl: lobbyData.lobby.filter.otherFilterInfo.dateRange!.iconUrl,
                                    title: lobbyData.lobby.filter.otherFilterInfo.dateRange!.title,
                                    subTitle:
                                        lobbyData.lobby.filter.otherFilterInfo.dateRange!.formattedDateCompactView,
                                  ),
                                  const Space.h(height: 4),
                                ],

                                if (lobbyData.lobby.filter.otherFilterInfo.pickUp != null ||
                                    lobbyData.lobby.filter.otherFilterInfo.destination != null) ...[
                                  InfoItemWithTitle(
                                    iconUrl: lobbyData.lobby.filter.otherFilterInfo.pickUp!.iconUrl,
                                    title: lobbyData.lobby.filter.otherFilterInfo.pickUp?.title ?? "",
                                    subTitle:
                                        lobbyData.lobby.filter.otherFilterInfo.pickUp!.locationResponse?.areaName ?? "",
                                  ),
                                  const Space.h(height: 4),
                                  InfoItemWithTitle(
                                    iconUrl: lobbyData.lobby.filter.otherFilterInfo.pickUp!.iconUrl,
                                    title: lobbyData.lobby.filter.otherFilterInfo.destination?.title ?? "",
                                    subTitle:
                                        lobbyData
                                            .lobby
                                            .filter
                                            .otherFilterInfo
                                            .destination!
                                            .locationResponse
                                            ?.areaName ??
                                        "",
                                  ),
                                  if (lobbyData.lobby.filter.otherFilterInfo.pickUp != null ||
                                      lobbyData.lobby.filter.otherFilterInfo.destination != null) ...[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Card(
                                          elevation: 8,
                                          shadowColor: const Color(0x143E79A1),
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            // constraints:
                                            //     BoxConstraints(minWidth: 0.15.sw),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: Colors.white,
                                            ),
                                            child: InfoItemWithIcon(
                                              iconUrl: "googleMaps",
                                              text: "Show directions",
                                              fontSize: 10,
                                              iconSize: 14,
                                              iconColor: null,
                                              onTap: () async {
                                                double latPickUp = 0.0;
                                                double lngPickUp = 0.0;
                                                double latDestination = 0.0;
                                                double lngDestination = 0.0;

                                                if (lobbyData.lobby.filter.otherFilterInfo.pickUp?.locationResponse !=
                                                        null ||
                                                    lobbyData
                                                            .lobby
                                                            .filter
                                                            .otherFilterInfo
                                                            .destination
                                                            ?.locationResponse !=
                                                        null) {
                                                  if (lobbyData.lobby.userStatus != "MEMBER" &&
                                                      lobbyData.lobby.userStatus != "ADMIN") {
                                                    latPickUp =
                                                        (lobbyData
                                                            .lobby
                                                            .filter
                                                            .otherFilterInfo
                                                            .pickUp
                                                            ?.locationResponse!
                                                            .exactLocation
                                                            .lat) ??
                                                        0.0;
                                                    lngPickUp =
                                                        (lobbyData
                                                            .lobby
                                                            .filter
                                                            .otherFilterInfo
                                                            .pickUp
                                                            ?.locationResponse!
                                                            .exactLocation
                                                            .lon) ??
                                                        0.0;
                                                    latDestination =
                                                        (lobbyData
                                                            .lobby
                                                            .filter
                                                            .otherFilterInfo
                                                            .destination
                                                            ?.locationResponse!
                                                            .exactLocation
                                                            .lat) ??
                                                        0.0;
                                                    lngDestination =
                                                        (lobbyData
                                                            .lobby
                                                            .filter
                                                            .otherFilterInfo
                                                            .destination
                                                            ?.locationResponse!
                                                            .exactLocation
                                                            .lon) ??
                                                        0.0;
                                                  } else {
                                                    latPickUp =
                                                        (lobbyData
                                                            .lobby
                                                            .filter
                                                            .otherFilterInfo
                                                            .pickUp
                                                            ?.locationResponse!
                                                            .exactLocation
                                                            .lat) ??
                                                        0.0;
                                                    lngPickUp =
                                                        (lobbyData
                                                            .lobby
                                                            .filter
                                                            .otherFilterInfo
                                                            .pickUp
                                                            ?.locationResponse!
                                                            .exactLocation
                                                            .lon) ??
                                                        0.0;
                                                    latDestination =
                                                        (lobbyData
                                                            .lobby
                                                            .filter
                                                            .otherFilterInfo
                                                            .destination
                                                            ?.locationResponse!
                                                            .exactLocation
                                                            .lat) ??
                                                        0.0;
                                                    lngDestination =
                                                        (lobbyData
                                                            .lobby
                                                            .filter
                                                            .otherFilterInfo
                                                            .destination
                                                            ?.locationResponse!
                                                            .exactLocation
                                                            .lon) ??
                                                        0.0;
                                                  }
                                                }

                                                // Only proceed if we have valid coordinates
                                                if (latPickUp != 0.0 ||
                                                    lngPickUp != 0.0 ||
                                                    latDestination != 0.0 ||
                                                    lngDestination != 0.0) {
                                                  Uri? mapsUri;
                                                  bool launched = false;

                                                  kLogger.trace(
                                                    "latP : $latPickUp \n lngP : $lngPickUp \n latD : $latDestination \n lngD : $lngDestination",
                                                  );

                                                  // Check if running on web
                                                  if (kIsWeb) {
                                                    // For web, always use Google Maps web interface
                                                    mapsUri = Uri.parse(
                                                      'https://www.google.com/maps/dir/?api=1&origin=$latPickUp,$lngPickUp&destination=$latDestination,$lngDestination',
                                                    );

                                                    try {
                                                      await launchUrl(
                                                        mapsUri,
                                                        mode: LaunchMode.platformDefault, // Use platformDefault for web
                                                        webOnlyWindowName: '_blank', // Open in new tab
                                                      );
                                                      launched = true;
                                                    } catch (e) {
                                                      kLogger.error('Error launching directions URL on web: $e');
                                                    }
                                                  } else {
                                                    // Mobile platform handling
                                                    if (Platform.isAndroid) {
                                                      // Try Google Maps app first
                                                      mapsUri = Uri.parse(
                                                        'https://www.google.com/maps/dir/?api=1&origin=$latPickUp,$lngPickUp&destination=$latDestination,$lngDestination',
                                                      );
                                                      if (await canLaunchUrl(mapsUri)) {
                                                        await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                                        launched = true;
                                                      }
                                                    } else if (Platform.isIOS) {
                                                      // Try Google Maps on iOS first
                                                      mapsUri = Uri.parse(
                                                        'comgooglemaps://?saddr=$latPickUp,$lngPickUp&daddr=$latDestination,$lngDestination&directionsmode=driving',
                                                      );
                                                      if (await canLaunchUrl(mapsUri)) {
                                                        await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                                        launched = true;
                                                      } else {
                                                        // Fall back to Apple Maps
                                                        mapsUri = Uri.parse(
                                                          'https://maps.apple.com/?saddr=$latPickUp,$lngPickUp&daddr=$latDestination,$lngDestination&dirflg=d',
                                                        );
                                                        if (await canLaunchUrl(mapsUri)) {
                                                          await launchUrl(
                                                            mapsUri,
                                                            mode: LaunchMode.externalApplication,
                                                          );
                                                          launched = true;
                                                        }
                                                      }
                                                    }

                                                    // If none of the above worked, fall back to web browser
                                                    if (!launched) {
                                                      mapsUri = Uri.parse(
                                                        'https://www.google.com/maps/dir/?api=1&origin=$latPickUp,$lngPickUp&destination=$latDestination,$lngDestination',
                                                      );
                                                      try {
                                                        await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                                      } catch (e) {
                                                        kLogger.error('Error launching URL: $e');
                                                      }
                                                    }
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        // Space.w(width: 8.w),
                                        if (lobbyData.lobby.filter.otherFilterInfo.locationInfo != null &&
                                            (lobbyData.lobby.filter.otherFilterInfo.locationInfo!.hideLocation) &&
                                            (lobbyData.lobby.userStatus != "MEMBER" ||
                                                lobbyData.lobby.userStatus != "ADMIN"))
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor: Colors.white,
                                                    title: const Text("Approximate Location Shown 🌍"),
                                                    content: const Text(
                                                      "The admin has chosen to hide the exact location. You're seeing an approximate location within a 1 km radius. Once you join the lobby, the exact location will be visible.",
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text("Got it!"),
                                                        onPressed: () {
                                                          Navigator.of(context).pop(); // Dismiss the dialog
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(Icons.info_outline, size: 18),
                                          ),
                                      ],
                                    ),
                                  ],
                                  const Space.h(height: 4),
                                ],
                              ],
                            ),
                            if (lobbyData.lobby.filter.otherFilterInfo.locationInfo != null) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        double lat = 0.0;
                                        double lng = 0.0;

                                        if (lobbyData.lobby.filter.otherFilterInfo.locationInfo != null &&
                                            lobbyData
                                                .lobby
                                                .filter
                                                .otherFilterInfo
                                                .locationInfo!
                                                .locationResponses
                                                .isNotEmpty) {
                                          if ((lobbyData.lobby.filter.otherFilterInfo.locationInfo!.hideLocation) &&
                                              (lobbyData.lobby.userStatus != "MEMBER" &&
                                                  lobbyData.lobby.userStatus != "ADMIN")) {
                                            lat =
                                                lobbyData
                                                    .lobby
                                                    .filter
                                                    .otherFilterInfo
                                                    .locationInfo
                                                    ?.locationResponses
                                                    .first
                                                    .approxLocation
                                                    ?.lat ??
                                                0.0;
                                            lng =
                                                lobbyData
                                                    .lobby
                                                    .filter
                                                    .otherFilterInfo
                                                    .locationInfo
                                                    ?.locationResponses
                                                    .first
                                                    .approxLocation
                                                    ?.lon ??
                                                0.0;
                                          } else {
                                            lat =
                                                lobbyData
                                                    .lobby
                                                    .filter
                                                    .otherFilterInfo
                                                    .locationInfo
                                                    ?.locationResponses
                                                    .first
                                                    .exactLocation
                                                    ?.lat ??
                                                0.0;
                                            lng =
                                                lobbyData
                                                    .lobby
                                                    .filter
                                                    .otherFilterInfo
                                                    .locationInfo
                                                    ?.locationResponses
                                                    .first
                                                    .exactLocation
                                                    ?.lon ??
                                                0.0;
                                          }
                                        }

                                        // Only proceed if we have valid coordinates
                                        if (lat != 0.0 || lng != 0.0) {
                                          Uri? mapsUri;
                                          bool launched = false;

                                          kLogger.trace("lat : $lat \n lng : $lng");

                                          // Check if running on web
                                          if (kIsWeb) {
                                            // For web, always use Google Maps web interface
                                            mapsUri = Uri.parse(
                                              'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
                                            );

                                            try {
                                              await launchUrl(
                                                mapsUri,
                                                mode: LaunchMode.platformDefault, // Use platformDefault for web
                                                webOnlyWindowName: '_blank', // Open in new tab
                                              );
                                              launched = true;
                                            } catch (e) {
                                              kLogger.error('Error launching maps URL on web: $e');
                                            }
                                          } else {
                                            // Mobile platform handling (your existing code)
                                            if (Platform.isAndroid) {
                                              // Try Android's native maps app first
                                              mapsUri = Uri.parse('http://maps.google.com/maps?z=12&t=m&q=$lat,$lng');
                                              if (await canLaunchUrl(mapsUri)) {
                                                await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                                launched = true;
                                              }
                                            } else if (Platform.isIOS) {
                                              // Try Google Maps on iOS first
                                              mapsUri = Uri.parse(
                                                'comgooglemaps://?center=$lat,$lng&zoom=12&q=$lat,$lng',
                                              );
                                              if (await canLaunchUrl(mapsUri)) {
                                                await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                                launched = true;
                                              } else {
                                                // Fall back to Apple Maps
                                                mapsUri = Uri.parse(
                                                  'https://maps.apple.com/?q=${Uri.encodeFull("Location")}&sll=$lat,$lng&z=12',
                                                );
                                                if (await canLaunchUrl(mapsUri)) {
                                                  await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                                  launched = true;
                                                }
                                              }
                                            }

                                            // If none of the above worked, fall back to web browser
                                            if (!launched) {
                                              mapsUri = Uri.parse(
                                                'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
                                              );
                                              try {
                                                await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
                                              } catch (e) {
                                                kLogger.error('Error launching URL: $e');
                                              }
                                            }
                                          }
                                        }
                                      },
                                      child: DesignText(
                                        text:
                                            "📍 ${((lobbyData.lobby.filter.otherFilterInfo.locationInfo!.hideLocation) && (lobbyData.lobby.filter.otherFilterInfo.locationInfo!.locationResponses.firstOrNull?.fuzzyAddress.isNotEmpty ?? false) && (lobbyData.lobby.userStatus != "MEMBER") && (lobbyData.lobby.userStatus != "ADMIN"))
                                                ? lobbyData.lobby.filter.otherFilterInfo.locationInfo!.locationResponses.firstOrNull?.fuzzyAddress
                                                : (lobbyData.lobby.filter.otherFilterInfo.locationInfo?.googleSearchResponses?.isNotEmpty == true)
                                                ? lobbyData.lobby.filter.otherFilterInfo.locationInfo!.googleSearchResponses.first.description
                                                : 'No location details available'}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF3E79A1),
                                        maxLines: 10,
                                      ),
                                    ),
                                  ),
                                  // Space.w(width: 8.w),
                                  if (lobbyData.lobby.filter.otherFilterInfo.locationInfo != null &&
                                      (lobbyData.lobby.filter.otherFilterInfo.locationInfo!.hideLocation) &&
                                      (lobbyData.lobby.userStatus != "MEMBER" || lobbyData.lobby.userStatus != "ADMIN"))
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: const Text("Approximate Location Shown 🌍"),
                                              content: const Text(
                                                "The admin has chosen to hide the exact location. You're seeing an approximate location within a 1 km radius. Once you join the lobby, the exact location will be visible.",
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text("Got it!"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(); // Dismiss the dialog
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(Icons.info_outline, size: 20),
                                    ),
                                ],
                              ),
                            ],

                            if (lobbyData.lobby.filter.otherFilterInfo.multipleLocations != null) ...[
                              Space.h(height: 16),
                              DesignText(
                                text:
                                    lobbyData.lobby.filter.otherFilterInfo.multipleLocations?.title ??
                                    'Multiple Location',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF444444),
                                maxLines: 10,
                              ),
                              Space.h(height: 8),
                              _buildLocationSection(lobby: lobbyData.lobby),
                            ],
                          ],
                        ),
                      ),
                      ScrollableInfoCards(
                        cards: [
                          InfoCard(
                            icon: Icons.payment,
                            title: (lobbyData.lobby.priceDetails.originalPrice > 0.0)
                                ? "Refund Policies :"
                                : "Pricing ",
                            subtitle: (lobbyData.lobby.priceDetails.isRefundAllowed)
                                ? "Up to 2 days before the lobby."
                                : (lobbyData.lobby.priceDetails.originalPrice > 0.0)
                                ? "refund not allowed for this lobby"
                                : "This Lobby is Free",
                          ),
                          InfoCard(
                            icon: Icons.groups,
                            title: "Lobby Size",
                            subtitle: "Maximum: ${lobbyData.lobby.totalMembers}",
                          ),
                          if (lobbyData.lobby.filter.otherFilterInfo.range != null)
                            InfoCard(
                              icon: Icons.cake,
                              title: lobbyData.lobby.filter.otherFilterInfo.range?.title ?? "Age Limit",
                              subtitle:
                                  "${lobbyData.lobby.filter.otherFilterInfo.range?.min ?? 0} to ${lobbyData.lobby.filter.otherFilterInfo.range?.max ?? 0} ",
                            ),
                        ],
                      ),
                      ResponsiveAppDownloadCard(
                        appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                        playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                        onClose: () {
                          FancyAppDownloadDialog.show(
                            context,
                            title: "Unlock Premium Features",
                            message:
                                "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                            appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                            playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                            // cancelButtonText: "Maybe Later",
                            onCancel: () {
                              print("User chose to skip download");
                            },
                          );
                          // Get.to(()=> AppLandingPage());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (isAuth) const LobbiesList(lobbyType: LobbyType.recommendations, title: "Recommended Lobbies"),
          Space.h(height: 34),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBarLeftSideWidget({required LobbyDetails lobbyDetail}) {
    final lobbyStatus = lobbyDetail.lobby.lobbyStatus;
    final userStatus = lobbyDetail.lobby.userStatus;
    final isPrivilegedUser = userStatus == "MEMBER" || userStatus == "ADMIN";

    // For ACTIVE lobby, keep the existing price/slots card
    return (userStatus == "VISITOR")
        ? Card(
            color: Colors.white,
            shadowColor: const Color(0x6C3E79A1),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.only(top: 0, left: 0, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DesignText(
                    text: (lobbyDetail.lobby.priceDetails?.price != 0.0)
                        ? "₹${lobbyDetail.lobby.priceDetails?.price ?? 0.0}/person"
                        : "Free",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  // Space.h(height: 2.h),
                  if (lobbyDetail.lobby.activity == "HIGH") ...[
                    DesignText(
                      text: "${lobbyDetail.lobby.membersRequired} slots available",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ],
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }

  // Helper method for right side widget
  Widget _buildBottomNavigationBarRightSideWidget({required LobbyDetails lobbyDetail}) {
    final isAuth = ref.watch(isAuthProvider(lobbyDetail.lobby.id));
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    final lobbyStatus = lobbyDetail.lobby.lobbyStatus;
    final userStatus = lobbyDetail.lobby.userStatus;
    final isPrivilegedUser = userStatus == "MEMBER" || userStatus == "ADMIN";

    // For PAST lobbies with MEMBER or ADMIN - maybe add additional controls
    if (lobbyStatus == "PAST") {
      if (isPrivilegedUser) {
        return DesignButton(
          onPress: () {
            FancyAppDownloadDialog.show(
              context,
              title: "Unlock Premium Features",
              message: "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
              appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
              playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
              // cancelButtonText: "Maybe Later",
              onCancel: () {
                print("User chose to skip download");
              },
            );

            // HapticFeedback.selectionClick();
            // Get.to(
            //   () => CreateMomentsTabView(
            //     lobbyId: lobbyDetail.lobby.id,
            //     lobbyTitle: lobbyDetail.lobby.title,
            //   ),
            // );
          },
          bgColor: DesignColors.accent,
          // padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Center(
            child: DesignText(text: "Create Moment", fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        );
      } else {
        return DesignButton(
          onPress: () {
            HapticFeedback.lightImpact();
            CustomSnackBar.show(context: context, message: "This Lobby is Closed", type: SnackBarType.info);
          },
          bgColor: const Color(0xFF989898),
          child: Center(
            child: DesignText(text: "Lobby Closed", fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        );
      }
    }

    // For FULL or CLOSED lobbies
    if (lobbyStatus == "FULL" || lobbyStatus == "CLOSED") {
      if (userStatus == "ADMIN") {
        return DesignButton(
          onPress: () async {
            HapticFeedback.lightImpact();
            if (lobbyStatus == "FULL") {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: LobbySmallEditSheet(lobby: lobbyDetail.lobby),
                  );
                },
              );
            } else {
              // Show loading dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: DesignColors.accent),
                        SizedBox(height: 16),
                        DesignText(
                          text: "Activating lobby...",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                },
              );

              // Make API call to activate lobby
              final activationNotifier = ref.read(lobbyActivationProvider(lobbyDetail.lobby.id).notifier);
              final success = await activationNotifier.activateLobby(lobbyDetail.lobby.id);

              // Close the loading dialog
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              // Show success or error message
              if (success) {
                CustomSnackBar.show(
                  context: context,
                  message: "Lobby activated successfully!",
                  type: SnackBarType.success,
                );

                // Refresh the lobby details
                ref.read(lobbyDetailsProvider(lobbyDetail.lobby.id).notifier).reset();
                await ref
                    .read(lobbyDetailsProvider(lobbyDetail.lobby.id).notifier)
                    .fetchLobbyDetails(lobbyDetail.lobby.id);
              } else {
                CustomSnackBar.show(
                  context: context,
                  message: "Failed to activate lobby. Please try again.",
                  type: SnackBarType.error,
                );
              }
            }
          },
          bgColor: const Color(0xFF989898),
          child: Center(
            child: DesignText(
              text: lobbyStatus == "FULL" ? "Lobby Full  (Edit Lobby)" : "Make Lobby Active",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        );
      } else {
        return DesignButton(
          onPress: () {
            HapticFeedback.lightImpact();
            CustomSnackBar.show(
              context: context,
              message: "This Lobby is ${lobbyStatus == "FULL" ? "Full" : "Closed"}",
              type: SnackBarType.info,
            );
          },
          bgColor: const Color(0xFF989898),
          child: Center(
            child: DesignText(
              text: lobbyStatus == "FULL" ? "Lobby Full" : "Lobby Closed",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        );
      }
    }

    // For other cases, keep your existing conditional widget
    return (userStatus != "MEMBER")
        ? SizedBox(
            width: 0.4 * sw,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: DesignButton(
                    onPress: () async {
                      HapticFeedback.mediumImpact();
                      print("isAuth : $isAuth");
                      if (isAuth) {
                        switch (lobbyDetail.lobby.userStatus) {
                          case "REQUESTED":
                            CustomSnackBar.show(
                              context: context,
                              message: "Already Requested",
                              type: SnackBarType.info,
                            );
                            return;
                          case "REQUEST_DENIED":
                            CustomSnackBar.show(
                              context: context,
                              message: "Your request was denied by Admin",
                              type: SnackBarType.info,
                            );
                            return;
                          case "INTERNAL_ACCESS_REQUEST":
                            if (lobbyDetail.lobby.accessRequestData != null &&
                                (lobbyDetail.lobby.accessRequestData?.accessId.isNotEmpty ?? false)) {
                              Get.toNamed(
                                AppRoutes.sharedAccessRequestCardExtendedView.replaceAll(
                                  ':accessReqId',
                                  lobbyDetail.lobby.accessRequestData?.accessId ?? "",
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(msg: "Something went wrong \n Please try again!!!");
                            }
                          case "REMOVED":
                            CustomSnackBar.show(
                              context: context,
                              message:
                                  "You’ve been removed by the admin. This lobby is no longer accessible to you and you won’t be able to rejoin",
                              type: SnackBarType.info,
                            );
                            return;
                          case "PAYMENT_PENDING":
                            if (lobbyDetail.lobby.accessRequestData != null) {
                              if (lobbyDetail.lobby.accessRequestData!.isGroupAccess) {
                                if (lobbyDetail.lobby.accessRequestData!.isAdmin) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        content: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [CircularProgressIndicator(color: DesignColors.accent)],
                                        ),
                                      );
                                    },
                                  );

                                  // Fetch pricing data
                                  await ref
                                      .read(pricingProvider(lobbyDetail.lobby.id).notifier)
                                      .fetchPricing(lobbyDetail.lobby.id, groupSize: 1);

                                  // Close the loading dialog
                                  Navigator.of(context, rootNavigator: true).pop();

                                  final pricingState = ref.read(pricingProvider(lobbyDetail.lobby.id));
                                  final pricingData = pricingState.pricingData;

                                  if (pricingData != null && pricingData.status == 'SUCCESS') {
                                    await Get.toNamed(
                                      AppRoutes.checkOutPublicLobbyView,
                                      arguments: {'lobby': lobbyDetail.lobby},
                                    );
                                  } else {
                                    // Show error message if pricing data couldn't be fetched
                                    CustomSnackBar.show(
                                      context: context,
                                      message: "Something went wrong",
                                      type: SnackBarType.error,
                                    );
                                  }
                                } else {
                                  CustomSnackBar.show(
                                    context: context,
                                    message: "contact your admin to finish payment",
                                    type: SnackBarType.info,
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      content: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [CircularProgressIndicator(color: DesignColors.accent)],
                                      ),
                                    );
                                  },
                                );

                                // Fetch pricing data
                                await ref
                                    .read(pricingProvider(lobbyDetail.lobby.id).notifier)
                                    .fetchPricing(lobbyDetail.lobby.id, groupSize: 1);

                                // Close the loading dialog
                                Navigator.of(context, rootNavigator: true).pop();

                                final pricingState = ref.read(pricingProvider(lobbyDetail.lobby.id));
                                final pricingData = pricingState.pricingData;

                                if (pricingData != null && pricingData.status == 'SUCCESS') {
                                  await Get.toNamed(
                                    AppRoutes.checkOutPublicLobbyView,
                                    arguments: {'lobby': lobbyDetail.lobby},
                                  );
                                } else {
                                  // Show error message if pricing data couldn't be fetched
                                  CustomSnackBar.show(
                                    context: context,
                                    message: "Something went wrong",
                                    type: SnackBarType.error,
                                  );
                                }
                              }
                            } else {
                              Fluttertoast.showToast(msg: "Something went wrong \n Please try again!!!");
                            }

                          default:
                            return _onJoinOrRequest(
                              context: context,
                              lobby: lobbyDetail.lobby,
                            ); // Default case if userStatus is unexpected
                        }
                      } else if (lobbyDetail.lobby.userStatus == "VISITOR" && lobbyDetail.lobby.loginNotRequired) {
                        Get.toNamed(AppRoutes.noAuthCheckoutLobbyView.replaceAll(':lobbyId', lobbyDetail.lobby.id));
                      } else {
                        LoginRequiredDialog.show(
                          context,
                          title: "Authentication Required",
                          message: "Please sign in or create an account to access this exclusive lobby experience.",
                          onLogin: () {
                            Get.toNamed(AppRoutes.auth.replaceAll(':destination', widget.lobbyId));
                          },
                          onSignup: () {
                            Get.toNamed(AppRoutes.auth.replaceAll(':destination', widget.lobbyId));
                          },
                          cancelButtonText: "Maybe Later",
                        );
                      }
                    },
                    bgColor: () {
                      switch (lobbyDetail.lobby.userStatus) {
                        case "REQUESTED":
                          return const Color(0xFF989898);
                        case "REQUEST_DENIED":
                          return const Color(0xFF323232);
                        case "REMOVED":
                          return const Color(0xFF323232);
                        case "INTERNAL_ACCESS_REQUEST":
                          return const Color(0xFF3E79A1);
                        case "PAYMENT_PENDING":
                          if (lobbyDetail.lobby.accessRequestData != null) {
                            if (lobbyDetail.lobby.accessRequestData!.isAdmin) {
                              return const Color(0xFF3E79A1);
                            } else if (!lobbyDetail.lobby.accessRequestData!.isGroupAccess) {
                              return const Color(0xFF3E79A1);
                            } else {
                              return const Color(0xFF989898);
                            }
                          }
                          return const Color(0xFF989898);
                        default:
                          return DesignColors.accent; // Default case if userStatus is unexpected
                      }
                    }(),
                    child: Center(
                      child: DesignText(
                        text: () {
                          switch (lobbyDetail.lobby.userStatus) {
                            case "ADMIN":
                              return "Invite People";
                            case "VISITOR":
                              return lobbyDetail.lobby.isPrivate
                                  ? "Request"
                                  : "Join"; // Show based on whether the visitor has joined or not
                            case "REQUESTED":
                              return "Request Pending";
                            case "REQUEST_DENIED":
                              return "Request Denied";
                            case "REMOVED":
                              return "Removed";
                            case "INTERNAL_ACCESS_REQUEST":
                              return "Finalize Request";
                            case "PAYMENT_PENDING":
                              return "Payment Pending ${(lobbyDetail.lobby.priceDetails?.price != null && lobbyDetail.lobby.priceDetails!.price > 0.0) ? "- Rs.${lobbyDetail.lobby.priceDetails?.price} per slot" : "(Free)"}";
                            default:
                              return "Join Lobby"; // Default case if userStatus is unexpected
                          }
                        }(),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    // title: () {
                    //   switch (lobbyDetail.lobby.userStatus) {
                    //     case "ADMIN":
                    //       return "Invite People";
                    //     case "VISITOR":
                    //       return lobbyDetail.lobby.isPrivate
                    //           ? "Request"
                    //           : "Join"; // Show based on whether the visitor has joined or not
                    //     case "REQUESTED":
                    //       return "Request Pending ";
                    //     case "REQUEST_DENIED":
                    //       return "Request Denied";
                    //     case "PAYMENT_PENDING":
                    //       return "Payment Pending";
                    //     default:
                    //       return "Join Lobby"; // Default case if userStatus is unexpected
                    //   }
                    // }(),
                  ),
                ),
              ],
            ),
          )
        : DigitalCountdownButton(endTimestamp: lobbyDetail.lobby.dateRange['startDate'], onPressed: () {});
  }

  Widget buildDetailCard(
    BuildContext context, {
    required String icon,
    required String title,
    required String subtitle,
  }) {
    DesignIcons? iconUrl = DesignIcons.all;
    if (icon.length > 2) {
      iconUrl = DesignIcons.getIconFromString(icon);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          icon.length > 2
              ? DesignIcon.custom(icon: iconUrl ?? DesignIcons.all, size: 16, color: const Color(0xFF3E79A1))
              : DesignText(text: icon, fontSize: 12, fontWeight: FontWeight.w500, maxLines: 1),
          SizedBox(width: 16),
          Expanded(
            child: DesignText(text: title, fontSize: 12, fontWeight: FontWeight.w500, maxLines: 1),
          ),
          DesignText(text: subtitle, fontSize: 10, fontWeight: FontWeight.w400, maxLines: 1),
        ],
      ),
    );
  }

  Widget _buildLocationSection({required Lobby lobby}) {
    if (lobby.filter.otherFilterInfo.multipleLocations == null ||
        (lobby.filter.otherFilterInfo.multipleLocations == null &&
            lobby.filter.otherFilterInfo.multipleLocations!.googleSearchResponses == null)) {
      return SizedBox.shrink();
    }

    // Collect all available locations
    List<String> locations = [];

    // Add locations from locationResponses
    if (lobby.filter.otherFilterInfo.multipleLocations != null) {
      for (var location in lobby.filter.otherFilterInfo.multipleLocations!.googleSearchResponses) {
        if (location.structuredFormatting?.mainText != null && location.structuredFormatting!.mainText!.isNotEmpty) {
          locations.add(location.structuredFormatting!.mainText!);
        } else if (location.description != null && location.description!.isNotEmpty) {
          locations.add(location.description!);
        }
      }
    }

    // Remove duplicates
    locations = locations.toSet().toList();

    // Check if we have any locations
    if (locations.isEmpty) {
      return SizedBox.shrink();
    }

    final lobbyId = lobby.id ?? '';
    final isExpanded = ref.watch(isLocationsExpandedProvider(lobbyId));

    // Determine if we need to show "Show More" button
    bool hasMoreLocations = locations.length > 3;
    List<String> displayedLocations = isExpanded ? locations : locations.take(3).toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        // borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display locations as chips in a wrap layout
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...displayedLocations.map(
                (location) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ColorsPalette.redColor.withOpacity(0.3), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.place, size: 14, color: ColorsPalette.redColor),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          location,
                          style: DesignFonts.poppins.merge(
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Show "More" or "Less" button if there are more than 3 locations
          if (hasMoreLocations)
            GestureDetector(
              onTap: () {
                ref.read(isLocationsExpandedProvider(lobbyId).notifier).state = !isExpanded;
              },
              child: Container(
                margin: EdgeInsets.only(top: 8),
                child: Text(
                  isExpanded ? "Show less" : "Show more locations (${locations.length - 3})",
                  style: DesignFonts.poppins.merge(
                    TextStyle(color: ColorsPalette.redColor, fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Provider to manage countdown state
final countdownStateProvider = StateNotifierProvider.autoDispose.family<CountdownStateNotifier, String, int>(
  (ref, timestamp) => CountdownStateNotifier(timestamp),
);

class CountdownStateNotifier extends StateNotifier<String> {
  CountdownStateNotifier(this.endTimestamp) : super('') {
    _startTimer();
  }

  final int endTimestamp;
  Timer? _timer;

  void _startTimer() {
    // Update immediately and then every second
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final endTime = DateTime.fromMillisecondsSinceEpoch(endTimestamp);
    final difference = endTime.difference(DateTime.now());

    if (difference.isNegative) {
      state = "Ongoing";
      _timer?.cancel();
      return;
    }

    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);
    final seconds = difference.inSeconds.remainder(60);

    state =
        '$days : ${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// The countdown button widget
class DigitalCountdownButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final int endTimestamp;

  const DigitalCountdownButton({super.key, this.onPressed, required this.endTimestamp});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Add listener for widget disposal
    ref.listen(countdownStateProvider(endTimestamp), (previous, next) {});

    final countdownText = ref.watch(countdownStateProvider(endTimestamp));

    return DesignButton(
      onPress: () {
        onPressed!();
      },
      // bgColor: Colors.white, // Set background to white for outlined look
      bgColor: const Color(0xFF3E79A1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(
          // color: Color(0xFF3E79A1),
          color: Colors.white,
        ), // Add border
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Center(
        child: DesignText(
          text: countdownText,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          // color: const Color(0xFF3E79A1),
          color: Colors.white,
        ),
      ),
    );
  }
}

final expandedStateProvider = StateProvider.family<bool, String>((ref, id) => false);

class ExpandableText extends ConsumerStatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final int collapsedMaxLines;
  final Color color;
  final String id; // Unique ID for this instance to track state

  const ExpandableText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.collapsedMaxLines = 2,
    required this.color,
    required this.id,
  });

  @override
  ConsumerState<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends ConsumerState<ExpandableText> {
  late TextPainter _textPainter;
  bool _needsReadMore = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Don't initialize with context here
    _textPainter = TextPainter();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTextHeight();
    });
  }

  void _calculateTextHeight() {
    _textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: TextStyle(fontSize: widget.fontSize, fontWeight: widget.fontWeight, color: widget.color),
      ),
      textDirection: Directionality.of(context), // Use a simple hardcoded value
      maxLines: widget.collapsedMaxLines,
    );

    _textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 32);
    // Check if text overflows the collapsed max lines
    _needsReadMore = _textPainter.didExceedMaxLines;
    _isInitialized = true;

    if (_needsReadMore && mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Only recalculate if context is fully available
    if (WidgetsBinding.instance.isRootWidgetAttached && !_isInitialized) {
      _calculateTextHeight();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isExpanded = ref.watch(expandedStateProvider(widget.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DesignText(
          text: widget.text,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          maxLines: isExpanded ? 1000 : widget.collapsedMaxLines, // null means no limit
          color: widget.color,
        ),
        if (_needsReadMore)
          GestureDetector(
            onTap: () {
              ref.read(expandedStateProvider(widget.id).notifier).state = !isExpanded;
            },
            child: Padding(
              padding: EdgeInsets.only(top: 4),
              child: DesignText(
                text: isExpanded ? "Read Less" : "Read More",
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF3E79A1),
              ),
            ),
          ),
      ],
    );
  }
}

class JoinOptionsModal extends StatelessWidget {
  final VoidCallback onJoinWithFriends;
  final VoidCallback onJoinAsIndividual;

  const JoinOptionsModal({super.key, required this.onJoinWithFriends, required this.onJoinAsIndividual});

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onJoinWithFriends,
    required VoidCallback onJoinAsIndividual,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) =>
          JoinOptionsModal(onJoinWithFriends: onJoinWithFriends, onJoinAsIndividual: onJoinAsIndividual),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(color: const Color(0xFF444444), borderRadius: BorderRadius.circular(2)),
            ),
            _buildOptionButton(
              title: 'Join with friends',
              onPressed: () {
                Navigator.pop(context);
                onJoinWithFriends();
              },
            ),
            SizedBox(height: 16),
            _buildOptionButton(
              title: 'Join as an individual',
              onPressed: () {
                Navigator.pop(context);
                onJoinAsIndividual();
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({required String title, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: DesignButton(
        onPress: onPressed,
        padding: EdgeInsets.symmetric(vertical: 16),
        title: title,
        bgColor: Colors.white,
        titleColor: const Color(0xFF3E79A1),
        titleSize: 16,
        shape: const StadiumBorder(
          side: BorderSide(
            color: Color(0xFF3E79A1), // Border color
            width: 0.8, // Border thickness
          ),
        ),
      ),
    );
  }
}

class InviteOptionsModal extends StatelessWidget {
  final VoidCallback onInviteFriends;
  final VoidCallback onInviteExternalMembers;

  const InviteOptionsModal({super.key, required this.onInviteFriends, required this.onInviteExternalMembers});

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onInviteFriends,
    required VoidCallback onInviteExternalMembers,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) =>
          InviteOptionsModal(onInviteFriends: onInviteFriends, onInviteExternalMembers: onInviteExternalMembers),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(color: const Color(0xFF444444), borderRadius: BorderRadius.circular(2)),
            ),
            _buildOptionButton(
              title: 'Invite Users',
              onPressed: () {
                Navigator.pop(context);
                onInviteFriends();
              },
            ),
            SizedBox(height: 16),
            _buildOptionButton(
              title: 'Invite External Members',
              onPressed: () {
                Navigator.pop(context);
                onInviteExternalMembers();
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({required String title, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: DesignButton(
        onPress: onPressed,
        padding: EdgeInsets.symmetric(vertical: 16),
        title: title,
        bgColor: Colors.white,
        titleColor: const Color(0xFF3E79A1),
        titleSize: 16,
        shape: const StadiumBorder(
          side: BorderSide(
            color: Color(0xFF3E79A1), // Border color
            width: 0.8, // Border thickness
          ),
        ),
      ),
    );
  }
}

class InfoItemWithIcon extends StatelessWidget {
  final String? iconUrl;
  final String text;
  final VoidCallback? onTap;
  final double fontSize;
  final double iconSize;
  final Color? iconColor;

  const InfoItemWithIcon({
    super.key,
    this.iconUrl,
    required this.text,
    this.onTap,
    this.fontSize = 14,
    this.iconSize = 14,
    this.iconColor = DesignColors.accent,
  });

  @override
  Widget build(BuildContext context) {
    final convertedIcon = iconUrl != null ? DesignIcons.getIconFromString(iconUrl!) : null;
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return SizedBox(
      width: 0.25 * sw,
      child: InkWell(
        onTap: onTap,
        child: convertedIcon != null
            ? Row(
                children: [
                  DesignIcon.custom(icon: convertedIcon, color: iconColor, size: iconSize),
                  SizedBox(width: 10),
                  Expanded(
                    child: DesignText(
                      text: text,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF444444),
                      maxLines: 10,
                    ),
                  ),
                ],
              )
            : DesignText(
                text: iconUrl != null ? "$iconUrl  $text" : text,
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF444444),
              ),
      ),
    );
  }
}

class InfoItemWithTitle extends StatelessWidget {
  final String? iconUrl;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;
  final double fontSize;
  final double iconSize;
  final Color? iconColor;

  const InfoItemWithTitle({
    super.key,
    this.iconUrl,
    required this.title,
    required this.subTitle,
    this.onTap,
    this.fontSize = 14,
    this.iconSize = 14,
    this.iconColor = DesignColors.accent,
  });

  @override
  Widget build(BuildContext context) {
    // final convertedIcon =
    //     iconUrl != null ? DesignIcons.getIconFromString(iconUrl!) : null;
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return SizedBox(
      width: 1 * sw,
      child: InkWell(
        onTap: onTap,
        child: iconUrl == null
            ? Row(
                children: [
                  // DesignIcon.custom(
                  //   icon: convertedIcon,
                  //   color: iconColor,
                  //   size: iconSize,
                  // ),
                  // SizedBox(width: 10.w),
                  DesignText(
                    text: "$title  :  ",
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF444444),
                    maxLines: 10,
                    textAlign: TextAlign.left,
                  ),
                  // SizedBox(width: 10.w),
                  Expanded(
                    child: DesignText(
                      text: subTitle,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF444444),
                      maxLines: 10,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              )
            : DesignText(
                text: "$iconUrl $subTitle",
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF444444),
              ),
      ),
    );
  }
}
