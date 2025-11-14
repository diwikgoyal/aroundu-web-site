import 'package:aroundu/designs/card_colors.designs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lobby.freezed.dart';
part 'lobby.g.dart';

@freezed
class Lobby with _$Lobby {
  @JsonSerializable(explicitToJson: true)
  factory Lobby({
    required String id,
    required int createdDate,
    // required int lastModifiedDate,
    required String userId,
    @Default("") String lobbyStatus,
    required Filter filter,
    @Default("") String description,
    @Default("") String title,
    @Default(<String>[]) List<String> mediaUrls,
    @Default("PRIVATE") String lobbyType,
    @Default(0) int totalMembers,
    @Default(0) int currentMembers,
    @Default(0) int membersRequired,
    @JsonKey(includeFromJson: false) @Default(defaultColorScheme) CardColorScheme colorScheme,
    @Default("MALE") String gender,
    @Default("VISITOR") String userStatus,
    @Default(AdminSummary(userId: "", profilePictureUrl: "")) AdminSummary adminSummary,
    ContentModel? content,
    @Default(Setting()) Setting setting,
    // Setting? settings,
    @Default("") String activity,
    // Map<String,dynamic>? lobbyRules,
    FormModel? form,
    HouseInfo? houseDetail,
    List<UserSummary>? userSummaries,
    @Default({}) Map<String, dynamic> dateRange,
    // @Default(0.0) double price,
    LobbyRestriction? restriction,
    @Default(PriceDetails()) PriceDetails priceDetails,
    @Default(false) bool isAdvancedPricing,
    @Default(false) bool allowMultiplePricingOptions,
    @Default(<LobbyTicketOption>[]) List<LobbyTicketOption> ticketOptions,
    AccessRequestData? accessRequestData,
    @Default(false) bool hasForm,
    @Default(false) bool hasOffer,
    @Default(false) bool isSaved,
    @Default(false) bool isFormMandatory,
    @Default(false) bool isRefundNotPossible,
    @Default(Rating()) Rating rating,
    @Default([]) List<PriceTier>? priceTierList,
    @Default(false) bool ratingGiven,
    @Default(false) bool loginNotRequired,
  }) = _Lobby;

  factory Lobby.fromJson(Map<String, dynamic> json) => _$LobbyFromJson(json);
}

@freezed
class Rating with _$Rating {
  @JsonSerializable(explicitToJson: true)
  const factory Rating({@Default(0.0) double average, @Default(0) int count}) = _Rating;
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}

@freezed
class FormModel with _$FormModel {
  @JsonSerializable(explicitToJson: true)
  const factory FormModel({@Default('') String title, @Default(<Question>[]) List<Question> questions}) = _FormModel;
  factory FormModel.fromJson(Map<String, dynamic> json) => _$FormModelFromJson(json);
}

@freezed
class Setting with _$Setting {
  @JsonSerializable(explicitToJson: true)
  const factory Setting({
    @Default(true) bool showLobbyMembers,
    @Default(true) bool enableChat,
    @Default(true) bool showMembers,
  }) = _Setting;
  factory Setting.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);
}

@freezed
class Question with _$Question {
  @JsonSerializable(explicitToJson: true)
  const factory Question({
    @Default('') String id,
    @Default('') String questionText,
    @Default('') String questionType,
    @Default(<String>[]) List<String> options,
    @Default('') String answer,
    @Default(false) bool isMandatory,
    @Default('') String questionLabel,
    @Default('') String dataKey,
  }) = _Question;
  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
}

@freezed
class UserSummary with _$UserSummary {
  @JsonSerializable(explicitToJson: true)
  const factory UserSummary({
    @Default("") String userId,
    @Default("") String userName,
    @Default("") String name,
    @Default("") String email,
    @Default("") String gender,
    @Default("") String profilePictureUrl,
    Location? location,
    @Default(false) bool active,
    @Default("") String dob,
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, dynamic> json) => _$UserSummaryFromJson(json);
}

@freezed
class LobbyRestriction with _$LobbyRestriction {
  @JsonSerializable(explicitToJson: true)
  const factory LobbyRestriction({
    @Default("") String genderRestriction,
    @Default(AgeRange()) AgeRange ageRange,
    int? maxMales,
    int? maxFemales,
    int? maxOthers,
  }) = _LobbyRestriction;

  factory LobbyRestriction.fromJson(Map<String, dynamic> json) => _$LobbyRestrictionFromJson(json);
}

@freezed
class AgeRange with _$AgeRange {
  @JsonSerializable(explicitToJson: true)
  const factory AgeRange({@Default(0) int minAge, @Default(100) int maxAge}) = _AgeRange;

  factory AgeRange.fromJson(Map<String, dynamic> json) => _$AgeRangeFromJson(json);
}

@freezed
class PriceDetails with _$PriceDetails {
  @JsonSerializable(explicitToJson: true)
  const factory PriceDetails({
    @Default(0.0) double price,
    @Default(0.0) double originalPrice,
    @Default("INR") String currency,
    @Default(false) bool isRefundAllowed,
  }) = _PriceDetails;

  factory PriceDetails.fromJson(Map<String, dynamic> json) => _$PriceDetailsFromJson(json);
}

@freezed
class LobbyTicketOption with _$LobbyTicketOption {
  @JsonSerializable(explicitToJson: true)
  const factory LobbyTicketOption({
    @Default("") String id,
    @Default("") String name,
    @Default("") String description,
    @Default(0.0) double price,
    @Default(0) int totalSlots,
    @Default(0) int bookedSlots,
    @Default("INR") String currency,
    @Default(1) int minQuantity,
    @Default(1) int maxQuantity, // per person
    @Default("") String activity, // HIGH, LOW, MID, FULL
    @Default(false) bool isDisabled,
  }) = _LobbyTicketOption;

  factory LobbyTicketOption.fromJson(Map<String, dynamic> json) => _$LobbyTicketOptionFromJson(json);
}

@freezed
class AccessRequestData with _$AccessRequestData {
  @JsonSerializable(explicitToJson: true)
  const factory AccessRequestData({
    @Default("") String accessId,
    @Default(false) bool isGroupAccess,
    @Default(0) int count,
    @Default(0.0) double price,
    @Default(false) bool isAdmin,
  }) = _AccessRequestData;

  factory AccessRequestData.fromJson(Map<String, dynamic> json) => _$AccessRequestDataFromJson(json);
}

@freezed
class HouseInfo with _$HouseInfo {
  @JsonSerializable(explicitToJson: true)
  const factory HouseInfo({
    @Default("") String houseId,
    @Default("") String name,
    @Default("") String description,
    @Default("") String profilePhoto,
    @Default(false) bool panVerified,
    @Default(false) bool accountVerified,
    @Default(false) bool gstVerified,
    @Default(false) bool loginNotRequired,
  }) = _HouseInfo;

  factory HouseInfo.fromJson(Map<String, dynamic> json) => _$HouseInfoFromJson(json);
}

@freezed
class AdminSummary with _$AdminSummary {
  @JsonSerializable(explicitToJson: true)
  const factory AdminSummary({
    required String userId,
    @Default("") String userName,
    @Default("") String name,
    @Default("") String gender,
    @Default("") String profilePictureUrl,
    @Default(false) bool isFriend,
    @Default(false) bool requestSent,
    @Default(false) bool requestReceived,
    Location? location,
    @Default(false) bool active,
  }) = _AdminSummary;

  factory AdminSummary.fromJson(Map<String, dynamic> json) => _$AdminSummaryFromJson(json);
}

@freezed
class ContentModel with _$ContentModel {
  const factory ContentModel({@Default("") String title, @Default("") String body}) = _ContentModel;

  factory ContentModel.fromJson(Map<String, dynamic> json) => _$ContentModelFromJson(json);
}

@freezed
class PriceTier with _$PriceTier {
  @JsonSerializable(explicitToJson: true)
  const factory PriceTier({@Default(0) int minSlots, @Default(0) int maxSlots, @Default(0.0) double price}) =
      _PriceTier;

  factory PriceTier.fromJson(Map<String, dynamic> json) => _$PriceTierFromJson(json);
}

@freezed
class Filter with _$Filter {
  @JsonSerializable(explicitToJson: true)
  const factory Filter({
    required String categoryId,
    @Default('') String categoryName,
    required String subCategoryId,
    @Default('') String subCategoryName,
    @Default([]) List<FilterInfo> filterInfoList,
    @Default([]) List<FilterInfo> advancedFilterInfoList,
    @Default(OtherFilterInfo()) OtherFilterInfo otherFilterInfo,
    required int? createdDate,
    // required int lastModifiedDate,
  }) = _Filter;

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
}

@freezed
class FilterInfo with _$FilterInfo {
  @JsonSerializable(explicitToJson: true)
  const factory FilterInfo({
    @Default([]) List<String> options,
    required String title,
    String? iconUrl,
    @Default("") String filterType,
    @Default(0) int weightage,
    @Default(false) bool showInCompactView,
  }) = _FilterInfo;

  factory FilterInfo.fromJson(Map<String, dynamic> json) => _$FilterInfoFromJson(json);
}

@freezed
class OtherFilterInfo with _$OtherFilterInfo {
  @JsonSerializable(explicitToJson: true)
  const factory OtherFilterInfo({
    DateInfo? dateInfo,
    DateRange? dateRange,
    Destination? destination,
    PaidLobby? paidLobby,
    PickUp? pickUp,
    MemberCount? memberCount,
    @JsonKey(includeToJson: false) CurrentCount? currentCount,
    Range? range,
    LocationInfo? locationInfo,
    LocationInfo? multipleLocations,
    List<Info>? info,
  }) = _OtherFilterInfo;

  factory OtherFilterInfo.fromJson(Map<String, dynamic> json) => _$OtherFilterInfoFromJson(json);
}

@freezed
class DateInfo with _$DateInfo {
  @JsonSerializable(explicitToJson: true)
  const factory DateInfo({
    required int date,
    required String title,
    String? formattedDate,
    String? iconUrl,
    @Default("DATE") String filterType,
    @Default(0) int weightage,
    @Default(false) bool showInCompactView,
  }) = _DateInfo;

  factory DateInfo.fromJson(Map<String, dynamic> json) => _$DateInfoFromJson(json);
}

@freezed
class DateRange with _$DateRange {
  @JsonSerializable(explicitToJson: true)
  const factory DateRange({
    required int startDate,
    required int endDate,
    required String title,
    String? formattedDate,
    @Default("") String formattedDateCompactView,
    String? iconUrl,
    @Default("DATE_RANGE") String filterType,
    @Default(0) int weightage,
    @Default(false) bool showInCompactView,
  }) = _DateRange;

  factory DateRange.fromJson(Map<String, dynamic> json) => _$DateRangeFromJson(json);
}

@freezed
class Destination with _$Destination {
  @JsonSerializable(explicitToJson: true)
  const factory Destination({
    required String title,
    Location? location,
    LocationResponse? locationResponse,
    String? iconUrl,
    GoogleSearchResponse? googleSearchResponse,
    @Default("LOCATION") String filterType,
    @Default(0) int weightage,
    @Default(false) bool showInCompactView,
  }) = _Destination;

  factory Destination.fromJson(Map<String, dynamic> json) => _$DestinationFromJson(json);
}

@freezed
class PaidLobby with _$PaidLobby {
  @JsonSerializable(explicitToJson: true)
  const factory PaidLobby({
    @Default(false) bool isPaid,
    required String title,
    String? iconUrl,
    @Default(0) double value,
    @Default("RADIO_BUTTON_WITH_INPUT") String filterType,
    @Default(0) int weightage,
    @Default(false) bool showInCompactView,
  }) = _PaidLobby;

  factory PaidLobby.fromJson(Map<String, dynamic> json) => _$PaidLobbyFromJson(json);
}

@freezed
class PickUp with _$PickUp {
  @JsonSerializable(explicitToJson: true)
  const factory PickUp({
    required String title,
    Location? location,
    LocationResponse? locationResponse,
    String? iconUrl,
    GoogleSearchResponse? googleSearchResponse,
    @Default("LOCATION") String filterType,
    @Default(0) int weightage,
    @Default(false) bool showInCompactView,
  }) = _PickUp;

  factory PickUp.fromJson(Map<String, dynamic> json) => _$PickUpFromJson(json);
}

@freezed
class MemberCount with _$MemberCount {
  @JsonSerializable(explicitToJson: true)
  const factory MemberCount({
    @Default(0) int value,
    required String title,
    String? iconUrl,
    @Default("INPUT") String filterType,
    @Default(0) int weightage,
    @Default(false) bool showInCompactView,
  }) = _MemberCount;

  factory MemberCount.fromJson(Map<String, dynamic> json) => _$MemberCountFromJson(json);
}

@freezed
class CurrentCount with _$CurrentCount {
  const factory CurrentCount({
    @Default(0) int value,
    @Default('Current count') String title,
    String? iconUrl,
    @Default("INPUT") String filterType,
    @Default(0) int weightage,
    @Default(false) bool showInCompactView,
  }) = _CurrentCount;

  factory CurrentCount.fromJson(Map<String, dynamic> json) => _$CurrentCountFromJson(json);
}

@freezed
class Range with _$Range {
  @JsonSerializable(explicitToJson: true)
  const factory Range({
    @Default(0) int min,
    @Default(0) int max,
    required String title,
    String? iconUrl,
    @Default("SLIDER") String filterType,
    @Default(0) int weightage,
    @Default(false) bool showInCompactView,
  }) = _Range;

  factory Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);
}

@freezed
class Info with _$Info {
  @JsonSerializable(explicitToJson: true)
  const factory Info({
    @Default(0) double value,
    String? iconUrl,
    required String title,
    @Default("INPUT") String filterType,
    @Default(0) int weightage,
    @Default(false) bool showInCompactView,
  }) = _Info;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}

@freezed
class LocationInfo with _$LocationInfo {
  @JsonSerializable(explicitToJson: true)
  const factory LocationInfo({
    String? title,
    @Default([]) List<LocationResponse> locationResponses,
    @Default(0) int weightage,
    String? iconUrl,
    @Default("LOCATION") String filterType,
    @Default(true) bool showInCompactView,
    @Default(false) bool hideLocation,
    @Default([]) List<GoogleSearchResponse> googleSearchResponses,
  }) = _LocationInfo;

  factory LocationInfo.fromJson(Map<String, dynamic> json) => _$LocationInfoFromJson(json);
}

@freezed
class Location with _$Location {
  @JsonSerializable(explicitToJson: true)
  const factory Location({@Default(0.0) double? lat, @Default(0.0) double? lon}) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}

@freezed
class LocationResponse with _$LocationResponse {
  @JsonSerializable(explicitToJson: true)
  const factory LocationResponse({
    @Default(Location()) Location exactLocation,
    @Default(Location()) Location approxLocation,
    @Default('') String areaName,
    @Default('') String fuzzyAddress,
  }) = _LocationResponse;
  factory LocationResponse.fromJson(Map<String, dynamic> json) => _$LocationResponseFromJson(json);
}

@freezed
class Position with _$Position {
  @JsonSerializable(explicitToJson: true)
  const factory Position({required int row, required int column}) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
}

@freezed
class GoogleSearchResponse with _$GoogleSearchResponse {
  @JsonSerializable(explicitToJson: true)
  const factory GoogleSearchResponse({
    required String? description,
    @JsonKey(name: 'place_id') required String? placeId,
    @JsonKey(name: 'structured_formatting') required StructuredFormatting? structuredFormatting,
  }) = _GoogleSearchResponse;

  factory GoogleSearchResponse.fromJson(Map<String, dynamic> json) => _$GoogleSearchResponseFromJson(json);
}

@freezed
class StructuredFormatting with _$StructuredFormatting {
  @JsonSerializable(explicitToJson: true)
  const factory StructuredFormatting({
    @JsonKey(name: 'main_text') String? mainText,
    @JsonKey(name: 'secondary_text') String? secondaryText,
  }) = _StructuredFormatting;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) => _$StructuredFormattingFromJson(json);
}

extension QuestionHelpers on Question {
  Question removeOption(int index) {
    final updatedOptions = List.of(options)..removeAt(index);
    return copyWith(options: updatedOptions);
  }
}

extension LobbyExtension on Lobby {
  int get maxCompactItemsCount => 6;
  bool get isPrivate => lobbyType == 'PRIVATE';
  List<CompactItemModel> get compactItems {
    // Sort and filter 'filterInfoList'
    final filterInfoCompactList = List.of(filter.filterInfoList)
      ..retainWhere((info) => info.showInCompactView)
      ..sort((a, b) => b.weightage.compareTo(a.weightage)); // Sort in place

    // Sort 'otherFilterInfo'
    final otherFilterCompactList = List.of(filter.otherFilterInfo.getCompactView())
      ..sort((a, b) => b.weightage.compareTo(a.weightage)); // Sort in place

    final advancedFilterInfoCompactList = List.of(filter.advancedFilterInfoList)
      ..retainWhere((info) => info.showInCompactView)
      ..sort((a, b) => b.weightage.compareTo(a.weightage));

    // Combine both lists with a limit of maxCompactItemsCount
    final combinedList = [
      // Take the remaining items from 'otherFilterCompactList' based on available space in 'maxCompactItemsCount'
      ...otherFilterCompactList
      // .take(maxCompactItemsCount )
      .map((info) => CompactItemModel(info.iconUrl, info.content, info.weightage)),

      // Take the maximum items from 'filterInfoCompactList' and map to CompactItemModel
      ...filterInfoCompactList
      // .take(maxCompactItemsCount- filterInfoCompactList.length)
      .map((info) => CompactItemModel(info.iconUrl, info.options.join(', '), info.weightage)),

      ...advancedFilterInfoCompactList
      // .take(maxCompactItemsCount- filterInfoCompactList.length)
      .map((info) => CompactItemModel(info.iconUrl, info.options.join(', '), info.weightage)),
    ];

    final finalSortedList = List.of(combinedList)..sort((a, b) => b.weightage.compareTo(a.weightage));

    final topItems = finalSortedList.take(6).toList();

    // Ensure the final list size is 'maxCompactItemsCount' by adding empty items if needed
    while (topItems.length < maxCompactItemsCount) {
      topItems.add(CompactItemModel(null, '', 0));
    }

    // Return the final combined list
    return topItems;
  }
}

extension OtherFilterInfoExtension on OtherFilterInfo {
  List<CompactViewItem> getCompactView() {
    return [
      if (dateInfo?.showInCompactView ?? false) dateInfo!._toCompactViewItem(),
      if (dateRange?.showInCompactView ?? false) dateRange!._toCompactViewItem(),
      if (destination?.showInCompactView ?? false) destination!._toCompactViewItem(),
      if (paidLobby?.showInCompactView ?? false) paidLobby!._toCompactViewItem(),
      if (pickUp?.showInCompactView ?? false) pickUp!._toCompactViewItem(),
      if (memberCount?.showInCompactView ?? false) memberCount!._toCompactViewItem(),
      if (currentCount?.showInCompactView ?? false) currentCount!._toCompactViewItem(),
      if (range?.showInCompactView ?? false) range!._toCompactViewItem(),
      if (locationInfo?.showInCompactView ?? false) locationInfo!._toCompactViewItem(),
      // if (info?.showInCompactView ?? false)
      //   info!._toCompactViewItem(),
    ];
  }

  String get membersJoined => '${currentCount?.value} / ${memberCount?.value}';
}

class CompactViewItem {
  final String? iconUrl;
  final String content;
  final int weightage;

  CompactViewItem(this.iconUrl, this.content, this.weightage);
}

extension DateInfoExtension on DateInfo {
  CompactViewItem _toCompactViewItem() => CompactViewItem(iconUrl, formattedDate!, weightage);
}

class CompactItemModel {
  final String? iconUrl;
  final String content;
  final int weightage;
  CompactItemModel(this.iconUrl, this.content, this.weightage);
  @override
  String toString() {
    return 'CompactItemModel(iconUrl: $iconUrl, content: $content)';
  }
}

extension DateRangeExtension on DateRange {
  CompactViewItem _toCompactViewItem() => CompactViewItem(iconUrl, formattedDateCompactView, weightage);
}

extension DestinationExtension on Destination {
  CompactViewItem _toCompactViewItem() =>
      CompactViewItem(iconUrl, googleSearchResponse?.structuredFormatting?.mainText ?? 'Unknown', weightage);
}

extension PaidLobbyExtension on PaidLobby {
  CompactViewItem _toCompactViewItem() => CompactViewItem(iconUrl, isPaid ? 'Paid' : 'Free', weightage);
}

extension PickUpExtension on PickUp {
  CompactViewItem _toCompactViewItem() =>
      CompactViewItem(iconUrl, googleSearchResponse?.structuredFormatting?.mainText ?? 'Unknown', weightage);
}

extension MemberCountExtension on MemberCount {
  CompactViewItem _toCompactViewItem() => CompactViewItem(iconUrl, 'Total members: $value', weightage);
}

extension CurrentCountExtension on CurrentCount {
  CompactViewItem _toCompactViewItem() => CompactViewItem(iconUrl, 'Current members: $value', weightage);
}

extension RangeExtension on Range {
  CompactViewItem _toCompactViewItem() => CompactViewItem(iconUrl, '$min to $max', weightage);
}

extension LocationInfoExtension on LocationInfo {
  CompactViewItem _toCompactViewItem() => CompactViewItem(iconUrl, getLocationDisplayText(), weightage);

  String getLocationDisplayText() {
    // If location info is null or empty
    if (locationResponses.isEmpty && googleSearchResponses.isEmpty) {
      return 'Unknown';
    }

    // Case 1: Location is hidden, fuzzy address exists
    if (hideLocation && (locationResponses.firstOrNull?.fuzzyAddress.isNotEmpty ?? false)) {
      return locationResponses.firstOrNull?.fuzzyAddress ?? 'Unknown';
    }

    // Case 2: Google search responses exist
    if (googleSearchResponses.isNotEmpty && googleSearchResponses.first.description != null) {
      return googleSearchResponses.first.description ?? 'Unknown';
    }

    // Case 3: Location responses exist
    if (locationResponses.isNotEmpty) {
      return locationResponses.first.areaName.isNotEmpty ? locationResponses.first.areaName : 'Unknown';
    }

    // Default case
    return 'Unknown';
  }
}

extension InfoExtension on Info {
  CompactViewItem _toCompactViewItem() => CompactViewItem(iconUrl, 'Price: $value', weightage);
}
