import 'dart:math';
import 'dart:ui';

import 'package:aroundu/constants/appRoutes.dart';
import 'package:aroundu/constants/colors_palette.dart';
import 'package:aroundu/designs/colors.designs.dart';
import 'package:aroundu/designs/fonts.designs.dart';
import 'package:aroundu/designs/widgets/lobby_card.widgets.designs.dart';
import 'package:aroundu/designs/widgets/space.widget.designs.dart';
import 'package:aroundu/designs/widgets/text.widget.designs.dart';
import 'package:aroundu/models/house.model.dart';
import 'package:aroundu/models/lobby.dart';
import 'package:aroundu/utils/appDownloadCard.dart';
import 'package:aroundu/utils/custom.tab.bar.dart';
import 'package:aroundu/utils/share_util.dart';
import 'package:aroundu/views/house/provider/house_details_provider.dart';
import 'package:aroundu/views/lobby/widgets/rich_text_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final isLocationsExpandedProvider = StateProvider.family<bool, String>((ref, houseId) => false);

class HouseDetailsView extends ConsumerStatefulWidget {
  final String houseId;
  const HouseDetailsView({super.key, required this.houseId});

  @override
  ConsumerState<HouseDetailsView> createState() => _HouseDetailsViewState();
}

class _HouseDetailsViewState extends ConsumerState<HouseDetailsView> {
  late PageController pageController;
  final ScrollController mainScrollController = ScrollController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refreshData() async {
    // Invalidate house details provider to force refresh
    ref.invalidate(houseDetailsProvider(widget.houseId));
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 1.0);

    Future.microtask(() {
      // ref.invalidate(lobbiesForHouseProvider);
      ref.read(houseDetailsProvider(widget.houseId).notifier).fetchHosueDetails(widget.houseId);
      // ref.invalidate(leaderboardNotifierProvider(widget.houseId));
      // ref.read(leaderboardNotifierProvider(widget.houseId).notifier).refresh();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    mainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = Get.width;
    final sh = Get.height;
    final houseDetailsAsync = ref.watch(houseDetailsProvider(widget.houseId));
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: houseDetailsAsync.when(
          data: (houseDetails) {
            final house = houseDetails?.house;
            if (house == null) {
              return Center(child: DesignText(text: "House not found", fontSize: 16, fontWeight: FontWeight.w500));
            }
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: mainScrollController,
              child: Stack(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            _buildHousePhotoGallery(house: house),
                            Positioned(bottom: -40, left: 16, child: _buildProfileImage(house: house)),
                            Positioned(bottom: 16, right: 16, child: _buildDotsIndicator(house: house)),
                          ],
                        ),
                        SizedBox(height: min(0.12 * sw, 48)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHouseHeader(house: house),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12), // Reduced from 16.r
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03), // Lighter shadow
                                      blurRadius: 6,
                                      spreadRadius: 0,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (house.categories != null && house.categories!.isNotEmpty)
                                      Container(
                                        height: 32, // Reduced from 36.h
                                        margin: EdgeInsets.only(top: 8, bottom: 16),
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          child: _buildCategoriesSection(house: house),
                                        ),
                                      ),
                                    if (house.description != null && house.description!.isNotEmpty) ...[
                                      _buildCompactSectionHeader(icon: Icons.info_outline, title: "About"),
                                      _buildAboutSection(house: house),
                                    ],
                                    // Social media as compact row of icons
                                    if (house.socialMediaLinks != null && house.socialMediaLinks!.isNotEmpty) ...[
                                      _buildSocialHandel(house: house),
                                      SizedBox(height: 8), // Reduced from 16.h
                                    ],
                                    _buildMembersSection(house: house),
                                    // Location section with compact layout
                                    if (house.locationInfo != null) ...[
                                      SizedBox(height: 4),
                                      _buildLocationSection(house: house),
                                    ],
                                  ],
                                ),
                              ),
                              SizedBox(height: 24),
                    
                              // Tab bar view for activities, lobbies, etc.
                              _buildTabBarView(houseDetails: houseDetails),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  
                  // Back button overlay
                  _buildBackButton(),
                ],
              ),
            );
          },
          error:
              (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.grey),
                    SizedBox(height: 16),
                    Text("Error loading house details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsPalette.redColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text("Retry")),
                    ),
                  ],
                ),
              ),
          loading:
              () => Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorsPalette.redColor)),
              ),
        ),
      ),
    );
  }

  Widget _buildTabBarView({required HouseDetailedModel? houseDetails}) {
    return SizedBox(
      height: 0.8 * Get.height,
      child: CustomTabBarView(
        tabs: const [
          "Current Lobbies",
          // "Past Lobbies"
        ],
        tabViews: [
          _buildCurrentLobbiesTitleWidget(lobbies: houseDetails?.upcomingLobbies ?? []),
          // _buildPastLobbiesWidget(lobbies: houseDetails?.pastLobbies ?? []),
        ],
        mainScrollController: mainScrollController,
      ),
    );
  }

  Widget _buildCurrentLobbiesTitleWidget({required List<Lobby> lobbies}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child:
          (lobbies.isEmpty)
              ? _buildEmptyLobbiesWidget(pastLobbies: false)
              : _buildLobbiesSectionSmall(lobbies: lobbies),
    );
  }

  Widget _buildLobbiesSectionSmall({required List<Lobby> lobbies}) {
    return ListView.separated(
      itemCount: lobbies.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final lobby = lobbies[index];
        final memberProgress = lobby.totalMembers > 0 ? (lobby.currentMembers / lobby.totalMembers) * 100 : 0;

        return GestureDetector(
          onTap: () async {
            HapticFeedback.selectionClick();
            await Navigator.pushNamed(context, AppRoutes.lobby.replaceAll(':lobbyId', lobby.id));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: Offset(0, 4), spreadRadius: 0),
              ],
              border: Border.all(color: DesignColors.accent.withOpacity(0.1), width: 1),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Leading Image
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: DesignColors.accent.withOpacity(0.1),
                          image:
                              lobby.mediaUrls.isNotEmpty
                                  ? DecorationImage(image: NetworkImage(lobby.mediaUrls.first), fit: BoxFit.cover)
                                  : null,
                        ),
                        child:
                            lobby.mediaUrls.isEmpty
                                ? Icon(Icons.image_outlined, color: DesignColors.accent.withOpacity(0.6), size: 28)
                                : null,
                      ),
                      SizedBox(width: 16),
                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DesignText(
                              text: lobby.title ?? 'Untitled Lobby',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              color: DesignColors.primary,
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  lobby.isPrivate ? Icons.lock_outline : Icons.public,
                                  size: 14,
                                  color: DesignColors.accent,
                                ),
                                SizedBox(width: 6),
                                DesignText(
                                  text: lobby.isPrivate ? 'Private' : 'Public',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: DesignColors.accent,
                                ),
                              ],
                            ),

                            // if (lobby.description != null && lobby.description!.isNotEmpty) ...[
                            //   SizedBox(height: 4),
                            //   RichTextDisplay(
                            //     controller: TextEditingController(text: lobby.description!),
                            //     hintText: '',
                            //     fontSize: 8,
                            //     maxHeight: 64,
                            //     lobbyId: lobby.id,
                            //   ),
                            // ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Additional Details
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 14, color: DesignColors.secondary),
                      SizedBox(width: 6),
                      DesignText(
                        text:
                            lobby.filter.otherFilterInfo.dateInfo != null
                                ? lobby.filter.otherFilterInfo.dateInfo?.formattedDate ?? ""
                                : 'Date TBD',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: DesignColors.secondary,
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.location_on, size: 14, color: DesignColors.secondary),
                      SizedBox(width: 6),
                      Expanded(
                        child: DesignText(
                          text:
                              lobby.filter.otherFilterInfo.locationInfo != null
                                  ? lobby.filter.otherFilterInfo.locationInfo?.googleSearchResponses?.isNotEmpty ??
                                          false
                                      ? lobby
                                              .filter
                                              .otherFilterInfo
                                              .locationInfo
                                              ?.googleSearchResponses
                                              .first
                                              .description ??
                                          ""
                                      : "Location TBD"
                                  : 'Location TBD',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: DesignColors.secondary,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Member Progress
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DesignText(
                                  text: 'Members',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: DesignColors.secondary,
                                ),
                                DesignText(
                                  text: '${lobby.currentMembers}/${lobby.totalMembers}',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: DesignColors.accent,
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: lobby.totalMembers > 0 ? lobby.currentMembers / lobby.totalMembers : 0,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(DesignColors.accent.withOpacity(0.7)),
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      // Member Count Badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: DesignColors.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: DesignColors.accent.withOpacity(0.3), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.people, size: 14, color: DesignColors.accent),
                            SizedBox(width: 4),
                            DesignText(
                              text: '${lobby.currentMembers}',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: DesignColors.accent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentLobbiesWidget({required List<Lobby> lobbies}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: (lobbies.isEmpty) ? _buildEmptyLobbiesWidget(pastLobbies: false) : _buildLobbiesSection(lobbies: lobbies),
    );
  }

  Widget _buildPastLobbiesWidget({required List<Lobby> lobbies}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: (lobbies.isEmpty) ? _buildEmptyLobbiesWidget(pastLobbies: true) : _buildLobbiesSection(lobbies: lobbies),
    );
  }

  Widget _buildLobbiesSection({required List<Lobby> lobbies}) {
    if (Get.width > 910) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              Get.width > 1344
                  ? 3
                  : Get.width > 910
                  ? 2
                  : 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio:
              Get.width > 1344
                  ? Get.width > 1450
                      ? Get.width > 1550
                          ? 2.7
                          : 2.3
                      : 2
                  : Get.width > 910
                  ? Get.width > 1000
                      ? 2.1
                      : 1.9
                  : 1, // Perfect square ratio
        ),
        itemCount: lobbies.length,
        itemBuilder: (context, index) {
          final lobby = lobbies[index];
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 450,
              // maxWidth: min(650, 750),
              minWidth: 200,
            ),
            child: DesignLobbyWidget(lobby: lobby, hasCoverImage: lobby.mediaUrls.isNotEmpty),
          );
        },
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: lobbies.length,
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final lobby = lobbies[index];
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 450,
              // maxWidth: min(650, 750),
              minWidth: 200,
            ),
            child: DesignLobbyWidget(lobby: lobby, hasCoverImage: lobby.mediaUrls.isNotEmpty),
          );
        },
      );
    }
  }

  Widget _buildEmptyLobbiesWidget({required bool pastLobbies}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 40, bottom: 32),
          decoration: BoxDecoration(
            color: const Color(0xFFFCFCFC),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // DesignText(
              //   text: 'Create Lobby',
              //   fontSize: 12.sp,
              //   fontWeight: FontWeight.w500,
              //   color: const Color(0xFF3E79A1),
              // ),
              // Space.h(height: 8.h),
              DesignText(
                text: (pastLobbies) ? 'No past lobbies at the moment' : 'No active lobbies at the moment',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              // Space.h(height: 2),
              // DesignText(
              //   text: 'Start a lobby to engage with your house members',
              //   fontSize: 10,
              //   fontWeight: FontWeight.w500,
              //   color: const Color(0xff989898),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSection({required House house}) {
    if (house.locationInfo == null ||
        (house.locationInfo!.locationResponses == null && house.locationInfo!.googleSearchResponses == null)) {
      return SizedBox.shrink();
    }

    // Collect all available locations
    List<String> locations = [];

    // Add locations from googleSearchResponses
    if (house.locationInfo!.googleSearchResponses != null) {
      for (var location in house.locationInfo!.googleSearchResponses!) {
        if (location.structuredFormatting != null &&
            location.structuredFormatting!.mainText != null &&
            location.structuredFormatting!.mainText!.isNotEmpty) {
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

    final houseId = house.id ?? '';
    final isExpanded = ref.watch(isLocationsExpandedProvider(houseId));

    // Determine if we need to show "Show More" button
    bool hasMoreLocations = locations.length > 3;
    List<String> displayedLocations = isExpanded ? locations : locations.take(3).toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(12.r),
        // border: Border.all(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
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
                              TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black87),
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
                  ref.read(isLocationsExpandedProvider(houseId).notifier).state = !isExpanded;
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
      ),
    );
  }

  Widget _buildMembersSection({required House house}) {
    if ((house.createdBy == null || house.createdBy!.userId!.isEmpty) &&
        (house.userSummaries == null || house.userSummaries!.isEmpty)) {
      return SizedBox.shrink();
    }

    List<UserSummary> userSummaries = [];
    if (house.userSummaries != null) {
      userSummaries = house.userSummaries!.take(4).toList();
    }

    List<Color> userSummariesBgColors = [Color(0xFFC3E9F7), Color(0xFFCACDFF), Color(0xFFF7D7A9), Color(0xFFD3F0BE)];

    return Container(
      // margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 8, top: 12, bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admin section
            if (house.createdBy != null && house.createdBy!.userId!.isNotEmpty && house.showHostDetails!)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorsPalette.redColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Hosted By",
                        style: DesignFonts.poppins.merge(
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: ColorsPalette.redColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
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
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              house.createdBy?.profilePictureUrl ?? "",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    width: 40,
                                    height: 40,
                                    color: Colors.grey.shade200,
                                    child: Icon(Icons.person, size: 18, color: Colors.grey.shade600),
                                  ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  house.createdBy?.name ?? 'Unknown',
                                  style: DesignFonts.poppins.merge(
                                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  house.createdBy?.userName ?? 'Unknown',
                                  style: DesignFonts.poppins.merge(TextStyle(fontSize: 12, color: Colors.black54)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 4),
                          DesignText(
                            text: "+${house.admins.toSet().length - 1} more...",
                            fontSize: 10,
                            color: DesignColors.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Divider
            if (house.createdBy != null && userSummaries.isNotEmpty && house.showHostDetails!)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: 1,
                height: 80,
                color: Colors.grey.shade200,
              ),

            // Members section
            if (house.userSummaries != null && userSummaries.isNotEmpty)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Get.to(() => HouseFollowersScreen(houseId: house.id ?? '', houseName: house.name ?? ''));
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Members",
                              style: DesignFonts.poppins.merge(
                                TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue),
                              ),
                            ),
                            SizedBox(width: 4),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                house.followerCount?.toString() ?? '0',
                                style: DesignFonts.poppins.merge(
                                  TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      if (userSummaries.isNotEmpty)
                        Container(
                          height: 40,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              for (int i = 0; i < userSummaries.length; i++)
                                Positioned(
                                  left: i * 22,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: userSummariesBgColors[i % userSummariesBgColors.length],
                                      child:
                                          i == 3 && house.followerCount! > 4
                                              ? Text(
                                                "+${house.followerCount! - 3}",
                                                style: DesignFonts.poppins.merge(
                                                  TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              )
                                              : ClipOval(
                                                child: Image.network(
                                                  userSummaries[i].profilePictureUrl,
                                                  fit: BoxFit.cover,
                                                  width: 36,
                                                  height: 36,
                                                  errorBuilder:
                                                      (context, error, stackTrace) =>
                                                          Icon(Icons.person, size: 18, color: Colors.grey.shade600),
                                                ),
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
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialHandel({required House house}) {
    if (house.socialMediaLinks.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(12.r),
        // border: Border.all(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children:
              house.socialMediaLinks.map((link) {
                // Define icon, color based on social media type
                IconData icon;
                Color color;

                switch (link.type) {
                  case 'FB':
                    icon = FontAwesomeIcons.facebook;
                    color = Colors.blue.shade800;
                    break;
                  case 'IG':
                    icon = FontAwesomeIcons.instagram;
                    color = Colors.pink;
                    break;
                  case 'YOUTUBE':
                    icon = FontAwesomeIcons.youtube;
                    color = Colors.red;
                    break;
                  case 'LINKEDIN':
                    icon = FontAwesomeIcons.linkedin;
                    color = Colors.blue.shade700;
                    break;
                  case 'TWITTER':
                    icon = FontAwesomeIcons.twitter;
                    color = Colors.blue;
                    break;
                  case 'TIKTOK':
                    icon = FontAwesomeIcons.tiktok;
                    color = Colors.black;
                    break;
                  default:
                    icon = FontAwesomeIcons.link;
                    color = Colors.grey;
                }

                return InkWell(
                  onTap: () => _launchSocialMedia(link.type, link.url),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(icon, color: color, size: 20),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  void _launchSocialMedia(String type, String username) async {
    String url;
    String appUrl;

    switch (type) {
      case 'FB':
        // Try to open Facebook app first, then website
        appUrl = 'fb://profile/$username';
        url = 'https://facebook.com/$username';
        break;
      case 'IG':
        // Remove @ if present for the URL
        String cleanUsername = username.startsWith('@') ? username.substring(1) : username;
        appUrl = 'instagram://user?username=$cleanUsername';
        url = 'https://instagram.com/$cleanUsername';
        break;
      case 'YOUTUBE':
        appUrl = 'youtube://user/$username';
        url = 'https://youtube.com/$username';
        break;
      case 'LINKEDIN':
        appUrl = 'linkedin://profile/$username';
        url = 'https://linkedin.com/in/$username';
        break;
      case 'TWITTER':
        appUrl = 'twitter://user?screen_name=$username';
        url = 'https://twitter.com/$username';
        break;
      case 'TIKTOK':
        appUrl = 'tiktok://user/$username';
        url = 'https://tiktok.com/@$username';
        break;
      default:
        // If it's not a recognized platform, just try to open as URL
        if (username.startsWith('http')) {
          url = username;
        } else {
          url = 'https://$username';
        }
        appUrl = url;
    }

    // Try to launch the app first
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        // If app launch fails, open in browser
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          // Show error if both fail
          Fluttertoast.showToast(
            msg: 'Could not open link',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      }
    } catch (e) {
      // Fallback to web URL if app launch throws an error
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        Fluttertoast.showToast(
          msg: 'Could not open link',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }

  Widget _buildAboutSection({required House house}) {
    if (house.description == null || house.description!.isEmpty) {
      return SizedBox.shrink();
    }

    return RichTextDisplay(controller: TextEditingController(text: house.description), hintText: '');
  }

  Widget _buildCompactSectionHeader({required IconData icon, required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 15, // Reduced from 16.sp
            color: ColorsPalette.redColor,
          ),
          SizedBox(width: 8), // Reduced from 8.w
          Text(
            title,
            style: TextStyle(
              fontSize: 13, // Reduced from 14.sp
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection({required House house}) {
    return Row(
      children: [
        ...house.categories!.map((category) {
          return Padding(
            padding: EdgeInsets.only(right: 8), // Reduced spacing
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6), // More compact padding
              decoration: BoxDecoration(
                color: ColorsPalette.redColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                category.name,
                style: TextStyle(
                  fontSize: 11, // Smaller font
                  fontWeight: FontWeight.w500,
                  color: ColorsPalette.redColor,
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildHouseHeader({required House house}) {
    final bool isFollowing = house.userStatus == 'MEMBER';

    return Container(
      margin: EdgeInsets.only(bottom: 12), // Reduced from 16.h
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Changed from start to center
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side with name and categories
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  house.name ?? 'Unknown House',
                  style: DesignFonts.poppins.merge(
                    TextStyle(
                      fontSize: 22, // Reduced from 26.sp
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3, // Reduced from -0.5
                      height: 1.1, // Reduced from 1.2
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),

          // Right side with follow status indicator (only when following)
          // _buildFollowStatusIndicator(isFollowing: isFollowing, house: house),
        ],
      ),
    );
  }

  Widget _buildFollowStatusIndicator({required bool isFollowing, required House house}) {
    // Only show this when the user is following
    // if ((!isFollowing || house.userStatus == 'ADMIN') && !widget.isPublicView) {
    //   return const SizedBox.shrink();
    // }
    final sw = Get.width;
    final sh = Get.height;

    return GestureDetector(
      onTap: () async {
        HapticFeedback.selectionClick();
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
      },
      child: Container(
        height: 32, // Reduced from 36.h
        width: min(124, 0.2 * sw),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Reduced from 18.r
          color: house.userStatus != 'VISITOR' ? Colors.white : DesignColors.accent,
          border: Border.all(
            color: ColorsPalette.redColor,
            width: 1.2, // Reduced from 1.5
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08), // Reduced opacity
              spreadRadius: 0,
              blurRadius: 3, // Reduced from 4
              offset: const Offset(0, 1), // Reduced from (0, 2)
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Reduced from horizontal: 16.w, vertical: 8.h
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (house.userStatus != 'VISITOR')
                Icon(
                  house.userStatus == 'ADMIN' ? Icons.admin_panel_settings : Icons.check,
                  size: 14, // Reduced from 16
                  color: ColorsPalette.redColor,
                ),
              SizedBox(width: 4), // Reduced from 6.w
              Text(
                house.userStatus == 'ADMIN'
                    ? "Admin"
                    : house.userStatus == 'MEMBER'
                    ? "Following"
                    : "Follow",
                style: TextStyle(
                  fontSize: 12, // Reduced from 13
                  color: house.userStatus != 'VISITOR' ? ColorsPalette.redColor : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 40,
      left: 16,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const CircleAvatar(
          backgroundColor: ColorsPalette.backGroundgreyColor,
          child: Icon(Icons.chevron_left, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildHousePhotoGallery({required House house}) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: 0.4 * Get.height,
          //  minHeight: 0.2 * Get.height
           ),
        
          child: PageView.builder(
            controller: pageController,
            itemCount: house.photos?.length ?? 0,
            onPageChanged: (index) {
              // Page changed
              setState(() {});
            },
            itemBuilder: (context, index) {
              String url = house.photos?[index] ?? "";
              if (!(house.photos![index].toLowerCase().contains('.png') ||
                  house.photos![index].toLowerCase().contains('.jpeg') ||
                  house.photos![index].toLowerCase().contains('.jpg'))) {
                url =
                    "https://images.weserv.nl/?url=${Uri.encodeComponent(house.photos![index])}&w=640&h=640&fit=cover&output=webp&q=30&l=9&il&af=auto";
              }
              return Container(
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
                child: BackdropFilter(
                  filter: ImageFilter.compose(
                    outer: ImageFilter.blur(sigmaX: 6, sigmaY: 4),
                    inner: ImageFilter.dilate(radiusX: 2, radiusY: 2),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4), // Tint color
                      
                      border: Border.all(color: Colors.black.withOpacity(0.25), width: 1.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20)),
                      child: Image.network(
                        url,
                        fit: BoxFit.scaleDown,
                        width: MediaQuery.of(context).size.width,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            (loadingProgress.expectedTotalBytes ?? 1)
                                        : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          return Container(
                            color: Colors.grey,
                            width: double.infinity,
                            child: const Icon(Icons.broken_image, color: Colors.white, size: 40),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        Positioned(
          top: 40,
          right: 16,
          child: GestureDetector(
            onTap: () async {
              await ShareUtility.showShareBottomSheet(context: context, entityType: EntityType.house, entity: house);
            },
            child: const CircleAvatar(
              backgroundColor: ColorsPalette.backGroundgreyColor,
              child: Icon(Icons.share, color: Colors.white),
            ),
          ),
        ),
        // if (house.rating != null)
        //   Positioned(
        //     bottom: 16.h, // Reduced from 20.h
        //     right: 16.w, // Reduced from 20.w
        //     child: Container(
        //       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r), color: Colors.white),
        //       child: Row(
        //         children: [
        //           DesignIcon.custom(icon: DesignIcons.star, color: null, size: 14.sp),
        //           Space.w(width: 4.w),
        //           DesignText(
        //             text: "${house.rating?.average ?? 0} (${house.rating?.count ?? 0})",
        //             fontSize: 12.sp,
        //             fontWeight: FontWeight.w400,
        //             color: Color(0xFF444444),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
      ],
    );
  }

  Widget _buildProfileImage({required House house}) {
    final sw = Get.width;
    final sh = Get.height;
     String url =  house.profilePhoto ?? "";
    if (!(url.toLowerCase().contains('.png') ||
         url.toLowerCase().contains('.jpeg') ||
         url.toLowerCase().contains('.jpg'))) {
      url =
          "https://images.weserv.nl/?url=${Uri.encodeComponent(url)}&w=640&h=640&fit=cover&output=webp&q=30&l=9&il&af=auto";
    }
    return Container(
      height: 0.2 * sw,
      width: 0.2 * sw,
      constraints: BoxConstraints(maxHeight: 124, maxWidth: 124),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, spreadRadius: 0, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(3), // Border width
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.2 * sw),
          child: Image.network(
            house.profilePhoto ?? '',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: ColorsPalette.redColor.withOpacity(0.1),
                child: Icon(Icons.home_rounded, color: ColorsPalette.redColor, size: 36),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDotsIndicator({required House house}) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 1.0,
      right: MediaQuery.of(context).size.width * 0.05,
      child: Row(
        children: List.generate(
          house.photos?.length ?? 0,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: pageController.hasClients && pageController.page?.round() == index ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
