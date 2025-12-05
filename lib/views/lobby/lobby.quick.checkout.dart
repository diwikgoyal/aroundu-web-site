import 'dart:io' show Platform;
import 'dart:html' as html;
import 'dart:math';
import 'package:aroundu/constants/appRoutes.dart';
import 'package:aroundu/designs/colors.designs.dart';
import 'package:aroundu/designs/utils.designs.dart';
import 'package:aroundu/designs/widgets/button.widget.designs.dart';
import 'package:aroundu/designs/widgets/icon.widget.designs.dart';
import 'package:aroundu/designs/widgets/space.widget.designs.dart';
import 'package:aroundu/designs/widgets/text.widget.designs.dart';
import 'package:aroundu/designs/widgets/textfield.widget.designs.dart';
import 'package:aroundu/models/detailed.lobby.model.dart';
import 'package:aroundu/models/lobby.dart';
import 'package:aroundu/utils/appDownloadCard.dart';
import 'package:aroundu/utils/custome_snackbar.dart';
import 'package:aroundu/utils/disable_card_wrapper.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:aroundu/views/lobby/lobby_content_section.dart';
import 'package:aroundu/views/lobby/provider/get_price_provider.dart';
import 'package:aroundu/views/lobby/provider/lobby_register_provider.dart';
import 'package:aroundu/views/lobby/provider/lock_pricing_provider.dart';
import 'package:aroundu/views/lobby/provider/selected_tickets_provider.dart';
import 'package:aroundu/views/lobby/widgets/infoCard.dart';
import 'package:aroundu/views/lobby/widgets/rich_text_display.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/api_service/api.service.dart';

class LobbyQuickCheckoutView extends ConsumerStatefulWidget {
  const LobbyQuickCheckoutView({super.key, required this.lobbyId, this.referralSource});
  final String lobbyId;
  final String? referralSource;

  @override
  ConsumerState<LobbyQuickCheckoutView> createState() => _LobbyQuickCheckoutViewState();
}

// Counter provider for managing number of slots
final quickCheckoutCounterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

// Provider to track expanded state of location sections
final isLocationsExpandedProvider = StateProvider.family<bool, String>((ref, lobbyId) => false);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(1);

  void increment() => state++;
  void decrement() {
    if (state > 1) {
      state--;
    }
  }

  void setValue(int value) {
    state = value;
  }
}

class _LobbyQuickCheckoutViewState extends ConsumerState<LobbyQuickCheckoutView> {
  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;
  
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _targetKey = GlobalKey();
  bool _showFab = true;

  @override
  void initState() {
    super.initState();

    // Initialize counter with 1
    ref.read(quickCheckoutCounterProvider.notifier).setValue(1);

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      kLogger.error('Flutter Error: ${details.exception}');
      kLogger.error('Stack trace: ${details.stack}');
    };

    Future.microtask(() async {
      // await ref
      //     .read(lobbyQuickCheckoutDetailsProvider(widget.lobbyId).notifier)
      //     .fetchLobbyQuickCheckoutDetails(widget.lobbyId);
      ref.read(selectedTicketsProvider.notifier).clearAll();
      await ref
          .read(pricingProvider(widget.lobbyId).notifier)
          .fetchPricing(widget.lobbyId, groupSize: 1, selectedTickets: [], isPublic: true);
    });
    
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
  
  void _onScroll() {
    _checkVisibility();
  }

  void _checkVisibility() {
    final RenderObject? renderObject = _targetKey.currentContext
        ?.findRenderObject();
    if (renderObject == null) return;

    final RenderBox box = renderObject as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    final Size size = box.size;

    // Get screen height
    final double screenHeight = Get.height;

    // Check if any part of the container is visible on screen
    // Container is visible if:
    // - Top edge is below screen top (position.dy < screenHeight)
    // - Bottom edge is above screen top (position.dy + size.height > 0)
    bool isVisible =
        position.dy < screenHeight && (position.dy + size.height) > 0;
        
        kLogger.trace('Container visibility: $isVisible');

    if (isVisible && _showFab) {
      setState(() {
        _showFab = false;
      });
    } else if (!isVisible && !_showFab) {
      setState(() {
        _showFab = true;
      });
    }
  }

  void _scrollToContainer() {
    final context = _targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // Method to handle checkout process
  void _handleCheckout(Lobby lobbyData, double totalPrice) async {
    final selectedTickets = ref.watch(selectedTicketsProvider);
    final currentLobbyTickets = selectedTickets[widget.lobbyId] ?? [];
    // Get the number of slots from the counter provider
    final slotCount = ref.read(quickCheckoutCounterProvider);

    // Call the lobby registration provider
    final registrationNotifier = ref.read(lobbyRegistrationProvider(widget.lobbyId).notifier);

    await ref
        .read(pricingProvider(lobbyData.id).notifier)
        .fetchPricing(lobbyData.id, groupSize: slotCount, selectedTickets: currentLobbyTickets, isPublic: true);

    final getPricingData = ref.read(pricingProvider(lobbyData.id));
    kLogger.trace("getPricingData : ${getPricingData.pricingData?.toJson()}");
    if (getPricingData.pricingData == null) {
      CustomSnackBar.show(
        context: context,
        message: getPricingData.pricingData?.message ?? 'Something went wrong!',
        type: SnackBarType.error,
      );
      return;
    } else if (getPricingData.pricingData?.status != 'SUCCESS' || getPricingData.pricingData?.total != totalPrice) {
      CustomSnackBar.show(
        context: context,
        message:
            getPricingData.pricingData?.message ??
            'Something went wrong!, Please refresh the page and try again later.',
        type: SnackBarType.error,
      );
      return;
    }
    // Check if the form fields are valid
    if (!_formKey.currentState!.validate()) return;

    // Check if name is empty
    if (_nameController.text.isEmpty) {
      CustomSnackBar.show(context: context, message: 'Please enter your name', type: SnackBarType.warning);
      return;
    }

    // Check if email is empty
    if (_emailController.text.isEmpty) {
      CustomSnackBar.show(context: context, message: 'Please enter your email', type: SnackBarType.warning);
      return;
    }

    // Check if email is valid
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
      CustomSnackBar.show(context: context, message: 'Please enter a valid email address', type: SnackBarType.warning);
      return;
    }

    // Check if mobile number is empty
    if (_mobileController.text.isEmpty) {
      CustomSnackBar.show(context: context, message: 'Please enter your mobile number', type: SnackBarType.warning);
      return;
    }

    // Check if mobile number is valid (10 digits)
    if (_mobileController.text.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(_mobileController.text)) {
      CustomSnackBar.show(
        context: context,
        message: 'Please enter a valid 10-digit mobile number',
        type: SnackBarType.warning,
      );
      return;
    }

    if (lobbyData.isAdvancedPricing && currentLobbyTickets.isEmpty) {
      CustomSnackBar.show(context: context, message: 'Please select at least one ticket', type: SnackBarType.error);
      return;
    }
    String userId =
        '${Random().nextInt(16777215).toRadixString(16)}${DateTime.now().millisecondsSinceEpoch.toRadixString(16)}';
    // Lock the pricing after updating group size
    await ref
        .read(lockPricingProvider(lobbyData.id).notifier)
        .lockPricing(lobbyData.id, slotCount, currentLobbyTickets, userId: userId, isPublic: true);

    // Check if lock pricing failed and show toast with error message
    final lockPricingData = ref.read(lockPricingDataProvider(lobbyData.id));
    kLogger.trace("lockPricingData : ${lockPricingData?.toJson()}");
    if (lockPricingData != null && lockPricingData.status != 'SUCCESS') {
      Get.back();
      CustomSnackBar.show(
        context: context,
        message: lockPricingData.message ?? 'Something went wrong!',
        type: SnackBarType.error,
      );

      return;
    } else if ((totalPrice != getPricingData.pricingData?.total) ||
        (totalPrice != lockPricingData?.total) ||
        (getPricingData.pricingData?.total != lockPricingData?.total)) {
      Get.back();
      CustomSnackBar.show(
        context: context,
        message: 'Please check out again as the price has been updated for your slots.',
        type: SnackBarType.error,
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    registrationNotifier
        .registerGuest(
          referralSource: widget.referralSource,
          lobbyId: widget.lobbyId,
          name: _nameController.text,
          mobile: _mobileController.text,
          email: _emailController.text,
          slots: slotCount,
          userId: userId,

          // form: null,
          // formList: null,
          selectedTickets: currentLobbyTickets.isNotEmpty ? currentLobbyTickets.map((e) => e.toJson()).toList() : null,
        )
        .then((response) async {
          setState(() {
            _isProcessing = false;
          });

          if (response != null && response.paymentUrl != null) {
            // Show success message
            CustomSnackBar.show(
              context: context,
              message: 'Registration successful! Redirecting to payment...',
              type: SnackBarType.success,
            );

            // Redirect to payment URL
            await _redirectToPaymentUrl(response.paymentUrl!);
          } else {
            // Show error message
            CustomSnackBar.show(
              context: context,
              message: 'Failed to register. Please try again.',
              type: SnackBarType.error,
            );
          }
        })
        .catchError((error) {
          setState(() {
            _isProcessing = false;
          });

          // Show error message
          CustomSnackBar.show(context: context, message: 'Error: ${error.toString()}', type: SnackBarType.error);
        });
  }

  // Method to redirect to payment URL
  Future<void> _redirectToPaymentUrl(String url) async {
    if (url == "FREE_EVENT_JOINED") {
      await Get.dialog(
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
                      height: 0.2 * Get.height,
                      width: 0.9 * Get.width,
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
                    Space.h(height: 8),
                    DesignText(
                      text:
                          "A detailed confirmation email will be sent to your registered email address, including important event information, venue details, and your unique booking reference. Please check your inbox (and spam folder) within the next few minutes.",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: DesignColors.secondary,
                      maxLines: null,
                      overflow: TextOverflow.visible,
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
      FancyAppDownloadDialog.show(
        context,
        title: "Unlock Premium Features",
        message: "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
        appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
        playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
        cancelButtonText: "Not Now",
        onCancel: () {
          Get.toNamed(AppRoutes.lobby.replaceAll(":lobbyId", widget.lobbyId));
        },
      );
      return;
    }

    // Use the url_launcher package to open the URL
    // For web, we can use window.open
    if (kIsWeb) {
      html.window.open(url, 'checkout');
    } else {
      // For mobile, we would use url_launcher
      // But for now, just show a message
      CustomSnackBar.show(context: context, message: 'Payment URL: $url', type: SnackBarType.info);
    }
  }

  // Build the desktop layout with side-by-side content
  Widget _buildDesktopLayout(BuildContext context, Lobby lobbyData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side with lobby details
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _buildLobbyDetailsCard(context, lobbyData),
                      _buildAdditionalLobbyDetails(context, lobbyData),
                    ],
                  ),
                ),
              ),
              // Checkout form section - takes 50% of the width
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildCheckoutForm(context, lobbyData),
                    ResponsiveAppDownloadCard(
                      appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                      playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                      description:
                          "AroundU is more than just this event. Check out other events, join the group chat, or start your own lobby!",
                      // onClose: () {
                      //   FancyAppDownloadDialog.show(
                      //     context,
                      //     title: "Unlock Premium Features",
                      //     message:
                      //         "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
                      //     appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
                      //     playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
                      //     // cancelButtonText: "Maybe Later",
                      //     onCancel: () {
                      //       print("User chose to skip download");
                      //     },
                      //   );
                      // },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build the mobile layout with stacked content
  Widget _buildMobileLayout(BuildContext context, Lobby lobbyData) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lobby details card
          _buildLobbyDetailsCard(context, lobbyData),
          // Additional lobby details for mobile view
          _buildAdditionalLobbyDetails(context, lobbyData),
          // Checkout form
          _buildCheckoutForm(context, lobbyData),
          ResponsiveAppDownloadCard(
            appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
            playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
            description:
                "AroundU is more than just this event. Check out other events, join the group chat, or start your own lobby!",
            // onClose: () {
            //   FancyAppDownloadDialog.show(
            //     context,
            //     title: "Unlock Premium Features",
            //     message: "Get the full AroundU experience with exclusive features, enhanced performance, and more!",
            //     appStoreUrl: "https://apps.apple.com/in/app/aroundu/id6744299663",
            //     playStoreUrl: "https://play.google.com/store/apps/details?id=com.polar.aroundu",
            //     // cancelButtonText: "Maybe Later",
            //     onCancel: () {
            //       print("User chose to skip download");
            //     },
            //   );
            // },
          ),
          
        ],
      ),
    );
  }

  // Build additional lobby details section for mobile view
  Widget _buildAdditionalLobbyDetails(BuildContext context, Lobby lobbyData) {
    return Container(
      padding: EdgeInsets.all(16),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          color: DesignColors.bgDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DesignText(
                  text: 'Additional Details',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: DesignColors.primaryFontDark,
                ),
                SizedBox(height: 16),

                // Date and time info if available
                if (lobbyData.filter?.otherFilterInfo?.dateInfo != null) ...[
                  _buildInfoItem(
                    lobbyData.filter!.otherFilterInfo!.dateInfo!.iconUrl ?? "",
                    lobbyData.filter!.otherFilterInfo!.dateInfo!.title,
                    lobbyData
                            .filter!
                            .otherFilterInfo!
                            .dateInfo!
                            .formattedDate ??
                        "",
                  ),
                  SizedBox(height: 12),
                ],

                // Date range info if available
                if (lobbyData.filter?.otherFilterInfo?.dateRange != null) ...[
                  _buildInfoItem(
                    lobbyData.filter!.otherFilterInfo!.dateRange!.iconUrl ?? "",
                    lobbyData.filter!.otherFilterInfo!.dateRange!.title,
                    lobbyData
                            .filter!
                            .otherFilterInfo!
                            .dateRange!
                            .formattedDateCompactView ??
                        "",
                  ),
                  SizedBox(height: 12),
                ],

                // Location info if available
                if (lobbyData.filter?.otherFilterInfo?.pickUp != null) ...[
                  _buildInfoItem(
                    lobbyData.filter!.otherFilterInfo!.pickUp!.iconUrl ?? "",
                    lobbyData.filter!.otherFilterInfo!.pickUp!.title ?? "",
                    lobbyData
                            .filter!
                            .otherFilterInfo!
                            .pickUp!
                            .locationResponse
                            ?.fuzzyAddress ??
                        "",
                  ),
                  SizedBox(height: 12),
                ],

                // Destination info if available
                if (lobbyData.filter?.otherFilterInfo?.destination != null) ...[
                  _buildInfoItem(
                    lobbyData.filter!.otherFilterInfo!.destination!.iconUrl ??
                        "",
                    lobbyData.filter!.otherFilterInfo!.destination!.title ?? "",
                    lobbyData
                            .filter!
                            .otherFilterInfo!
                            .destination!
                            .locationResponse
                            ?.fuzzyAddress ??
                        "",
                  ),
                  SizedBox(height: 12),
                ],

                // Location info with map link if available
                if (lobbyData.filter?.otherFilterInfo?.locationInfo !=
                    null) ...[
                  Divider(height: 24, color: DesignColors.secondary),
                  DesignText(
                    text: 'Location',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DesignColors.primaryFontDark,
                  ),
                  SizedBox(height: 8),
                  _buildLocationInfoItem(context, lobbyData),
                  if ((lobbyData
                          .filter!
                          .otherFilterInfo!
                          .locationInfo!
                          .hideLocation) &&
                      ((lobbyData.userStatus != "MEMBER") ||
                          (lobbyData.userStatus != "ADMIN"))) ...[
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DesignText(
                        text:
                            'Note: This is an approximate location. The exact address will be provided via email with your QR ticket and invoice for privacy reasons.',
                        fontSize: 12,
                        color: DesignColors.accent,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                        maxLines: null,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                  SizedBox(height: 16),
                ],

                // Multiple locations if available
                if (lobbyData.filter?.otherFilterInfo?.multipleLocations !=
                    null) ...[
                  Divider(height: 24, color: Colors.grey.shade200),
                  DesignText(
                    text:
                        lobbyData
                            .filter!
                            .otherFilterInfo!
                            .multipleLocations
                            ?.title ??
                        'Multiple Locations',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DesignColors.primaryFontDark,
                  ),
                  SizedBox(height: 8),
                  _buildLocationSection(lobbyData),
                  SizedBox(height: 16),
                ],

                // Scrollable info cards
                Divider(height: 24, color: DesignColors.secondary),
                DesignText(
                  text: 'Lobby Information',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: DesignColors.primaryFontDark,
                ),
                SizedBox(height: 12),
                _buildScrollableInfoCards(lobbyData),
                SizedBox(height: 16),

                // Host information
                Divider(height: 24, color: DesignColors.secondary),
                DesignText(
                  text: 'Host',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: DesignColors.primaryFontDark,
                ),
                SizedBox(height: 12),
                _buildHostInfo(lobbyData),
                SizedBox(height: 16),

                // Filter information if available
                if (lobbyData.filter?.filterInfoList != null &&
                    lobbyData.filter!.filterInfoList!.isNotEmpty) ...[
                  Divider(height: 24, color: DesignColors.secondary),
                  DesignText(
                    text: 'Preferences',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DesignColors.primaryFontDark,
                  ),
                  SizedBox(height: 12),
                  _buildFilterInfoList(context, lobbyData),
                  SizedBox(height: 16),
                ],
                // Space.h(height: 34),
                 if (lobbyData.content != null)
                Divider(height: 24, color: DesignColors.secondary),
                Row(
                  children: [
                    if (lobbyData.content != null)
                      DesignText(
                        text: lobbyData.content?.title ?? "Guidelines",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: DesignColors.primaryFontDark,
                      ),
                  ],
                ),
                if (lobbyData.content != null) ...[
                  Space.h(height: 16),
                  NewLobbyContentSection(
                    content: lobbyData.content!,
                    height: 356,
                    isDark: true,
                  ),
                ],
                Space.h(height: 16),

                // Lobby status
                Divider(height: 24, color: DesignColors.secondary),
                _buildStatusItem(lobbyData.lobbyStatus ?? "ACTIVE"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build info item with icon, title and subtitle
  Widget _buildInfoItem(String iconUrl, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: DesignColors.secondaryDark,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.05),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Image.network(
            iconUrl,
            width: 24,
            height: 24,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.info_outline,
                size: 24,
                color: DesignColors.primaryFontDark,
              );
            },
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesignText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: DesignColors.primaryFontDark,
              ),
              SizedBox(height: 4),
              DesignText(
                text: subtitle,
                fontSize: 14,
                color: DesignColors.secondaryFontDark,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build status item
  Widget _buildStatusItem(String status) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case "UPCOMING":
        statusColor = Color(0xFF52D17C);
        statusText = "Upcoming";
        statusIcon = Icons.run_circle_outlined;
        break;
      case "PAST":
        statusColor = Color(0xFFF97853);
        statusText = "Past";
        statusIcon = Icons.event_busy;
        break;
      case "CLOSED":
        statusColor = Color(0xFF3E79A1);
        statusText = "Closed";
        statusIcon = Icons.lock_outline;
        break;
      case "FULL":
        statusColor = Color(0xFFF97853);
        statusText = "Full";
        statusIcon = Icons.people;
        break;
      default: // ACTIVE
        statusColor = Color(0xFF52D17C);
        statusText = "Active";
        statusIcon = Icons.check_circle_outline;
        break;
    }

    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: statusColor.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 18, color: statusColor),
          SizedBox(width: 8),
          DesignText(text: statusText, fontSize: 14, fontWeight: FontWeight.w600, color: statusColor),
        ],
      ),
    );
  }

  // Helper method to build location info with map link
  Widget _buildLocationInfoItem(BuildContext context, Lobby lobbyData) {
    final locationInfo = lobbyData.filter?.otherFilterInfo?.locationInfo;

    return GestureDetector(
      onTap: () async {
        print("object");
        double lat = 0.0;
        double lng = 0.0;

        if (locationInfo != null &&
            locationInfo!.locationResponses.isNotEmpty) {
          if ((locationInfo!.hideLocation) &&
              ((lobbyData.userStatus != "MEMBER") ||
                  (lobbyData.userStatus != "ADMIN"))) {
            lat =
                locationInfo?.locationResponses.first.approxLocation?.lat ??
                0.0;
            lng =
                locationInfo?.locationResponses.first.approxLocation?.lon ??
                0.0;
          } else {
            lat =
                locationInfo?.locationResponses.first.exactLocation?.lat ?? 0.0;
            lng =
                locationInfo?.locationResponses.first.exactLocation?.lon ?? 0.0;
          }
        }

        // Only proceed if we have valid coordinates
        if (lat != 0.0 || lng != 0.0) {
          Uri? mapsUri;
          bool launched = false;
          kLogger.trace("lat : $lat \n lng : $lng");

          if (kIsWeb) {
            // For web platform, open Google Maps in new tab
            mapsUri = Uri.parse(
              'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
            );
            html.window.open(mapsUri.toString(), '_blank');
            launched = true;
          } else if (Platform.isAndroid) {
            // Try Android's native maps app first
            mapsUri = Uri.parse(
              'http://maps.google.com/maps?z=12&t=m&q=$lat,$lng',
            );
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
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Approximate location
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: DesignColors.accent,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DesignText(
                        text: 'Location',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DesignColors.accent,
                      ),
                      SizedBox(height: 4),
                      DesignText(
                        text:
                            ((locationInfo!.hideLocation) &&
                                ((lobbyData.userStatus != "MEMBER") ||
                                    (lobbyData.userStatus != "ADMIN")))
                            ? (locationInfo
                                      ?.locationResponses
                                      .first
                                      .fuzzyAddress ??
                                  'Unknown location')
                            : (locationInfo
                                      ?.googleSearchResponses
                                      ?.first
                                      ?.description ??
                                  'Unknown location'),
                        fontSize: 14,
                        maxLines: null,
                        overflow: TextOverflow.visible,

                        color: DesignColors.accent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to launch maps
  void _launchMaps(double latitude, double longitude) async {
    final url = kIsWeb
        ? 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude'
        : Platform.isIOS
        ? 'https://maps.apple.com/?q=$latitude,$longitude'
        : 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      print('Could not launch maps: $e');
    }
  }

  // Helper method to build location section with multiple locations
  Widget _buildLocationSection(Lobby lobbyData) {
    final multipleLocations =
        lobbyData.filter?.otherFilterInfo?.multipleLocations;
    if (multipleLocations == null ||
        multipleLocations.locationResponses == null ||
        multipleLocations.locationResponses!.isEmpty) {
      return SizedBox.shrink();
    }

    // Remove duplicates
    final uniqueLocations = <String>{};
    final filteredLocations = multipleLocations.locationResponses!.where((
      location,
    ) {
      final isUnique = !uniqueLocations.contains(location);
      if (isUnique) uniqueLocations.add(location.fuzzyAddress);
      return isUnique;
    }).toList();

    // Determine how many locations to show based on expanded state
    final isExpanded = ref.watch(isLocationsExpandedProvider(lobbyData.id));
    final locationsToShow = isExpanded
        ? filteredLocations
        : filteredLocations.take(2).toList();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...locationsToShow.map(
            (location) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: DesignColors.accent,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DesignText(
                      text: location.fuzzyAddress,
                      fontSize: 14,
                      color: DesignColors.primaryFontDark,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Show more/less button if there are more than 2 locations
          if (filteredLocations.length > 2) ...[
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                ref
                        .read(
                          isLocationsExpandedProvider(lobbyData.id).notifier,
                        )
                        .state =
                    !isExpanded;
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: DesignColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DesignText(
                      text: isExpanded ? 'Show Less' : 'Show More',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: DesignColors.secondaryFontDark,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 16,
                      color: DesignColors.secondaryFontDark,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Helper method to build scrollable info cards
  Widget _buildScrollableInfoCards(Lobby lobbyData) {
    final List<InfoCard> infoCards = [];

    // Add refund policy if available
    if (lobbyData.priceDetails.isRefundAllowed != null) {
      infoCards.add(
        InfoCard(
          icon: Icons.policy_outlined,
          title: 'Refund Policy',
          subtitle: (lobbyData.priceDetails.isRefundAllowed)
              ? "Refund is available"
              : "Refund is not available",
        ),
      );
    }

    // Add lobby size if available
    if (lobbyData.totalMembers != null) {
      infoCards.add(
        InfoCard(
          icon: Icons.people_outline,
          title: 'Lobby Size',
          subtitle: '${lobbyData.totalMembers} people',
        ),
      );
    }

    // Add age limit if available
    if (lobbyData.filter.otherFilterInfo.range != null) {
      infoCards.add(
        InfoCard(
          icon: Icons.person_outline,
          title: 'Age Limit',
          subtitle:
              "${lobbyData.filter.otherFilterInfo.range?.min ?? 0} to ${lobbyData.filter.otherFilterInfo.range?.max ?? 0} ",
        ),
      );
    }

    // Add additional info cards as needed

    return infoCards.isEmpty
        ? DesignText(
            text: 'No additional information available',
            fontSize: 14,
            color: DesignColors.secondaryFontDark,
          )
        : ScrollableInfoCards(cards: infoCards);
  }

  // Helper method to build host information
  Widget _buildHostInfo(Lobby lobbyData) {
    final hostName =
        lobbyData.houseDetail?.name ?? lobbyData.adminSummary?.name ?? 'Host';
    final hostImage =
        lobbyData.houseDetail?.profilePhoto ??
        lobbyData.adminSummary?.profilePictureUrl ??
        '';

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Host profile picture
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: DesignColors.primary.withOpacity(0.1),
            ),
            child: hostImage.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      hostImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person, color: DesignColors.secondary);
                      },
                    ),
                  )
                : Icon(Icons.person, color: DesignColors.secondary),
          ),
          SizedBox(width: 12),
          // Host name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DesignText(
                  text: hostName,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: DesignColors.primaryFontDark,
                ),
                DesignText(
                  text: 'Host',
                  fontSize: 14,
                  color: DesignColors.secondaryFontDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build filter info list
  Widget _buildFilterInfoList(BuildContext context, Lobby lobbyData) {
    final filterInfoList = lobbyData.filter?.filterInfoList;
    if (filterInfoList == null || filterInfoList.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ...filterInfoList.asMap().entries.map((entry) {
            final index = entry.key;
            final filterInfo = entry.value;

            return Column(
              children: [
                if (index > 0)
                  Divider(
                    height: 16,
                    thickness: 1,
                    color: DesignColors.secondary,
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: DesignColors.secondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child:
                            filterInfo.iconUrl != null &&
                                filterInfo.iconUrl!.isNotEmpty
                            ? DesignText(
                                text: filterInfo.iconUrl ?? "",
                                fontSize: 24,
                                color: DesignColors.primaryFontDark,
                              )
                            : Icon(
                                Icons.info_outline,
                                color: DesignColors.primaryFontDark,
                                size: 16,
                              ),
                      ),
                    ),
                    SizedBox(width: 12),
                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DesignText(
                            text: filterInfo.title ?? 'Information',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: DesignColors.primaryFontDark,
                          ),
                          SizedBox(height: 4),
                          DesignText(
                            text: filterInfo.options.join(', ') ?? '',
                            fontSize: 14,
                            color: DesignColors.primaryFontDark,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  // Build the lobby details card
  Widget _buildLobbyDetailsCard(BuildContext context, Lobby lobbyData) {
    final deviceType = DesignUtils.getDeviceType(context);
    final isDesktop = deviceType == DeviceScreenType.desktop;
    final padding = isDesktop ? EdgeInsets.all(24) : EdgeInsets.all(16);

    return Container(
      padding: padding,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          elevation: 2,
          color: DesignColors.bgDark,
          shadowColor: Colors.white24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lobby title
                DesignText(
                  text: lobbyData.title ?? 'Untitled Lobby',
                  fontSize: isDesktop ? 24 : 20,
                  fontWeight: FontWeight.bold,
                  color: DesignColors.primaryFontDark,
                ),
                SizedBox(height: 16),

                // Lobby image if available
                if (lobbyData.mediaUrls != null &&
                    lobbyData.mediaUrls!.isNotEmpty)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double imageHeight = (constraints.maxWidth * 900) / 1430;
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: Get.height * 0.7,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            (lobbyData.mediaUrls!.first.toLowerCase().contains(
                                      '.png',
                                    ) ||
                                    lobbyData.mediaUrls!.first
                                        .toLowerCase()
                                        .contains('.jpeg') ||
                                    lobbyData.mediaUrls!.first
                                        .toLowerCase()
                                        .contains('.jpg'))
                                ? lobbyData.mediaUrls!.first
                                : "https://images.weserv.nl/?url=${Uri.encodeComponent(lobbyData.mediaUrls!.first)}&w=640&h=640&fit=cover&output=webp&q=30&l=9&il&af=auto",
                            // height: imageHeight,
                            width: double.infinity,
                            fit: BoxFit.fitHeight,

                            // This handles the actual rendering/painting of the image
                            frameBuilder:
                                (
                                  context,
                                  child,
                                  frame,
                                  wasSynchronouslyLoaded,
                                ) {
                                  if (wasSynchronouslyLoaded) {
                                    // Image loaded synchronously (from cache)
                                    return child;
                                  }

                                  // Image is still being painted/rendered
                                  if (frame == null) {
                                    return Container(
                                      height: imageHeight,
                                      width: double.infinity,
                                      color: DesignColors.secondaryDark,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(
                                              color: DesignColors.accent,
                                              strokeWidth: 3,
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Loading...',
                                              style: TextStyle(
                                                color: DesignColors
                                                    .secondaryFontDark,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  // Image frame is ready, show it
                                  return child;
                                },

                            // This handles network loading progress
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                // Network loading complete, but frameBuilder will handle the rest
                                return child;
                              }

                              // Still downloading from network
                              return Container(
                                height: imageHeight,
                                width: double.infinity,
                                color: DesignColors.secondaryDark,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: DesignColors.accent,
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },

                            errorBuilder: (context, error, stackTrace) {
                              kLogger.trace(
                                "Failed to load image: $error \n $stackTrace",
                              );
                              return Container(
                                height: imageHeight,
                                width: double.infinity,
                                color: DesignColors.secondaryDark,
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: DesignColors.secondaryFontDark,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                SizedBox(height: 24),

                // Lobby description
                DesignText(
                  text: 'Description',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: DesignColors.primaryFontDark,
                ),
                RichTextDisplay(
                  controller: TextEditingController(
                    text: lobbyData.description,
                  ),
                  hintText: '',
                  fontColor: DesignColors.primaryFontDark,
                  // lobbyId: lobbyData.id,
                  maxHeight: 10 * Get.height,
                  scrollable: false,
                ),

                // Lobby details in a grid
                // _buildLobbyDetailsGrid(lobbyData, isDesktop),

                // // Price details if available
                // if (lobbyData.priceDetails != null)
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(height: 16),
                //       Divider(),
                //       SizedBox(height: 16),
                //       DesignText(
                //         text: 'Price Details',
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //         color: DesignColors.primary,
                //       ),
                //       SizedBox(height: 8),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           DesignText(text: 'Price per slot:', fontSize: 16, color: DesignColors.secondary),
                //           DesignText(
                //             text: '₹${lobbyData.priceDetails?.price ?? 0}',
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //             color: DesignColors.primary,
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build a grid of lobby details
  Widget _buildLobbyDetailsGrid(Lobby lobbyData, bool isDesktop) {
    return GridView.count(
      crossAxisCount: isDesktop ? 3 : 2,
      childAspectRatio: isDesktop ? 2.4 : 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        // Total members
        _buildDetailItem('Total Members', '${lobbyData.totalMembers ?? 0}', Icons.group),
        // Current members
        _buildDetailItem('Current Members', '${lobbyData.currentMembers ?? 0}', Icons.person),
        // Members required
        _buildDetailItem('Members Required', '${lobbyData.membersRequired ?? 0}', Icons.person_add),
        // Lobby type
        _buildDetailItem('Lobby Type', lobbyData.lobbyType ?? 'Unknown', Icons.category),
      ],
    );
  }

  // Build a single detail item for the grid
  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: DesignColors.accent, size: 14),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DesignText(
                  text: label,
                  fontSize: 12,
                  color: DesignColors.secondary,
                ),
                DesignText(
                  text: value,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: DesignColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build the checkout form
  Widget _buildCheckoutForm(BuildContext context, Lobby lobbyData) {
    final deviceType = DesignUtils.getDeviceType(context);
    final isDesktop = deviceType == DeviceScreenType.desktop;
    final padding = isDesktop ? EdgeInsets.all(24) : EdgeInsets.all(16);
    final slotCount = ref.watch(quickCheckoutCounterProvider);
    // final slotPrice = lobbyData.priceDetails?.price ?? 0.0;

    final selectedTickets = ref.watch(selectedTicketsProvider);
    final currentLobbyTickets = selectedTickets[widget.lobbyId] ?? [];

    // Use proper Riverpod state management with watch
    final pricingState = ref.watch(pricingProvider(widget.lobbyId));

    final slotPrice = pricingState.pricingData?.currentPricePerSlot ?? lobbyData.priceDetails?.price ?? 0.0;

    // Check if lobby is active or upcoming
    final bool isLobbyAvailable = lobbyData.lobbyStatus == "ACTIVE" || lobbyData.lobbyStatus == "UPCOMING";
    final double totalPrice = (!lobbyData.isAdvancedPricing)
        ? slotPrice * slotCount
        : (currentLobbyTickets.isNotEmpty)
        ? currentLobbyTickets.fold<double>(0, (sum, ticket) {
            // Find matching ticket option by ID
            final ticketOption = lobbyData.ticketOptions.firstWhere((option) => option.id == ticket.ticketId);

            // Calculate price for this ticket
            final price = ticketOption?.price ?? 0;
            final slots = ticket.slots ?? 1;

            // Add to running total
            return sum + (slots * price).toInt();
          })
        : 0.0;

    return Container(
      key: _targetKey,
      padding: padding,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          color: DesignColors.bgDark,
          shadowColor: Colors.white24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: isLobbyAvailable
                ? Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Form title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              DesignText(
                                text: 'Checkout',

                                fontSize: isDesktop ? 24 : 20,
                                fontWeight: FontWeight.bold,
                                color: DesignColors.primaryFontDark,
                              ),
                              if (lobbyData.priceDetails.originalPrice <= 0)
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF52D17C).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: Color(0xFF52D17C).withOpacity(0.5),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.money_off,
                                        size: 18,
                                        color: Color(0xFF52D17C),
                                      ),
                                      SizedBox(width: 8),
                                      DesignText(
                                        text: "Free",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF52D17C),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 20),

                          // Personal Information Section
                          Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: DesignColors.bgDark,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.05),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              border: Border.all(
                                color: DesignColors.secondary,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section Title
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person_pin_circle_outlined,
                                      color: DesignColors.accent,
                                      size: 24,
                                    ),
                                    SizedBox(width: 12),
                                    DesignText(
                                      text: 'Personal Information',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: DesignColors.primaryFontDark,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),

                                // Name Field
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DesignText(
                                          text: 'Full Name',
                                          fontSize: 14,
                                          color: DesignColors.primaryFontDark,
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),

                                          ),
                                          child: DesignTextField(
                                            controller: _nameController,
                                            hintText: 'Enter your full name',
                                            borderRadius: 16,
                                            fillColor: DesignColors.secondaryDark,
                                            hasBorder: false,
                                            fontColor: DesignColors.primaryFontDark,
                                            prefixIcon: Icon(
                                              Icons.person_outline,
                                              color: DesignColors.secondary,
                                            ),
                                            onChanged: (value) {},
                                            onEditingComplete: () {
                                              if (_nameController
                                                  .text
                                                  .isEmpty) {
                                                CustomSnackBar.show(
                                                  context: context,
                                                  message:
                                                      'Please enter your name',
                                                  type: SnackBarType.warning,
                                                );
                                              }
                                              return;
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(height: 20),

                                // Email Field
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DesignText(
                                          text: 'Email Address',
                                          fontSize: 14,
                                          color: DesignColors.primaryFontDark,
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),

                                          ),
                                          child: DesignTextField(
                                            controller: _emailController,
                                            hintText:
                                                'Enter your email address',
                                            inputType:
                                                TextInputType.emailAddress,
                                                fillColor: DesignColors.secondaryDark,
                                                hasBorder: false,
                                                fontColor: DesignColors.primaryFontDark,
                                            borderRadius: 16,
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
                                              color: DesignColors.secondary,
                                            ),
                                            onEditingComplete: () {
                                              if (!RegExp(
                                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                              ).hasMatch(
                                                _emailController.text,
                                              )) {
                                                CustomSnackBar.show(
                                                  context: context,
                                                  message:
                                                      'Please enter a valid email address',
                                                  type: SnackBarType.warning,
                                                );
                                                return;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(height: 20),

                                // Mobile Field
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DesignText(
                                          text: 'Mobile Number',
                                          fontSize: 14,
                                          color: DesignColors.primaryFontDark,
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),

                                          ),
                                          child: DesignTextField(
                                            controller: _mobileController,
                                            hintText:
                                                'Enter your 10-digit mobile number',
                                            inputType: TextInputType.number,
                                            fillColor: DesignColors.secondaryDark,
                                            hasBorder: false,
                                            fontColor: DesignColors.primaryFontDark,
                                            borderRadius: 16,
                                            prefixIcon: Icon(
                                              Icons.phone_outlined,
                                              color: DesignColors.secondary,
                                            ),
                                            onEditingComplete: () {
                                              String value =
                                                  _mobileController.text;
                                              if (value == null ||
                                                  value.isEmpty) {
                                                CustomSnackBar.show(
                                                  context: context,
                                                  message:
                                                      'Please enter your mobile number',
                                                  type: SnackBarType.warning,
                                                );
                                                return;
                                              }

                                              if (!RegExp(
                                                r'^\d+$',
                                              ).hasMatch(value)) {
                                                CustomSnackBar.show(
                                                  context: context,
                                                  message:
                                                      'Please enter numbers only',
                                                  type: SnackBarType.warning,
                                                );

                                                _mobileController.text = value
                                                    .substring(
                                                      0,
                                                      value.length - 1,
                                                    );
                                                _mobileController.selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(
                                                        offset:
                                                            _mobileController
                                                                .text
                                                                .length,
                                                      ),
                                                    );
                                                return;
                                              }

                                              if (_mobileController
                                                      .text
                                                      .length >
                                                  10) {
                                                _mobileController.text = value
                                                    .substring(
                                                      0,
                                                      value.length - 1,
                                                    );
                                                _mobileController.selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(
                                                        offset:
                                                            _mobileController
                                                                .text
                                                                .length,
                                                      ),
                                                    );
                                                CustomSnackBar.show(
                                                  context: context,
                                                  message:
                                                      'Please enter a valid 10-digit mobile number',
                                                  type: SnackBarType.warning,
                                                );
                                                return;
                                              }

                                              if (value != null &&
                                                  value.isNotEmpty) {
                                                if (!RegExp(
                                                  r'^[0-9]*$',
                                                ).hasMatch(value)) {
                                                  _mobileController.text = value
                                                      .replaceAll(
                                                        RegExp(r'[^0-9]'),
                                                        '',
                                                      );
                                                  _mobileController.selection =
                                                      TextSelection.fromPosition(
                                                        TextPosition(
                                                          offset:
                                                              _mobileController
                                                                  .text
                                                                  .length,
                                                        ),
                                                      );
                                                }
                                              }
                                            },
                                            onChanged: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return;
                                              }

                                              if (!RegExp(
                                                r'^\d+$',
                                              ).hasMatch(value)) {
                                                CustomSnackBar.show(
                                                  context: context,
                                                  message:
                                                      'Please enter numbers only',
                                                  type: SnackBarType.warning,
                                                );

                                                _mobileController.text = value
                                                    .substring(
                                                      0,
                                                      value.length - 1,
                                                    );
                                                _mobileController.selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(
                                                        offset:
                                                            _mobileController
                                                                .text
                                                                .length,
                                                      ),
                                                    );

                                                return;
                                              }

                                              if (_mobileController
                                                      .text
                                                      .length >
                                                  10) {
                                                _mobileController.text = value
                                                    .substring(
                                                      0,
                                                      value.length - 1,
                                                    );
                                                _mobileController.selection =
                                                    TextSelection.fromPosition(
                                                      TextPosition(
                                                        offset:
                                                            _mobileController
                                                                .text
                                                                .length,
                                                      ),
                                                    );
                                                CustomSnackBar.show(
                                                  context: context,
                                                  message:
                                                      'Please enter a valid 10-digit mobile number',
                                                  type: SnackBarType.warning,
                                                );
                                                return;
                                              }

                                              if (value != null &&
                                                  value.isNotEmpty) {
                                                if (!RegExp(
                                                  r'^[0-9]*$',
                                                ).hasMatch(value)) {
                                                  _mobileController.text = value
                                                      .replaceAll(
                                                        RegExp(r'[^0-9]'),
                                                        '',
                                                      );
                                                  _mobileController.selection =
                                                      TextSelection.fromPosition(
                                                        TextPosition(
                                                          offset:
                                                              _mobileController
                                                                  .text
                                                                  .length,
                                                        ),
                                                      );
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),

                          // Slot counter
                          if (!lobbyData.isAdvancedPricing && lobbyData.priceDetails.originalPrice > 0)
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: DesignColors.bgDark,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: DesignColors.secondary, width: 1),
                                boxShadow: [
                                  BoxShadow(color: Colors.white.withOpacity(0.03), blurRadius: 8, offset: Offset(0, 2)),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DesignText(
                                    text: 'Number of Slots',

                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: DesignColors.primaryFontDark,
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Decrement button
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: StatefulBuilder(
                                          builder: (context, setState) {
                                            bool isHovered = false;
                                            return InkWell(
                                              onTap: () async {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor: Colors.transparent,
                                                      content: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          CircularProgressIndicator(color: DesignColors.accent),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                                await ref
                                                    .read(pricingProvider(lobbyData.id).notifier)
                                                    .updateGroupSize(lobbyData.id, slotCount - 1);
                                                ref.read(quickCheckoutCounterProvider.notifier).decrement();
                                                Navigator.of(context, rootNavigator: true).pop();
                                              },
                                              onHover: (hover) {
                                                setState(() {
                                                  isHovered = hover;
                                                });
                                              },
                                              child: AnimatedContainer(
                                                height: 40,
                                                width: 40,
                                                duration: Duration(milliseconds: 150),
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: isHovered
                                                      ? DesignColors.primary.withOpacity(0.05)
                                                      : DesignColors.secondaryDark,
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(color: DesignColors.secondary),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.05),
                                                      blurRadius: 2,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(Icons.remove, color: DesignColors.primaryFontDark),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Slot count display
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: DesignColors.secondaryDark,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: AnimatedDefaultTextStyle(
                                            duration: Duration(milliseconds: 200),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: DesignColors.primaryFontDark,
                                            ),
                                            child: DesignText(
                                              text: '$slotCount',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: DesignColors.primaryFontDark,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Increment button
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: StatefulBuilder(
                                          builder: (context, setState) {
                                            bool isHovered = false;
                                            return InkWell(
                                              onTap: () async {
                                                if (pricingState.pricingData?.remainingSlots != null &&
                                                    slotCount + 1 > pricingState.pricingData!.remainingSlots!) {
                                                  CustomSnackBar.show(
                                                    context: context,
                                                    message: 'No more slots available',
                                                    type: SnackBarType.warning,
                                                  );
                                                  return;
                                                }

                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor: Colors.transparent,
                                                      content: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          CircularProgressIndicator(color: DesignColors.accent),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                                final PricingResponse? cachedPricingData = pricingState.pricingData;
                                                await ref
                                                    .read(pricingProvider(lobbyData.id).notifier)
                                                    .updateGroupSize(lobbyData.id, slotCount + 1);
                                                kLogger.info(
                                                  "${ref.read(pricingProvider(lobbyData.id)).pricingData?.toJson()}",
                                                );
                                                if (ref.read(pricingProvider(lobbyData.id)).pricingData == null ||
                                                    ref
                                                            .read(pricingProvider(lobbyData.id))
                                                            .pricingData
                                                            ?.status
                                                            ?.toLowerCase() !=
                                                        'success') {
                                                  CustomSnackBar.show(
                                                    context: context,
                                                    message:
                                                        ref.read(pricingProvider(lobbyData.id)).pricingData?.message ??
                                                        'Failed to increase slots',
                                                    type: SnackBarType.error,
                                                  );
                                                  if (cachedPricingData != null) {
                                                    ref
                                                        .read(pricingProvider(lobbyData.id).notifier)
                                                        .updatePricingDataInState(cachedPricingData!);
                                                  }

                                                  Navigator.of(context, rootNavigator: true).pop();
                                                  return;
                                                }

                                                ref.read(quickCheckoutCounterProvider.notifier).increment();
                                                Navigator.of(context, rootNavigator: true).pop();
                                              },
                                              onHover: (hover) {
                                                setState(() {
                                                  isHovered = hover;
                                                });
                                              },
                                              child: AnimatedContainer(
                                                height: 40,
                                                width: 40,
                                                duration: Duration(milliseconds: 150),
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: isHovered
                                                      ? DesignColors.primary.withOpacity(0.05)
                                                      : DesignColors.secondaryDark,
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(color: DesignColors.secondary),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.white.withOpacity(0.05),
                                                      blurRadius: 2,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(Icons.add, size: 20, color: DesignColors.primaryFontDark),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          else if (lobbyData.isAdvancedPricing)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: lobbyData.ticketOptions.length,
                              itemBuilder: (context, index) {
                                final ticketOption = lobbyData.ticketOptions[index];
                                final isSelected = currentLobbyTickets.any((t) => t.ticketId == ticketOption.id);
                                final selectedTicket = currentLobbyTickets.firstWhere(
                                  (t) => t.ticketId == ticketOption.id,
                                  orElse: () => SelectedTicket(ticketId: '', name: '', slots: 0),
                                );
                                final hasActivity =
                                    (ticketOption.activity.isNotEmpty &&
                                    ticketOption.activity!.toUpperCase() != 'LOW' &&
                                    (ticketOption.activity!.toUpperCase() == 'HIGH' ||
                                        ticketOption.activity!.toUpperCase() == 'MID' ||
                                        ticketOption.activity!.toUpperCase() == 'FULL'));

                                return DisabledCardWrapper(
                                  isDisabled: ticketOption.isDisabled,
                                  margin: EdgeInsets.only(
                                    bottom: (index == lobbyData.ticketOptions.length - 1) ? 0 : 12,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      bottom: (index == lobbyData.ticketOptions.length - 1) ? 0 : 12,
                                    ),
                                    // padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: DesignColors.secondaryDark,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? DesignColors.accent
                                            : DesignColors.secondary,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        if (hasActivity)
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 6),

                                            decoration: BoxDecoration(
                                              color:
                                                  ticketOption.activity!
                                                          .toUpperCase() ==
                                                      'HIGH'
                                                  ? Colors.orange
                                                  : ticketOption.activity!
                                                            .toUpperCase() ==
                                                        'MID'
                                                  ? Colors.green
                                                  : ticketOption.activity!
                                                            .toUpperCase() ==
                                                        'FULL'
                                                  ? Colors.deepOrangeAccent
                                                  : DesignColors.secondary,
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                            ),
                                            child: Center(
                                              child: DesignText(
                                                text: ticketOption.activity!.toUpperCase() == 'HIGH'
                                                    ? 'Almost Full'
                                                    : ticketOption.activity!.toUpperCase() == 'MID'
                                                    ? 'Fast Filling'
                                                    : ticketOption.activity!.toUpperCase() == 'FULL'
                                                    ? 'Sold Out'
                                                    : ticketOption.activity!,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    ticketOption.activity!
                                                            .toUpperCase() ==
                                                        'HIGH'
                                                    ? Colors.orange.shade50
                                                    : ticketOption.activity!
                                                              .toUpperCase() ==
                                                          'MID'
                                                    ? Colors.green.shade50
                                                    : ticketOption.activity!
                                                              .toUpperCase() ==
                                                          'FULL'
                                                    ? Colors.deepOrangeAccent[50]
                                                    : DesignColors.secondaryFontDark,
                                              ),
                                            ),
                                          ),
                                        Padding(
                                         padding: hasActivity
                                              ? EdgeInsetsGeometry.fromLTRB(16, 8, 16, 16)
                                              : const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              DesignText(
                                                text: ticketOption.name,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: DesignColors.primaryFontDark,
                                                maxLines: 2,
                                              ),
                                              Space.h(height: 12),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  DesignText(
                                                    text: '₹${ticketOption.price.toStringAsFixed(2)}',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: DesignColors.primaryFontDark,
                                                  ),
                                                  if (!lobbyData.allowMultiplePricingOptions && !isSelected)
                                                    DesignButton(
                                                      onPress: () {
                                                        ref
                                                            .read(selectedTicketsProvider.notifier)
                                                            .addTicket(
                                                              lobbyId: widget.lobbyId,
                                                              isMultiplePricing: lobbyData.allowMultiplePricingOptions,
                                                              ticketOption: ticketOption,
                                                              slots: 1,
                                                            );
                                                      },
                                                      title: "ADD",
                                                      titleSize: 12,
                                                      titleColor: DesignColors.white,
                                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                                    )
                                                  else
                                                    Container(
                                                      padding: EdgeInsets.all(6),
                                                      constraints: BoxConstraints(
                                                        maxWidth: lobbyData.allowMultiplePricingOptions ? 96 : 80,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: DesignColors.accent,
                                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          if (lobbyData.allowMultiplePricingOptions ||
                                                              (isSelected && selectedTicket.slots > 0))
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  if (selectedTicket.slots > 0) {
                                                                    final newSlots = selectedTicket.slots - 1;
                                                                    if (newSlots == 0) {
                                                                      ref
                                                                          .read(selectedTicketsProvider.notifier)
                                                                          .removeTicket(
                                                                            lobbyId: widget.lobbyId,
                                                                            ticketId: ticketOption.id,
                                                                          );
                                                                    } else {
                                                                      ref
                                                                          .read(selectedTicketsProvider.notifier)
                                                                          .addTicket(
                                                                            lobbyId: widget.lobbyId,
                                                                            isMultiplePricing:
                                                                                lobbyData.allowMultiplePricingOptions,
                                                                            ticketOption: ticketOption,
                                                                            slots: newSlots,
                                                                          );
                                                                    }
                                                                  }
                                                                },
                                                                child: Icon(Icons.remove, size: 16, color: Colors.white),
                                                              ),
                                                            ),
                                                          if (lobbyData.allowMultiplePricingOptions ||
                                                              (isSelected && selectedTicket.slots > 0))
                                                            Space.w(width: 12),
                                                          Expanded(
                                                            child: DesignText(
                                                              text:
                                                                  !lobbyData.allowMultiplePricingOptions &&
                                                                      selectedTicket.slots == 0
                                                                  ? "ADD"
                                                                  : selectedTicket.slots.toString(),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.white,
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                          // if ( (selectedTicket.slots > 0))
                                                          Space.w(width: 12),
                                                          if ((selectedTicket.slots < ticketOption.maxQuantity))
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  final currentSlots = selectedTicket.slots;
                                                                  final maxSlots = ticketOption.maxQuantity;
                                                                  final newSlots = currentSlots + 1;
                                                                            
                                                                  if (newSlots <= maxSlots) {
                                                                    ref
                                                                        .read(selectedTicketsProvider.notifier)
                                                                        .addTicket(
                                                                          lobbyId: widget.lobbyId,
                                                                          isMultiplePricing:
                                                                              lobbyData.allowMultiplePricingOptions,
                                                                          ticketOption: ticketOption,
                                                                          slots: newSlots,
                                                                        );
                                                                  }
                                                                },
                                                                child: Icon(Icons.add, size: 16, color: Colors.white),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              //  Space(height: 4),
                                              Divider(color: DesignColors.secondary),
                                              //  Space(height: 4),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: DesignText(
                                                      text: ticketOption.description,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: DesignColors.primaryFontDark,
                                                      maxLines: null,
                                                      overflow: TextOverflow.visible,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 8),
                                                    child: DesignText(
                                                      text: "Max: ${ticketOption.maxQuantity}",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: DesignColors.accent,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          SizedBox(height: 24),

                          // Price summary
                          if ((!lobbyData.isAdvancedPricing || currentLobbyTickets.isNotEmpty) &&
                              lobbyData.priceDetails.originalPrice > 0)
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: DesignColors.bgDark,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: DesignColors.secondary,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.03),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  if (!lobbyData.isAdvancedPricing) ...[
                                    if (pricingState.pricingData?.pricingModel == 'TIERED_GROUP' &&
                                        pricingState.pricingData?.priceBreakdown != null &&
                                        pricingState.pricingData!.priceBreakdown!.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Parse and display individual pricing tiers
                                          ..._buildPricingTiers(pricingState.pricingData!.priceBreakdown!),
                                          SizedBox(height: 16),
                                          Divider(
                                            height: 1,
                                            color: DesignColors.secondary,
                                          ),
                                          SizedBox(height: 16),
                                          // Total section
                                          Container(
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  DesignColors.accent
                                                      .withOpacity(0.05),
                                                  DesignColors.accent
                                                      .withOpacity(0.02),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                color: DesignColors.secondary,
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    DesignText(
                                                      text: 'Total Amount',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: DesignColors.primaryFontDark,
                                                    ),
                                                    DesignText(
                                                      text: 'Including all slots',
                                                      fontSize: 12,
                                                      color: DesignColors.secondaryDark,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: DesignColors.accent.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(20),
                                                    border: Border.all(
                                                      color: DesignColors.accent.withOpacity(0.2),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: DesignText(
                                                    text: _extractTotalFromBreakdown(
                                                      pricingState.pricingData!.priceBreakdown!,
                                                    ),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: DesignColors.accent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    else ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          DesignText(
                                            text: 'Price per slot:',
                                            fontSize: 16,
                                            color: DesignColors.primaryFontDark,
                                          ),
                                          AnimatedContainer(
                                            duration: Duration(
                                              milliseconds: 300,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: DesignColors.secondary,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: AnimatedDefaultTextStyle(
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: DesignColors.primaryFontDark,
                                              ),
                                              child: DesignText(
                                                text: slotPrice > 0
                                                    ? '₹$slotPrice'
                                                    : 'Free',
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: DesignColors.primaryFontDark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          DesignText(
                                            text: 'Number of slots:',
                                            fontSize: 16,
                                            color: DesignColors.secondaryFontDark,
                                          ),
                                          AnimatedContainer(
                                            duration: Duration(
                                              milliseconds: 300,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: DesignColors.secondary
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: AnimatedDefaultTextStyle(
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: DesignColors.primaryFontDark,
                                              ),
                                              child: DesignText(
                                                text: '$slotCount',
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: DesignColors.primaryFontDark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                       Divider(color: DesignColors.secondary,),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          DesignText(
                                            text: 'Total:',

                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: DesignColors.primaryFontDark ,
                                          ),
                                          AnimatedContainer(
                                            duration: Duration(
                                              milliseconds: 300,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: DesignColors.accent
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: AnimatedDefaultTextStyle(
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: DesignColors.accent,
                                              ),
                                              child: DesignText(
                                                text: totalPrice > 0
                                                    ? '₹$totalPrice'
                                                    : 'Free',
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: DesignColors.accent,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ] else if (currentLobbyTickets.isNotEmpty) ...[
                                    ...List.generate(currentLobbyTickets.length, (index) {
                                      final ticket = currentLobbyTickets[index];
                                      final slots = ticket.slots ?? 1;
                                      final price = lobbyData.ticketOptions
                                          .firstWhere((option) => option.id == ticket.ticketId)
                                          .price;
                                      final totalPrice = price * slots;
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: DesignColors.secondaryDark,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: DesignColors.secondary,
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      DesignText(
                                                        text: ticket.name,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: DesignColors.primaryFontDark
                                                      ),
                                                      Space.h(height: 2),
                                                      DesignText(
                                                        text:
                                                            '₹ ${price.toStringAsFixed(0)} each',
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: DesignColors.secondaryFontDark
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    DesignText(
                                                      text: '× $slots',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: DesignColors.primaryFontDark,
                                                    ),
                                                    Space.h(height: 2),
                                                    DesignText(
                                                      text:
                                                          '₹ ${totalPrice.toStringAsFixed(0)}',
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: DesignColors.secondaryFontDark,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 8),
                                    Divider(color: DesignColors.secondary,),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        DesignText(
                                          text: 'Total:',

                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: DesignColors.primaryFontDark,
                                        ),
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: DesignColors.accent
                                                .withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: AnimatedDefaultTextStyle(
                                            duration: Duration(
                                              milliseconds: 300,
                                            ),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: DesignColors.accent,
                                            ),
                                            child: DesignText(
                                              text:
                                                  '₹$totalPrice',

                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: DesignColors.accent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          SizedBox(height: 24),

                           if ((lobbyData.lobbyStatus == "ACTIVE") && (lobbyData.restriction != null)) ...[
                            Builder(
                              builder: (context) {
                                final restrictionText = _getRestrictionText(lobbyData.restriction);

                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: DesignColors.secondary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      DesignIcon.icon(icon: FontAwesomeIcons.ban, size: 28, color: DesignColors.accent),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            DesignText(
                                              text: restrictionText['title'] ?? "No Restrictions",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: DesignColors.primaryFontDark,
                                              maxLines: null,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.visible,
                                            ),
                                            SizedBox(height: 4),
                                            DesignText(
                                              text: restrictionText['subtitle'] ?? "Anyone can join this Event",
                                              color: DesignColors.secondaryFontDark.withAlpha(255),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              maxLines: null,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const Space.h(height: 24),
                          ],

                          // Checkout button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  bool isHovered = false;
                                  return InkWell(
                                    onHover: (hover) {
                                      setState(() {
                                        isHovered = hover;
                                      });
                                    },
                                    child: DesignButton(
                                      onPress: () => _handleCheckout(lobbyData, totalPrice),
                                      title: _isProcessing
                                          ? 'Processing...'
                                          : (totalPrice > 0 ? 'Proceed to Checkout' : 'Save Your Spot'),
                                      isLoading: _isProcessing,
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DesignIcon.icon(icon: Icons.info_outline_rounded, color: DesignColors.accent, size: 24),
                              SizedBox(width: 12),
                              Expanded(
                                child: DesignText(
                                  text:
                                      "To chat with fellow attendees, see who’s coming, and discover exciting new updates — download the app.",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: DesignColors.secondaryFontDark,
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : _buildLobbyUnavailableMessage(lobbyData),
          ),
        ),
      ),
    );
  }

  Widget _buildLobbyUnavailableMessage(Lobby lobbyData) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Icon(Icons.event_busy_outlined, size: 64, color: DesignColors.accent),
          SizedBox(height: 24),
          // Title
          DesignText(
            text: _getLobbyUnavailableTitle(lobbyData),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: DesignColors.primary,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          // Message
          DesignText(
            text: _getLobbyUnavailableMessage(lobbyData),
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: DesignColors.secondary,
            textAlign: TextAlign.center,
            maxLines: null,
            overflow: TextOverflow.visible,
          ),
          // SizedBox(height: 24),
          // // Contact admin button
          // SizedBox(
          //   width: 200,
          //   child: DesignButton(
          //     onPress: () {
          //       // You can implement contact admin functionality here
          //       CustomSnackBar.show(
          //         context: context,
          //         message: 'Please contact the lobby admin for more information',
          //         type: SnackBarType.info,
          //       );
          //     },
          //     title: 'Contact Admin',
          //     padding: EdgeInsets.symmetric(vertical: 16),
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          //   ),
          // ),
        ],
      ),
    );
  }

  String _getLobbyUnavailableTitle(Lobby lobbyData) {
    switch (lobbyData.lobbyStatus) {
      case "PAST":
        return "Lobby Event Has Ended";
      case "CLOSED":
        return "Lobby registrations closed";
      case "FULL":
        return "Lobby is Full";
      default:
        return "Lobby Not Available";
    }
  }

  String _getLobbyUnavailableMessage(Lobby lobbyData) {
    switch (lobbyData.lobbyStatus) {
      case "PAST":
        return "This event has already taken place. Check out other upcoming events or contact the admin for any queries.";
      case "CLOSED":
        return "This lobby is no longer accepting registrations. Please check other available lobbies or contact the admin for more information.";
      case "FULL":
        return "This lobby has reached its maximum capacity and is no longer accepting new registrations. Please check other available lobbies or contact the admin for more information.";
      default:
        return "This lobby is currently not available for registration. Please contact the lobby admin for more information.";
    }
  }

  // Add these helper methods in the _LobbyQuickCheckoutState class

  List<Widget> _buildPricingTiers(String priceBreakdown) {
    try {
      // Remove "Pricing: " prefix and ". Total: ..." suffix
      String pricingPart = priceBreakdown.replaceFirst('Pricing: ', '');
      int totalIndex = pricingPart.indexOf('. Total:');
      if (totalIndex != -1) {
        pricingPart = pricingPart.substring(0, totalIndex);
      }

      // Split by commas to get individual tiers
      List<String> tiers = pricingPart.split(',').map((e) => e.trim()).toList();

      return tiers.map((tier) {
        // Updated regex to handle comma-separated prices
        final match = RegExp(
          r'(\d+)\s+slots?\s+@\s+₹\s*([\d,]+(?:\.\d+)?)',
        ).firstMatch(tier);
        if (match != null) {
          final slots = int.parse(match.group(1)!);
          // Remove commas from price before parsing
          final price = double.parse(match.group(2)!.replaceAll(',', ''));
          final total = slots * price;

          return Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: DesignColors.secondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: DesignColors.secondary, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.02),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText(
                      text: slots == 1 ? '$slots slot' : '$slots slots',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: DesignColors.primaryFontDark,
                    ),
                    // Updated to format price with commas
                    DesignText(
                      text:
                          '₹ ${NumberFormat('#,##0.00').format(price)} per slot',
                      fontSize: 13,
                      color: DesignColors.secondaryFontDark,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: DesignColors.secondaryDark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DesignText(
                    // Updated to format total with commas
                    text: '₹ ${NumberFormat('#,##0.00').format(total)}',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: DesignColors.primaryFontDark,
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      }).toList();
    } catch (e) {
      // Fallback to simple text display if parsing fails
      return [
        DesignText(
          text: priceBreakdown,
          fontSize: 16,
          color: DesignColors.secondary,
        ),
      ];
    }
  }

  String _extractTotalFromBreakdown(String priceBreakdown) {
    try {
      // Updated regex to handle comma-separated numbers
      final match = RegExp(r'Total:\s*₹\s*([\d,]+(?:\.\d+)?)').firstMatch(priceBreakdown);
      if (match != null) {
        // Remove commas from the number and format properly
        String amount = match.group(1)!.replaceAll(',', '');
        double value = double.parse(amount);

        // Format with commas for display
        final formatter = NumberFormat('#,##0.00');
        return '₹ ${formatter.format(value)}';
      }
    } catch (e) {
      // Fallback
    }
    return '₹ 0.00';
  }

   Map<String, String> _getRestrictionText(LobbyRestriction? restriction) {
    if (restriction == null) {
      return {'title': 'Restricted Event', 'subtitle': ''};
    }

    List<String> titles = [];
    List<String> subtitles = [];

    // Gender restriction
    if (restriction.genderRestriction == "ONLY_FEMALE") {
      titles.add("Female Only Event");
      subtitles.add("Only female participants can join");
    } else if (restriction.genderRestriction == "ONLY_MALE") {
      titles.add("Male Only Event");
      subtitles.add("Only male participants can join");
    }

    // Age range restriction
    if (restriction.ageRange != null) {
      final int? minAge = restriction.ageRange?.minAge;
      final int? maxAge = restriction.ageRange?.maxAge;

      if (minAge != null && maxAge != null && minAge > 0 && maxAge < 100) {
        titles.add("Age Restricted");
        subtitles.add("Participants must be between $minAge-$maxAge years old");
      } else if (minAge != null && minAge > 0) {
        titles.add("Age Restricted");
        subtitles.add("Participants must be $minAge years or older");
      } else if (maxAge != null && maxAge < 100) {
        titles.add("Age Restricted");
        subtitles.add("Participants must be $maxAge years or younger");
      }
    }

    // Organization restriction
    if (restriction.restrictToOrganization && restriction.organizationName.isNotEmpty) {
      titles.add("Organization Restricted");

      String orgSubtitle = "Only people from ${restriction.organizationName}";
      if (restriction.organizationEmailDomain.isNotEmpty) {
        orgSubtitle += " (@${restriction.organizationEmailDomain})";
      }
      orgSubtitle += " can join";
      subtitles.add(orgSubtitle);
    }

    // Combine all restrictions
    String finalTitle = titles.isEmpty ? "Restricted Event" : titles.join(" • ");
    String finalSubtitle = subtitles.isEmpty ? "This event has specific restrictions" : subtitles.join(" • ");

    return {'title': finalTitle, 'subtitle': finalSubtitle};
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    final lobbyDetailsAsync = ref.watch(lobbyQuickCheckoutDetailsProvider(widget.lobbyId));

    return lobbyDetailsAsync.when(
      data: (lobbyData) {
        return lobbyData == null
            ? Scaffold(
                backgroundColor: DesignColors.bgDark,
                appBar: AppBar(
                  leading: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    icon: DesignIcon.icon(
                      icon: Icons.arrow_back_ios_sharp,
                      size: 20,
                      color: DesignColors.primaryFontDark,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                ),
                body: RefreshIndicator(
                  key: Key("nullDataStateRefreshIndicator"),
                  onRefresh: () async {
                    ref
                        .read(
                          lobbyQuickCheckoutDetailsProvider(
                            widget.lobbyId,
                          ).notifier,
                        )
                        .reset();
                    await ref
                        .read(
                          lobbyQuickCheckoutDetailsProvider(
                            widget.lobbyId,
                          ).notifier,
                        )
                        .fetchLobbyQuickCheckoutDetails(widget.lobbyId);
                  },
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 0.85 * sh,
                      child: Center(
                        child: DesignText(
                          text: "Lobby Not Found !!!",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: DesignColors.primaryFontDark,
                          maxLines: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(
               backgroundColor: DesignColors.bgDark,
               appBar: PreferredSize(
                 preferredSize: Size.fromHeight(kToolbarHeight),
                 child: Builder(
                   builder: (context) {
                     // Get device type for responsive design
                     final deviceType = DesignUtils.getDeviceType(context);
                     final isDesktop = deviceType == DeviceScreenType.desktop;
                     // if (lobbyData.lobby.priceDetails.originalPrice <= 0) ;

                     return Container(
                       decoration: BoxDecoration(
                         color: DesignColors.bgDark,
                         boxShadow: [
                           BoxShadow(
                             color: Colors.white.withOpacity(0.05),
                             blurRadius: 4,
                             offset: Offset(0, 2),
                           ),
                         ],
                       ),
                       padding: EdgeInsets.symmetric(
                         horizontal: isDesktop ? 32 : 16,
                         vertical: 8,
                       ),
                       child: Row(
                         children: [
                           // Back button
                           IconButton(
                             style: IconButton.styleFrom(
                               backgroundColor: Colors.transparent,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(8),
                                 side: BorderSide(
                                   color: DesignColors.secondary,
                                 ),
                               ),
                             ),
                             onPressed: () {
                               Get.back();
                             },
                             icon: DesignIcon.icon(
                               icon: Icons.arrow_back_ios_sharp,
                               size: 18,
                               color: DesignColors.primaryFontDark,
                             ),
                           ),
                           SizedBox(width: 16),
                           // Logo
                           Image.asset(
                             'assets/icons/aroundu.png',
                             height: 32,
                             fit: BoxFit.contain,
                           ),
                           SizedBox(width: 12),
                           // App name
                           Text(
                             'AroundU',
                             style: TextStyle(
                               fontFamily: 'Poppins',
                               fontSize: isDesktop ? 20 : 18,
                               fontWeight: FontWeight.w600,
                               color: DesignColors.primaryFontDark,
                               letterSpacing: 0.5,
                             ),
                           ),
                           Spacer(),
                           // Optional: Add more elements for desktop view
                           if (isDesktop) ...[
                             GestureDetector(
                               onTap: () => Get.toNamed(AppRoutes.splash),
                               child: Container(
                                 padding: EdgeInsets.symmetric(
                                   horizontal: 16,
                                   vertical: 8,
                                 ),
                                 decoration: BoxDecoration(
                                   color: DesignColors.secondaryDark,
                                   borderRadius: BorderRadius.circular(20),
                                   border: Border.all(
                                     color: DesignColors.secondary,
                                   ),
                                 ),
                                 child: Row(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     Icon(
                                       Icons.person_outline,
                                       size: 18,
                                       color: DesignColors.primaryFontDark,
                                     ),
                                     SizedBox(width: 8),
                                     Text(
                                       'My Account',
                                       style: TextStyle(
                                         fontFamily: 'Poppins',
                                         fontSize: 14,
                                         fontWeight: FontWeight.w500,
                                         color: DesignColors.primaryFontDark,
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ],
                       ),
                     );
                   },
                 ),
               ),
               floatingActionButton: (_showFab && Get.width < 600)
                   ? FloatingActionButton.extended(
                       onPressed: _scrollToContainer,
                       extendedPadding: EdgeInsets.symmetric(
                         vertical: 0,
                         horizontal: 24,
                       ),
                       backgroundColor: DesignColors.accent,
                       label: DesignText(
                         text: 'Join',
                         fontSize: 16,
                         fontWeight: FontWeight.w600,
                         color: DesignColors.primaryFontDark,
                       ),
                       icon: const Icon(
                         Icons.emoji_people_outlined,
                         color: DesignColors.primaryFontDark,
                       ),
                     )
                   : null,
                body: Builder(
                  builder: (context) {
                    // Get device type for responsive design
                    final deviceType = DesignUtils.getDeviceType(context);
                    final isDesktop = deviceType == DeviceScreenType.desktop;

                    return Container(
                      color: DesignColors.bgDark,
                      child: isDesktop
                          ? _buildDesktopLayout(context, lobbyData.lobby)
                          : _buildMobileLayout(context, lobbyData.lobby),
                    );
                  },
                ),
              );
      },
      error: (error, stackTrace) {
        return Scaffold(
          backgroundColor: DesignColors.bgDark,
          appBar: AppBar(
            leading: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: DesignColors.secondary,
                  ),
                ),
              ),
              onPressed: () {
                Get.back();
              },
              icon: DesignIcon.icon(icon: Icons.arrow_back_ios_sharp, size: 18, color: DesignColors.primaryFontDark,),
            ),
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
          ),
          body: RefreshIndicator(
            key: Key("errorStateRefreshIndicator"),
            onRefresh: () async {
              ref
                  .read(
                    lobbyQuickCheckoutDetailsProvider(widget.lobbyId).notifier,
                  )
                  .reset();
              await ref
                  .read(
                    lobbyQuickCheckoutDetailsProvider(widget.lobbyId).notifier,
                  )
                  .fetchLobbyQuickCheckoutDetails(widget.lobbyId);
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
                        color: DesignColors.primaryFontDark,
                        maxLines: 10,
                      ),
                    ),
                    Space.h(height: 32),
                    DesignButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: DesignText(
                        text: "Retry",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      onPress: () async {
                        ref
                            .read(
                              lobbyQuickCheckoutDetailsProvider(
                                widget.lobbyId,
                              ).notifier,
                            )
                            .reset();
                        await ref
                            .read(
                              lobbyQuickCheckoutDetailsProvider(
                                widget.lobbyId,
                              ).notifier,
                            )
                            .fetchLobbyQuickCheckoutDetails(widget.lobbyId);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: DesignColors.secondary,
                  ),
                ),
              ),
              onPressed: () {
                Get.back();
              },
              icon: DesignIcon.icon(icon: Icons.arrow_back_ios_sharp, size: 18,color: DesignColors.primaryFontDark,),
            ),
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: 0.85 * sh,
              child: Center(
                child: CircularProgressIndicator(color: DesignColors.accent),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LobbyQuickCheckoutDetailsNotifier extends StateNotifier<AsyncValue<LobbyDetails?>> {
  LobbyQuickCheckoutDetailsNotifier() : super(const AsyncValue.loading());

  Future<void> fetchLobbyQuickCheckoutDetails(String lobbyId) async {
    // Set loading state
    state = const AsyncValue.loading();

    try {
      String endPoint = "match/lobby/public/$lobbyId/detail";

      final response = await ApiService().get(endPoint);

      if (response.data != null) {
        kLogger.debug('Lobby details fetched successfully');
        // Update state with data
        state = AsyncValue.data(LobbyDetails.fromJson(response.data));
      } else {
        kLogger.debug('Lobby data not found for ID: $lobbyId');
        // Update state with null data
        state = const AsyncValue.data(null);
      }
    } catch (e, stack) {
      kLogger.error('Error in fetching lobby details: $e \n $stack');

      state = const AsyncValue.loading();
    }
  }

  // Method to manually reset to loading state
  void reset() {
    state = const AsyncValue.loading();
  }
}

// Create the provider
final lobbyQuickCheckoutDetailsProvider =
    StateNotifierProvider.family<LobbyQuickCheckoutDetailsNotifier, AsyncValue<LobbyDetails?>, String>((ref, lobbyId) {
      final notifier = LobbyQuickCheckoutDetailsNotifier();
      // Automatically fetch data when the provider is first accessed
      notifier.fetchLobbyQuickCheckoutDetails(lobbyId);
      return notifier;
    });
