import 'dart:async';

import 'package:aroundu/constants/appRoutes.dart';
import 'package:aroundu/designs/widgets/button.widget.designs.dart';
import 'package:aroundu/designs/widgets/icon.widget.designs.dart';
import 'package:aroundu/designs/widgets/space.widget.designs.dart';
import 'package:aroundu/designs/widgets/text.widget.designs.dart';
import 'package:aroundu/utils/api_service/api.service.dart';
import 'package:aroundu/utils/custome_snackbar.dart';
import 'package:aroundu/utils/logger.utils.dart';
import 'package:aroundu/views/auth/auth_api.service.dart';
import 'package:aroundu/views/auth/phone_number.controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import '../../constants/urls.dart';
import '../../designs/colors.designs.dart';
import '../../designs/icons.designs.dart';
import '../../designs/utils.designs.dart';
import '../../utils/either.utils.dart';
import 'auth.controller.dart';
import 'signin_service.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key, required this.destination});
  final String destination;

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    with SingleTickerProviderStateMixin {
  final AuthController authController = Get.put(AuthController());
  final AuthApiService _authApiService = AuthApiService();

  final signInService = SignInService();

  bool _isLoading = false;
  bool _isCheck = true;

  // Animation controller for enhanced visual effects
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  late PageController _pageController;
  late Timer _autoScrollTimer;
  int _currentPage = 0;
  double height = 0.6;
  double borderRadius = 16.0; // Increased for more modern look
  Duration autoScrollDuration = const Duration(seconds: 4);
  BoxFit imageFit = BoxFit.fitHeight;

  // Onboarding content
  List<String> assetImages = const [
    'assets/images/onboarding_1.png',
    'assets/images/onboarding_2.png',
    'assets/images/onboarding_3.png',
    'assets/images/onboarding_4.png',
    'assets/images/onboarding_5.png',
  ];
  List<String> titles = [
    "See What's Happening Around You",
    "Your Plans, Your Rules",
    "Build Your Own Space with Houses",
    "Secure Checkout",
    "Earn as You Connect",
  ];
  List<String> descriptions = [
    "Browse lobbies by category with smart filters to find your vibe instantly.",
    "Create a public lobby or keep it private—you decide who gets in.",
    "Start a House or explore growing communities on AroundU.",
    "Avoid awkward moments—take payments upfront with a quick, trustworthy process!",
    "Host lobbies, build credibility, and unlock rewards for doing what you love!",
  ];

  // Colors for gradient backgrounds - using red theme with accent color
  final List<List<Color>> gradientColors = [
    [DesignColors.accent, Color(0xFFFF4B2B)],
    [DesignColors.accent, Color(0xFFFF6B6B)],
    [DesignColors.accent, Color(0xFFFF8080)],
    [DesignColors.accent, Color(0xFFFF9494)],
    [DesignColors.accent, Color(0xFFFFABAB)],
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    _pageController = PageController();

    // Setup animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    // Start animations and auto-scroll
    _animationController.forward();
    _startAutoScroll();

    // Apply system UI overlay style for a cleaner look
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // Page controller listener
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    Get.delete<AuthController>();
    _pageController.dispose();
    _autoScrollTimer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(autoScrollDuration, (timer) {
      if (_currentPage < assetImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _launchURL(String url) async {
    // Create a GlobalKey for the dialog
    final GlobalKey<State> launchUrlDialogKey = GlobalKey<State>();
    BuildContext? dialogContext;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return AlertDialog(
          key: launchUrlDialogKey,
          backgroundColor: Colors.transparent,
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator(color: DesignColors.accent)],
          ),
        );
      },
    );

    // Close dialog after a short delay to ensure it's dismissed
    Future.delayed(Duration(seconds: 2), () {
      if (dialogContext != null && Navigator.canPop(dialogContext!)) {
        Navigator.pop(dialogContext!);
      }
    });

    try {
      bool launched = await launchUrl(
        Uri.parse(url),
        // mode: LaunchMode.externalApplication, // Force external browser
      );

      // Close the loading dialog immediately after launch attempt
      if (dialogContext != null && Navigator.canPop(dialogContext!)) {
        Navigator.pop(dialogContext!);
      }

      if (!launched) {
        CustomSnackBar.show(
          context: context,
          message: "Could not launch $url",
          type: SnackBarType.error,
        );
      }
    } catch (e) {
      // Close the loading dialog
      if (dialogContext != null && Navigator.canPop(dialogContext!)) {
        Navigator.pop(dialogContext!);
      }

      CustomSnackBar.show(
        context: context,
        message: "Error launching $url",
        type: SnackBarType.error,
      );
    }
  }

  // Build a modern page indicator
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        assetImages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _currentPage == index
                ? gradientColors[_currentPage][0]
                : Color(0xFFDDDDDD),
          ),
        ),
      ),
    );
  }

  // Build the sign-in buttons section
  Widget _buildSignInButtons({double? fontSize}) {
    return Column(
      children: [
        // Mobile sign-in button (full width)
        DesignButton(
          padding: EdgeInsets.symmetric(vertical: 16),
          isLoading: _isLoading,
          bgColor: gradientColors[_currentPage][0],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onPress: () async {
            if (!_isCheck) {
              CustomSnackBar.show(
                context: context,
                message: "Please accept the terms and conditions",
                type: SnackBarType.warning,
              );
              return;
            }
            // Use named route with parameters
            Get.toNamed(
              AppRoutes.phoneNumber,
              arguments: {
                'onContinue': (String phoneNumber) async {
                  try {
                    await _verifyPhone(phoneNumber);
                    return true; // Return success status
                  } catch (e, s) {
                    kLogger.error("error", error: e, stackTrace: s);
                    CustomSnackBar.show(
                      context: context,
                      message: "Failed to send verification code",
                      type: SnackBarType.error,
                    );
                    return false; // Return failure status
                  }
                },
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DesignIcon.icon(
                icon: Icons.phone_android,
                size: 20,
                color: DesignColors.white,
              ),
              const Space.w(width: 12),
              DesignText(
                text: "Sign in with Mobile no.",
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.w500,
                color: DesignColors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Google and Apple buttons (half width each)
        Row(
          children: [
            // Google sign-in button
            Expanded(
              child: DesignButton(
                padding: EdgeInsets.symmetric(vertical: 16),
                bgColor: DesignColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                ),
                onPress: () async {
                  if (!_isCheck) {
                    CustomSnackBar.show(
                      context: context,
                      message: "Please accept the terms and conditions",
                      type: SnackBarType.warning,
                    );
                    return;
                  }

                  await localSignInGoogle();
                },
                child: DesignIcon(
                  icon: Either.left(DesignIcons.google),
                  size: 24,
                  color: DesignColors.primaryFontDark,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Apple sign-in button
            Expanded(
              child: DesignButton(
                padding: EdgeInsets.symmetric(vertical: 16),
                bgColor: Color(0xFF000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPress: () async {
                  if (!_isCheck) {
                    CustomSnackBar.show(
                      context: context,
                      message: "Please accept the terms and conditions",
                      type: SnackBarType.warning,
                    );
                    return;
                  }

                  await localSignInApple();
                },
                child: DesignIcon(
                  icon: Either.right(Icons.apple),
                  size: 24,
                  color: DesignColors.primaryFontDark,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Build the terms and conditions checkbox

  Widget _buildTermsCheckbox({double? fontSize}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 0.8,
          child: Checkbox(
            value: _isCheck,
            onChanged: (value) {
              setState(() {
                _isCheck = !_isCheck;
              });
            },
            activeColor: gradientColors[_currentPage][0],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        Flexible(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                'I agree to the ',
                style: TextStyle(fontSize: fontSize ?? 12),
              ),
              InkWell(
                onTap: () => _launchURL('https://www.aroundu.in/terms'),
                child: Text(
                  'TnC',
                  style: TextStyle(
                    color: gradientColors[_currentPage][0],
                    fontSize: fontSize ?? 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(' and ', style: TextStyle(fontSize: fontSize ?? 12)),
              InkWell(
                onTap: () => _launchURL('https://www.aroundu.in/privacy'),
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: gradientColors[_currentPage][0],
                    fontSize: fontSize ?? 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build the mobile layout
  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: DesignColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate responsive dimensions
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;
          final isSmallScreen = screenWidth < DesignUtils.smallPhoneBreakpoint;

          // Adjust flex ratio based on screen height
          final topFlex = screenHeight < 600 ? 8 : 9;
          final bottomFlex = screenHeight < 600 ? 7 : 6;

          // Adjust image height based on screen size
          final imageHeight = screenHeight < 600
              ? screenHeight * 0.5
              : screenHeight * 0.6;

          // Adjust font sizes based on screen width
          final titleFontSize = isSmallScreen ? 24.0 : 24.0;
          final descFontSize = isSmallScreen ? 14.0 : 14.0;
          final buttonFontSize = isSmallScreen ? 16.0 : 16.0;
          final termsFontSize = isSmallScreen ? 10.0 : 10.0;

          // Adjust padding based on screen size
          final horizontalPadding = isSmallScreen ? 16.0 : 24.0;

          return SizedBox(
            height: constraints.maxHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: topFlex,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Animated background with gradient
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors[_currentPage],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      // Page view for onboarding images
                      SizedBox(
                        height: imageHeight,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemCount: assetImages.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: 'onboarding_$index',
                              child: Container(
                                margin: EdgeInsets.all(screenHeight * 0.02),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    borderRadius,
                                  ),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.black.withOpacity(0.2),
                                  //     blurRadius: 15,
                                  //     offset: const Offset(0, 8),
                                  //   ),
                                  // ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    borderRadius,
                                  ),
                                  child: Image.asset(
                                    assetImages[index],
                                    fit: imageFit,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Curved bottom edge
                      Positioned(
                        bottom: -1,
                        left: 0,
                        right: 0,
                        child: Stack(
                          children: [
                            // Shadow layer with same curve but slightly offset
                            Positioned(
                              top: 6, // Offset to create shadow effect
                              left: 0,
                              right: 0,
                              child: ClipPath(
                                clipper: ModernConcaveClipper(),
                                child: Container(
                                  height: screenHeight * 0.12,
                                  color: Color(0x1F444444), // Shadow color
                                  // foregroundDecoration: BoxDecoration(
                                  //   backgroundBlendMode: BlendMode.src,
                                  //   gradient: LinearGradient(
                                  //     colors: [
                                  //       Color.fromARGB(255, 196, 196, 196),
                                  //       Color.fromARGB(31, 227, 227, 227),
                                  //     ],
                                  //     begin: Alignment.topCenter,
                                  //     end: Alignment.bottomCenter,
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                            // Main white curved container
                            ClipPath(
                              clipper: ModernConcaveClipper(),
                              child: Container(
                                height: screenHeight * 0.02,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: gradientColors[_currentPage],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topRight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Content section
                Expanded(
                  flex: bottomFlex,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: screenHeight < 600 ? 8 : 16),
                            // Page indicator
                            _buildPageIndicator(),
                            SizedBox(height: screenHeight < 600 ? 16 : 24),
                            // Title with animation
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0.0, 0.2),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      ),
                                    );
                                  },
                              child: DesignText(
                                key: ValueKey<int>(_currentPage),
                                text: titles[_currentPage],
                                fontSize: titleFontSize,
                                maxLines: null,
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF323232),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: screenHeight < 600 ? 8 : 12),
                            // Description with animation
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0.0, 0.2),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      ),
                                    );
                                  },
                              child: DesignText(
                                key: ValueKey<int>(_currentPage),
                                text: descriptions[_currentPage],
                                fontSize: descFontSize,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF444444),
                                maxLines: null,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: screenHeight < 600 ? 16 : 24),
                            // Sign in buttons and terms
                            _buildSignInButtons(fontSize: buttonFontSize),
                            SizedBox(height: 16),
                            _buildTermsCheckbox(fontSize: termsFontSize),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Build the tablet layout
  Widget _buildTabletLayout() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: DesignColors.white,
      body: OrientationScreenBuilder(
        portraitLayout: _buildMobileLayout(),
        landscapeLayout: Row(
          children: [
            // Left side - Onboarding content
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors[_currentPage],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
                        child: CustomPaint(painter: GridPatternPainter()),
                      ),
                    ),
                    // Image Carousel for Tablet Landscape
                    Center(
                      child: Container(
                        height: screenHeight * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemCount: assetImages.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: 'onboarding_\$index',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  borderRadius,
                                ),
                                child: Image.asset(
                                  assetImages[index],
                                  fit: BoxFit.fitHeight,
                                  colorBlendMode: BlendMode.multiply,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Right side - Content
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(screenHeight * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    DesignText(
                      text: titles[_currentPage],
                      fontSize: screenHeight * 0.04,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF323232),
                      textAlign: TextAlign.center,
                      maxLines: null,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Description
                    DesignText(
                      text: descriptions[_currentPage],
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF444444),
                      maxLines: null,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    // Page indicator
                    _buildPageIndicator(),
                    SizedBox(height: screenHeight * 0.04),
                    // Sign in buttons
                    _buildSignInButtons(fontSize: screenHeight * 0.024),
                    SizedBox(height: screenHeight * 0.02),
                    // Terms and conditions
                    _buildTermsCheckbox(fontSize: screenHeight * 0.016),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the desktop layout
  Widget _buildDesktopLayout() {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: DesignColors.white,
      body: Row(
        children: [
          // Left side - Onboarding content
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors[_currentPage],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // Background pattern
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.1,
                      child: CustomPaint(painter: GridPatternPainter()),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'AroundU',
                                style: TextStyle(
                                  fontSize: screenHeight * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: gradientColors[_currentPage][0],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        // Title and description
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-0.2, 0.0),
                              end: Offset.zero,
                            ).animate(_animationController),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: DesignText(
                                    key: ValueKey<int>(_currentPage),
                                    text: titles[_currentPage],
                                    fontSize: screenHeight * 0.042,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    maxLines: null,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                SizedBox(height: 16),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: DesignText(
                                    key: ValueKey<int>(_currentPage),
                                    text: descriptions[_currentPage],
                                    fontSize: screenHeight * 0.02,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withOpacity(0.9),
                                    maxLines: null,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        // Page indicator
                        _buildPageIndicator(),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right side - Sign in form
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(screenHeight * 0.03),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.2, 0.0),
                    end: Offset.zero,
                  ).animate(_animationController),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image Carousel for Desktop
                      Container(
                        height: screenHeight * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.1),
                          //     blurRadius: 15,
                          //     offset: const Offset(0, 8),
                          //   ),
                          // ],
                        ),
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemCount: assetImages.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: 'onboarding_$index',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  borderRadius,
                                ),
                                child: Image.asset(
                                  assetImages[index],
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      // Sign in buttons
                      Container(
                        width: double.infinity,
                        child: _buildSignInButtons(
                          fontSize: screenHeight * 0.03,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.018),
                      // Terms and conditions
                      _buildTermsCheckbox(fontSize: screenHeight * 0.018),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ScreenBuilder(
          phoneLayout: _buildMobileLayout(),
          tabletLayout: _buildTabletLayout(),
          desktopLayout: _buildDesktopLayout(),
        ),
      ),
    );
  }

  Future<void> localSignInGoogle() async {
    final GlobalKey<State> dialogKey = GlobalKey<State>();

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

    try {
      final response = await signInService.signInAuthWithGoogle();

      if (response != null) {
        authController.userName.value = response.user!.displayName ?? '';
        authController.userEmail.value = response.user!.email ?? '';

        try {
          final idToken = await response.user?.getIdToken();
          await _authApiService.googleSignIn(idToken ?? '');
        } catch (e, s) {
          kLogger.error("error", error: e, stackTrace: s);
        }

        await _updateFCMToken();
        await GetStorage().write('isLoggedOut', false);
        await authController.checkUserOnboardingStatus();
      } else {
        // Show error message
        CustomSnackBar.show(
          context: context,
          message: "Google Sign-In failed. Please try again.",
          type: SnackBarType.error,
        );
      }
    } catch (e, s) {
      kLogger.error("error", error: e, stackTrace: s);
      CustomSnackBar.show(
        context: context,
        message: "An error occurred during Google sign-in. Please try again.",
        type: SnackBarType.error,
      );
    } finally {
      // Close loading dialog
      if (context.mounted &&
          dialogKey.currentContext != null &&
          Navigator.canPop(dialogKey.currentContext!)) {
        Navigator.pop(dialogKey.currentContext!);
      }
    }
  }

  Future<void> localSignInApple() async {
    final GlobalKey<State> dialogKey = GlobalKey<State>();

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

    try {
      final response = await signInService.signInWithApple();

      if (response != null) {
        authController.userName.value = response.user!.displayName ?? '';
        authController.userEmail.value = response.user!.email ?? '';

        try {
          final idToken = await response.user?.getIdToken();
          await _authApiService.appleSignIn(idToken ?? '');
        } catch (e, s) {
          kLogger.error("error", error: e, stackTrace: s);
        }

        await _updateFCMToken();
        await GetStorage().write('isLoggedOut', false);
        await authController.checkUserOnboardingStatus();
      } else {
        // Show error message
        CustomSnackBar.show(
          context: context,
          message: "Apple Sign-In failed. Please try again.",
          type: SnackBarType.error,
        );
      }
    } catch (e, s) {
      kLogger.error("error", error: e, stackTrace: s);
      CustomSnackBar.show(
        context: context,
        message: "An error occurred during Apple sign-in. Please try again.",
        type: SnackBarType.error,
      );
    } finally {
      // Close loading dialog
      if (context.mounted &&
          dialogKey.currentContext != null &&
          Navigator.canPop(dialogKey.currentContext!)) {
        Navigator.pop(dialogKey.currentContext!);
      }
    }
  }

  Future<bool> _verifyPhone(String phoneNumber) async {
    PhoneNumberController phoneNumberController = Get.put(
      PhoneNumberController(),
    );
    setState(() {
      _isLoading = true;
    });

    try {
      // Call the API to send OTP
      final response = await _authApiService.sendOtp(phoneNumber);

      setState(() {
        _isLoading = false;
      });
      phoneNumberController.isLoading.value = false;

      if (response.isSuccess) {
        // Navigate to OTP screen
        Get.toNamed(
          AppRoutes.otp,
          arguments: {
            'phoneNumber': phoneNumber,
            'onVerify': (String otp) async {
              final GlobalKey<State> dialogKey = GlobalKey<State>();

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
                      children: [
                        CircularProgressIndicator(color: DesignColors.accent),
                      ],
                    ),
                  );
                },
              );

              try {
                // Verify OTP with the API
                final verifyResponse = await _authApiService.verifyOtp(otp);

                if (verifyResponse.isSuccess) {
                  // await _updateFCMToken();
                  await GetStorage().write('isFirstRun', false);
                  await GetStorage().write('isLoggedOut', false);
                  await authController.checkUserOnboardingStatus(
                    destination: widget.destination,
                  );
                } else {
                  // Show error message
                  CustomSnackBar.show(
                    context: context,
                    message: verifyResponse.message,
                    type: SnackBarType.error,
                  );
                  if (context.mounted) {
                    if (dialogKey.currentContext != null &&
                        Navigator.canPop(dialogKey.currentContext!)) {
                      Navigator.pop(dialogKey.currentContext!);
                    }
                  }
                }
                // if (context.mounted) {
                //   if (dialogKey.currentContext != null &&
                //       Navigator.canPop(dialogKey.currentContext!)) {
                //     Navigator.pop(dialogKey.currentContext!);
                //   }
                // }
              } catch (e, s) {
                if (context.mounted) {
                  if (dialogKey.currentContext != null &&
                      Navigator.canPop(dialogKey.currentContext!)) {
                    Navigator.pop(dialogKey.currentContext!);
                  }
                }

                kLogger.error("error", error: e, stackTrace: s);

                CustomSnackBar.show(
                  context: context,
                  message:
                      "An error occurred during verification. Please try again.",
                  type: SnackBarType.error,
                );
              }
            },
            'onResendOtp': () => _resendOTP(phoneNumber),
          },
        );
        return true;
      } else {
        // Show error message
        CustomSnackBar.show(
          context: context,
          message: response.message,
          type: SnackBarType.error,
        );
        return false;
      }
    } catch (e, s) {
      kLogger.error("error", error: e, stackTrace: s);
      setState(() {
        _isLoading = false;
      });
      phoneNumberController.isLoading.value = false;
      CustomSnackBar.show(
        context: context,
        message: "Failed to send verification code",
        type: SnackBarType.error,
      );
      return false;
    }
  }

  // Add this new method to handle resending OTP
  Future<void> _resendOTP(String phoneNumber) async {
    try {
      // Call the API to resend OTP
      final response = await _authApiService.resendOtp();

      if (response.isSuccess) {
        // Show success message
        CustomSnackBar.show(
          context: context,
          message: "OTP resent successfully",
          type: SnackBarType.success,
        );
      } else {
        // Show error message
        CustomSnackBar.show(
          context: context,
          message: response.message,
          type: SnackBarType.error,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        context: context,
        message: "Failed to resend verification code",
        type: SnackBarType.error,
      );
    }
  }

  _updateFCMToken() async {
    kLogger.trace("Updating FCM Token");
    final token = await FirebaseMessaging.instance.getToken();
    kLogger.trace("FCM Token : $token");
    final storedToken = await GetStorage().read("fcmToken");
    kLogger.trace("Stored Token : $storedToken");
    if (token != null) {
      if (storedToken == null || token != storedToken) {
        final response = await ApiService().post(
          ApiConstants.updateDeviceToken,
          body: {"deviceToken": token},
        );
        kLogger.trace("Response : ${response.data}");
        if (response.statusCode == 200) {
          await GetStorage().write("fcmToken", token);
          kLogger.trace("Device Token : $token");
        }
      } else {
        kLogger.trace("Device Token not available");
      }
    }
  }
}

// Modern concave clipper with smoother curve
class ModernConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.65); // Start from bottom-left, go up to 65%

    // Create a smoother curve with cubic bezier
    path.cubicTo(
      size.width * 0.25, // First control point x
      size.height * 0.85, // First control point y
      size.width * 0.75, // Second control point x
      size.height * 0.85, // Second control point y
      size.width, // End point x (right edge)
      size.height * 0.65, // End point y (65% down)
    );

    path.lineTo(size.width, 0); // Line to top-right
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Grid pattern painter for background decoration
class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw horizontal lines
    final horizontalLineCount = 10;
    final horizontalSpacing = size.height / horizontalLineCount;

    for (int i = 0; i <= horizontalLineCount; i++) {
      final y = i * horizontalSpacing;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw vertical lines
    final verticalLineCount = 10;
    final verticalSpacing = size.width / verticalLineCount;

    for (int i = 0; i <= verticalLineCount; i++) {
      final x = i * verticalSpacing;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw some random circles for decoration
    final random = math.Random(42); // Fixed seed for consistent pattern
    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 20 + 5;
      canvas.drawCircle(Offset(x, y), radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
