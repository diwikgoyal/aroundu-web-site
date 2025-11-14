// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lobby.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Lobby _$LobbyFromJson(Map<String, dynamic> json) {
  return _Lobby.fromJson(json);
}

/// @nodoc
mixin _$Lobby {
  String get id => throw _privateConstructorUsedError;
  int get createdDate =>
      throw _privateConstructorUsedError; // required int lastModifiedDate,
  String get userId => throw _privateConstructorUsedError;
  String get lobbyStatus => throw _privateConstructorUsedError;
  Filter get filter => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<String> get mediaUrls => throw _privateConstructorUsedError;
  String get lobbyType => throw _privateConstructorUsedError;
  int get totalMembers => throw _privateConstructorUsedError;
  int get currentMembers => throw _privateConstructorUsedError;
  int get membersRequired => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false)
  CardColorScheme get colorScheme => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get userStatus => throw _privateConstructorUsedError;
  AdminSummary get adminSummary => throw _privateConstructorUsedError;
  ContentModel? get content => throw _privateConstructorUsedError;
  Setting get setting =>
      throw _privateConstructorUsedError; // Setting? settings,
  String get activity =>
      throw _privateConstructorUsedError; // Map<String,dynamic>? lobbyRules,
  FormModel? get form => throw _privateConstructorUsedError;
  HouseInfo? get houseDetail => throw _privateConstructorUsedError;
  List<UserSummary>? get userSummaries => throw _privateConstructorUsedError;
  Map<String, dynamic> get dateRange =>
      throw _privateConstructorUsedError; // @Default(0.0) double price,
  LobbyRestriction? get restriction => throw _privateConstructorUsedError;
  PriceDetails get priceDetails => throw _privateConstructorUsedError;
  bool get isAdvancedPricing => throw _privateConstructorUsedError;
  bool get allowMultiplePricingOptions => throw _privateConstructorUsedError;
  List<LobbyTicketOption> get ticketOptions =>
      throw _privateConstructorUsedError;
  AccessRequestData? get accessRequestData =>
      throw _privateConstructorUsedError;
  bool get hasForm => throw _privateConstructorUsedError;
  bool get hasOffer => throw _privateConstructorUsedError;
  bool get isSaved => throw _privateConstructorUsedError;
  bool get isFormMandatory => throw _privateConstructorUsedError;
  bool get isRefundNotPossible => throw _privateConstructorUsedError;
  Rating get rating => throw _privateConstructorUsedError;
  List<PriceTier>? get priceTierList => throw _privateConstructorUsedError;
  bool get ratingGiven => throw _privateConstructorUsedError;
  bool get loginNotRequired => throw _privateConstructorUsedError;

  /// Serializes this Lobby to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LobbyCopyWith<Lobby> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LobbyCopyWith<$Res> {
  factory $LobbyCopyWith(Lobby value, $Res Function(Lobby) then) =
      _$LobbyCopyWithImpl<$Res, Lobby>;
  @useResult
  $Res call({
    String id,
    int createdDate,
    String userId,
    String lobbyStatus,
    Filter filter,
    String description,
    String title,
    List<String> mediaUrls,
    String lobbyType,
    int totalMembers,
    int currentMembers,
    int membersRequired,
    @JsonKey(includeFromJson: false) CardColorScheme colorScheme,
    String gender,
    String userStatus,
    AdminSummary adminSummary,
    ContentModel? content,
    Setting setting,
    String activity,
    FormModel? form,
    HouseInfo? houseDetail,
    List<UserSummary>? userSummaries,
    Map<String, dynamic> dateRange,
    LobbyRestriction? restriction,
    PriceDetails priceDetails,
    bool isAdvancedPricing,
    bool allowMultiplePricingOptions,
    List<LobbyTicketOption> ticketOptions,
    AccessRequestData? accessRequestData,
    bool hasForm,
    bool hasOffer,
    bool isSaved,
    bool isFormMandatory,
    bool isRefundNotPossible,
    Rating rating,
    List<PriceTier>? priceTierList,
    bool ratingGiven,
    bool loginNotRequired,
  });

  $FilterCopyWith<$Res> get filter;
  $AdminSummaryCopyWith<$Res> get adminSummary;
  $ContentModelCopyWith<$Res>? get content;
  $SettingCopyWith<$Res> get setting;
  $FormModelCopyWith<$Res>? get form;
  $HouseInfoCopyWith<$Res>? get houseDetail;
  $LobbyRestrictionCopyWith<$Res>? get restriction;
  $PriceDetailsCopyWith<$Res> get priceDetails;
  $AccessRequestDataCopyWith<$Res>? get accessRequestData;
  $RatingCopyWith<$Res> get rating;
}

/// @nodoc
class _$LobbyCopyWithImpl<$Res, $Val extends Lobby>
    implements $LobbyCopyWith<$Res> {
  _$LobbyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdDate = null,
    Object? userId = null,
    Object? lobbyStatus = null,
    Object? filter = null,
    Object? description = null,
    Object? title = null,
    Object? mediaUrls = null,
    Object? lobbyType = null,
    Object? totalMembers = null,
    Object? currentMembers = null,
    Object? membersRequired = null,
    Object? colorScheme = null,
    Object? gender = null,
    Object? userStatus = null,
    Object? adminSummary = null,
    Object? content = freezed,
    Object? setting = null,
    Object? activity = null,
    Object? form = freezed,
    Object? houseDetail = freezed,
    Object? userSummaries = freezed,
    Object? dateRange = null,
    Object? restriction = freezed,
    Object? priceDetails = null,
    Object? isAdvancedPricing = null,
    Object? allowMultiplePricingOptions = null,
    Object? ticketOptions = null,
    Object? accessRequestData = freezed,
    Object? hasForm = null,
    Object? hasOffer = null,
    Object? isSaved = null,
    Object? isFormMandatory = null,
    Object? isRefundNotPossible = null,
    Object? rating = null,
    Object? priceTierList = freezed,
    Object? ratingGiven = null,
    Object? loginNotRequired = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            createdDate: null == createdDate
                ? _value.createdDate
                : createdDate // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            lobbyStatus: null == lobbyStatus
                ? _value.lobbyStatus
                : lobbyStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            filter: null == filter
                ? _value.filter
                : filter // ignore: cast_nullable_to_non_nullable
                      as Filter,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            mediaUrls: null == mediaUrls
                ? _value.mediaUrls
                : mediaUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            lobbyType: null == lobbyType
                ? _value.lobbyType
                : lobbyType // ignore: cast_nullable_to_non_nullable
                      as String,
            totalMembers: null == totalMembers
                ? _value.totalMembers
                : totalMembers // ignore: cast_nullable_to_non_nullable
                      as int,
            currentMembers: null == currentMembers
                ? _value.currentMembers
                : currentMembers // ignore: cast_nullable_to_non_nullable
                      as int,
            membersRequired: null == membersRequired
                ? _value.membersRequired
                : membersRequired // ignore: cast_nullable_to_non_nullable
                      as int,
            colorScheme: null == colorScheme
                ? _value.colorScheme
                : colorScheme // ignore: cast_nullable_to_non_nullable
                      as CardColorScheme,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            userStatus: null == userStatus
                ? _value.userStatus
                : userStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            adminSummary: null == adminSummary
                ? _value.adminSummary
                : adminSummary // ignore: cast_nullable_to_non_nullable
                      as AdminSummary,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as ContentModel?,
            setting: null == setting
                ? _value.setting
                : setting // ignore: cast_nullable_to_non_nullable
                      as Setting,
            activity: null == activity
                ? _value.activity
                : activity // ignore: cast_nullable_to_non_nullable
                      as String,
            form: freezed == form
                ? _value.form
                : form // ignore: cast_nullable_to_non_nullable
                      as FormModel?,
            houseDetail: freezed == houseDetail
                ? _value.houseDetail
                : houseDetail // ignore: cast_nullable_to_non_nullable
                      as HouseInfo?,
            userSummaries: freezed == userSummaries
                ? _value.userSummaries
                : userSummaries // ignore: cast_nullable_to_non_nullable
                      as List<UserSummary>?,
            dateRange: null == dateRange
                ? _value.dateRange
                : dateRange // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            restriction: freezed == restriction
                ? _value.restriction
                : restriction // ignore: cast_nullable_to_non_nullable
                      as LobbyRestriction?,
            priceDetails: null == priceDetails
                ? _value.priceDetails
                : priceDetails // ignore: cast_nullable_to_non_nullable
                      as PriceDetails,
            isAdvancedPricing: null == isAdvancedPricing
                ? _value.isAdvancedPricing
                : isAdvancedPricing // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowMultiplePricingOptions: null == allowMultiplePricingOptions
                ? _value.allowMultiplePricingOptions
                : allowMultiplePricingOptions // ignore: cast_nullable_to_non_nullable
                      as bool,
            ticketOptions: null == ticketOptions
                ? _value.ticketOptions
                : ticketOptions // ignore: cast_nullable_to_non_nullable
                      as List<LobbyTicketOption>,
            accessRequestData: freezed == accessRequestData
                ? _value.accessRequestData
                : accessRequestData // ignore: cast_nullable_to_non_nullable
                      as AccessRequestData?,
            hasForm: null == hasForm
                ? _value.hasForm
                : hasForm // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasOffer: null == hasOffer
                ? _value.hasOffer
                : hasOffer // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSaved: null == isSaved
                ? _value.isSaved
                : isSaved // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFormMandatory: null == isFormMandatory
                ? _value.isFormMandatory
                : isFormMandatory // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRefundNotPossible: null == isRefundNotPossible
                ? _value.isRefundNotPossible
                : isRefundNotPossible // ignore: cast_nullable_to_non_nullable
                      as bool,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as Rating,
            priceTierList: freezed == priceTierList
                ? _value.priceTierList
                : priceTierList // ignore: cast_nullable_to_non_nullable
                      as List<PriceTier>?,
            ratingGiven: null == ratingGiven
                ? _value.ratingGiven
                : ratingGiven // ignore: cast_nullable_to_non_nullable
                      as bool,
            loginNotRequired: null == loginNotRequired
                ? _value.loginNotRequired
                : loginNotRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterCopyWith<$Res> get filter {
    return $FilterCopyWith<$Res>(_value.filter, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdminSummaryCopyWith<$Res> get adminSummary {
    return $AdminSummaryCopyWith<$Res>(_value.adminSummary, (value) {
      return _then(_value.copyWith(adminSummary: value) as $Val);
    });
  }

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContentModelCopyWith<$Res>? get content {
    if (_value.content == null) {
      return null;
    }

    return $ContentModelCopyWith<$Res>(_value.content!, (value) {
      return _then(_value.copyWith(content: value) as $Val);
    });
  }

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettingCopyWith<$Res> get setting {
    return $SettingCopyWith<$Res>(_value.setting, (value) {
      return _then(_value.copyWith(setting: value) as $Val);
    });
  }

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FormModelCopyWith<$Res>? get form {
    if (_value.form == null) {
      return null;
    }

    return $FormModelCopyWith<$Res>(_value.form!, (value) {
      return _then(_value.copyWith(form: value) as $Val);
    });
  }

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HouseInfoCopyWith<$Res>? get houseDetail {
    if (_value.houseDetail == null) {
      return null;
    }

    return $HouseInfoCopyWith<$Res>(_value.houseDetail!, (value) {
      return _then(_value.copyWith(houseDetail: value) as $Val);
    });
  }

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LobbyRestrictionCopyWith<$Res>? get restriction {
    if (_value.restriction == null) {
      return null;
    }

    return $LobbyRestrictionCopyWith<$Res>(_value.restriction!, (value) {
      return _then(_value.copyWith(restriction: value) as $Val);
    });
  }

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceDetailsCopyWith<$Res> get priceDetails {
    return $PriceDetailsCopyWith<$Res>(_value.priceDetails, (value) {
      return _then(_value.copyWith(priceDetails: value) as $Val);
    });
  }

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccessRequestDataCopyWith<$Res>? get accessRequestData {
    if (_value.accessRequestData == null) {
      return null;
    }

    return $AccessRequestDataCopyWith<$Res>(_value.accessRequestData!, (value) {
      return _then(_value.copyWith(accessRequestData: value) as $Val);
    });
  }

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RatingCopyWith<$Res> get rating {
    return $RatingCopyWith<$Res>(_value.rating, (value) {
      return _then(_value.copyWith(rating: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LobbyImplCopyWith<$Res> implements $LobbyCopyWith<$Res> {
  factory _$$LobbyImplCopyWith(
    _$LobbyImpl value,
    $Res Function(_$LobbyImpl) then,
  ) = __$$LobbyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int createdDate,
    String userId,
    String lobbyStatus,
    Filter filter,
    String description,
    String title,
    List<String> mediaUrls,
    String lobbyType,
    int totalMembers,
    int currentMembers,
    int membersRequired,
    @JsonKey(includeFromJson: false) CardColorScheme colorScheme,
    String gender,
    String userStatus,
    AdminSummary adminSummary,
    ContentModel? content,
    Setting setting,
    String activity,
    FormModel? form,
    HouseInfo? houseDetail,
    List<UserSummary>? userSummaries,
    Map<String, dynamic> dateRange,
    LobbyRestriction? restriction,
    PriceDetails priceDetails,
    bool isAdvancedPricing,
    bool allowMultiplePricingOptions,
    List<LobbyTicketOption> ticketOptions,
    AccessRequestData? accessRequestData,
    bool hasForm,
    bool hasOffer,
    bool isSaved,
    bool isFormMandatory,
    bool isRefundNotPossible,
    Rating rating,
    List<PriceTier>? priceTierList,
    bool ratingGiven,
    bool loginNotRequired,
  });

  @override
  $FilterCopyWith<$Res> get filter;
  @override
  $AdminSummaryCopyWith<$Res> get adminSummary;
  @override
  $ContentModelCopyWith<$Res>? get content;
  @override
  $SettingCopyWith<$Res> get setting;
  @override
  $FormModelCopyWith<$Res>? get form;
  @override
  $HouseInfoCopyWith<$Res>? get houseDetail;
  @override
  $LobbyRestrictionCopyWith<$Res>? get restriction;
  @override
  $PriceDetailsCopyWith<$Res> get priceDetails;
  @override
  $AccessRequestDataCopyWith<$Res>? get accessRequestData;
  @override
  $RatingCopyWith<$Res> get rating;
}

/// @nodoc
class __$$LobbyImplCopyWithImpl<$Res>
    extends _$LobbyCopyWithImpl<$Res, _$LobbyImpl>
    implements _$$LobbyImplCopyWith<$Res> {
  __$$LobbyImplCopyWithImpl(
    _$LobbyImpl _value,
    $Res Function(_$LobbyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdDate = null,
    Object? userId = null,
    Object? lobbyStatus = null,
    Object? filter = null,
    Object? description = null,
    Object? title = null,
    Object? mediaUrls = null,
    Object? lobbyType = null,
    Object? totalMembers = null,
    Object? currentMembers = null,
    Object? membersRequired = null,
    Object? colorScheme = null,
    Object? gender = null,
    Object? userStatus = null,
    Object? adminSummary = null,
    Object? content = freezed,
    Object? setting = null,
    Object? activity = null,
    Object? form = freezed,
    Object? houseDetail = freezed,
    Object? userSummaries = freezed,
    Object? dateRange = null,
    Object? restriction = freezed,
    Object? priceDetails = null,
    Object? isAdvancedPricing = null,
    Object? allowMultiplePricingOptions = null,
    Object? ticketOptions = null,
    Object? accessRequestData = freezed,
    Object? hasForm = null,
    Object? hasOffer = null,
    Object? isSaved = null,
    Object? isFormMandatory = null,
    Object? isRefundNotPossible = null,
    Object? rating = null,
    Object? priceTierList = freezed,
    Object? ratingGiven = null,
    Object? loginNotRequired = null,
  }) {
    return _then(
      _$LobbyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        createdDate: null == createdDate
            ? _value.createdDate
            : createdDate // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        lobbyStatus: null == lobbyStatus
            ? _value.lobbyStatus
            : lobbyStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        filter: null == filter
            ? _value.filter
            : filter // ignore: cast_nullable_to_non_nullable
                  as Filter,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        mediaUrls: null == mediaUrls
            ? _value._mediaUrls
            : mediaUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        lobbyType: null == lobbyType
            ? _value.lobbyType
            : lobbyType // ignore: cast_nullable_to_non_nullable
                  as String,
        totalMembers: null == totalMembers
            ? _value.totalMembers
            : totalMembers // ignore: cast_nullable_to_non_nullable
                  as int,
        currentMembers: null == currentMembers
            ? _value.currentMembers
            : currentMembers // ignore: cast_nullable_to_non_nullable
                  as int,
        membersRequired: null == membersRequired
            ? _value.membersRequired
            : membersRequired // ignore: cast_nullable_to_non_nullable
                  as int,
        colorScheme: null == colorScheme
            ? _value.colorScheme
            : colorScheme // ignore: cast_nullable_to_non_nullable
                  as CardColorScheme,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        userStatus: null == userStatus
            ? _value.userStatus
            : userStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        adminSummary: null == adminSummary
            ? _value.adminSummary
            : adminSummary // ignore: cast_nullable_to_non_nullable
                  as AdminSummary,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as ContentModel?,
        setting: null == setting
            ? _value.setting
            : setting // ignore: cast_nullable_to_non_nullable
                  as Setting,
        activity: null == activity
            ? _value.activity
            : activity // ignore: cast_nullable_to_non_nullable
                  as String,
        form: freezed == form
            ? _value.form
            : form // ignore: cast_nullable_to_non_nullable
                  as FormModel?,
        houseDetail: freezed == houseDetail
            ? _value.houseDetail
            : houseDetail // ignore: cast_nullable_to_non_nullable
                  as HouseInfo?,
        userSummaries: freezed == userSummaries
            ? _value._userSummaries
            : userSummaries // ignore: cast_nullable_to_non_nullable
                  as List<UserSummary>?,
        dateRange: null == dateRange
            ? _value._dateRange
            : dateRange // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        restriction: freezed == restriction
            ? _value.restriction
            : restriction // ignore: cast_nullable_to_non_nullable
                  as LobbyRestriction?,
        priceDetails: null == priceDetails
            ? _value.priceDetails
            : priceDetails // ignore: cast_nullable_to_non_nullable
                  as PriceDetails,
        isAdvancedPricing: null == isAdvancedPricing
            ? _value.isAdvancedPricing
            : isAdvancedPricing // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowMultiplePricingOptions: null == allowMultiplePricingOptions
            ? _value.allowMultiplePricingOptions
            : allowMultiplePricingOptions // ignore: cast_nullable_to_non_nullable
                  as bool,
        ticketOptions: null == ticketOptions
            ? _value._ticketOptions
            : ticketOptions // ignore: cast_nullable_to_non_nullable
                  as List<LobbyTicketOption>,
        accessRequestData: freezed == accessRequestData
            ? _value.accessRequestData
            : accessRequestData // ignore: cast_nullable_to_non_nullable
                  as AccessRequestData?,
        hasForm: null == hasForm
            ? _value.hasForm
            : hasForm // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasOffer: null == hasOffer
            ? _value.hasOffer
            : hasOffer // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSaved: null == isSaved
            ? _value.isSaved
            : isSaved // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFormMandatory: null == isFormMandatory
            ? _value.isFormMandatory
            : isFormMandatory // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRefundNotPossible: null == isRefundNotPossible
            ? _value.isRefundNotPossible
            : isRefundNotPossible // ignore: cast_nullable_to_non_nullable
                  as bool,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as Rating,
        priceTierList: freezed == priceTierList
            ? _value._priceTierList
            : priceTierList // ignore: cast_nullable_to_non_nullable
                  as List<PriceTier>?,
        ratingGiven: null == ratingGiven
            ? _value.ratingGiven
            : ratingGiven // ignore: cast_nullable_to_non_nullable
                  as bool,
        loginNotRequired: null == loginNotRequired
            ? _value.loginNotRequired
            : loginNotRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LobbyImpl implements _Lobby {
  _$LobbyImpl({
    required this.id,
    required this.createdDate,
    required this.userId,
    this.lobbyStatus = "",
    required this.filter,
    this.description = "",
    this.title = "",
    final List<String> mediaUrls = const <String>[],
    this.lobbyType = "PRIVATE",
    this.totalMembers = 0,
    this.currentMembers = 0,
    this.membersRequired = 0,
    @JsonKey(includeFromJson: false) this.colorScheme = defaultColorScheme,
    this.gender = "MALE",
    this.userStatus = "VISITOR",
    this.adminSummary = const AdminSummary(userId: "", profilePictureUrl: ""),
    this.content,
    this.setting = const Setting(),
    this.activity = "",
    this.form,
    this.houseDetail,
    final List<UserSummary>? userSummaries,
    final Map<String, dynamic> dateRange = const {},
    this.restriction,
    this.priceDetails = const PriceDetails(),
    this.isAdvancedPricing = false,
    this.allowMultiplePricingOptions = false,
    final List<LobbyTicketOption> ticketOptions = const <LobbyTicketOption>[],
    this.accessRequestData,
    this.hasForm = false,
    this.hasOffer = false,
    this.isSaved = false,
    this.isFormMandatory = false,
    this.isRefundNotPossible = false,
    this.rating = const Rating(),
    final List<PriceTier>? priceTierList = const [],
    this.ratingGiven = false,
    this.loginNotRequired = false,
  }) : _mediaUrls = mediaUrls,
       _userSummaries = userSummaries,
       _dateRange = dateRange,
       _ticketOptions = ticketOptions,
       _priceTierList = priceTierList;

  factory _$LobbyImpl.fromJson(Map<String, dynamic> json) =>
      _$$LobbyImplFromJson(json);

  @override
  final String id;
  @override
  final int createdDate;
  // required int lastModifiedDate,
  @override
  final String userId;
  @override
  @JsonKey()
  final String lobbyStatus;
  @override
  final Filter filter;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String title;
  final List<String> _mediaUrls;
  @override
  @JsonKey()
  List<String> get mediaUrls {
    if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mediaUrls);
  }

  @override
  @JsonKey()
  final String lobbyType;
  @override
  @JsonKey()
  final int totalMembers;
  @override
  @JsonKey()
  final int currentMembers;
  @override
  @JsonKey()
  final int membersRequired;
  @override
  @JsonKey(includeFromJson: false)
  final CardColorScheme colorScheme;
  @override
  @JsonKey()
  final String gender;
  @override
  @JsonKey()
  final String userStatus;
  @override
  @JsonKey()
  final AdminSummary adminSummary;
  @override
  final ContentModel? content;
  @override
  @JsonKey()
  final Setting setting;
  // Setting? settings,
  @override
  @JsonKey()
  final String activity;
  // Map<String,dynamic>? lobbyRules,
  @override
  final FormModel? form;
  @override
  final HouseInfo? houseDetail;
  final List<UserSummary>? _userSummaries;
  @override
  List<UserSummary>? get userSummaries {
    final value = _userSummaries;
    if (value == null) return null;
    if (_userSummaries is EqualUnmodifiableListView) return _userSummaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic> _dateRange;
  @override
  @JsonKey()
  Map<String, dynamic> get dateRange {
    if (_dateRange is EqualUnmodifiableMapView) return _dateRange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dateRange);
  }

  // @Default(0.0) double price,
  @override
  final LobbyRestriction? restriction;
  @override
  @JsonKey()
  final PriceDetails priceDetails;
  @override
  @JsonKey()
  final bool isAdvancedPricing;
  @override
  @JsonKey()
  final bool allowMultiplePricingOptions;
  final List<LobbyTicketOption> _ticketOptions;
  @override
  @JsonKey()
  List<LobbyTicketOption> get ticketOptions {
    if (_ticketOptions is EqualUnmodifiableListView) return _ticketOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ticketOptions);
  }

  @override
  final AccessRequestData? accessRequestData;
  @override
  @JsonKey()
  final bool hasForm;
  @override
  @JsonKey()
  final bool hasOffer;
  @override
  @JsonKey()
  final bool isSaved;
  @override
  @JsonKey()
  final bool isFormMandatory;
  @override
  @JsonKey()
  final bool isRefundNotPossible;
  @override
  @JsonKey()
  final Rating rating;
  final List<PriceTier>? _priceTierList;
  @override
  @JsonKey()
  List<PriceTier>? get priceTierList {
    final value = _priceTierList;
    if (value == null) return null;
    if (_priceTierList is EqualUnmodifiableListView) return _priceTierList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool ratingGiven;
  @override
  @JsonKey()
  final bool loginNotRequired;

  @override
  String toString() {
    return 'Lobby(id: $id, createdDate: $createdDate, userId: $userId, lobbyStatus: $lobbyStatus, filter: $filter, description: $description, title: $title, mediaUrls: $mediaUrls, lobbyType: $lobbyType, totalMembers: $totalMembers, currentMembers: $currentMembers, membersRequired: $membersRequired, colorScheme: $colorScheme, gender: $gender, userStatus: $userStatus, adminSummary: $adminSummary, content: $content, setting: $setting, activity: $activity, form: $form, houseDetail: $houseDetail, userSummaries: $userSummaries, dateRange: $dateRange, restriction: $restriction, priceDetails: $priceDetails, isAdvancedPricing: $isAdvancedPricing, allowMultiplePricingOptions: $allowMultiplePricingOptions, ticketOptions: $ticketOptions, accessRequestData: $accessRequestData, hasForm: $hasForm, hasOffer: $hasOffer, isSaved: $isSaved, isFormMandatory: $isFormMandatory, isRefundNotPossible: $isRefundNotPossible, rating: $rating, priceTierList: $priceTierList, ratingGiven: $ratingGiven, loginNotRequired: $loginNotRequired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LobbyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.lobbyStatus, lobbyStatus) ||
                other.lobbyStatus == lobbyStatus) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(
              other._mediaUrls,
              _mediaUrls,
            ) &&
            (identical(other.lobbyType, lobbyType) ||
                other.lobbyType == lobbyType) &&
            (identical(other.totalMembers, totalMembers) ||
                other.totalMembers == totalMembers) &&
            (identical(other.currentMembers, currentMembers) ||
                other.currentMembers == currentMembers) &&
            (identical(other.membersRequired, membersRequired) ||
                other.membersRequired == membersRequired) &&
            (identical(other.colorScheme, colorScheme) ||
                other.colorScheme == colorScheme) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.userStatus, userStatus) ||
                other.userStatus == userStatus) &&
            (identical(other.adminSummary, adminSummary) ||
                other.adminSummary == adminSummary) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.setting, setting) || other.setting == setting) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.form, form) || other.form == form) &&
            (identical(other.houseDetail, houseDetail) ||
                other.houseDetail == houseDetail) &&
            const DeepCollectionEquality().equals(
              other._userSummaries,
              _userSummaries,
            ) &&
            const DeepCollectionEquality().equals(
              other._dateRange,
              _dateRange,
            ) &&
            (identical(other.restriction, restriction) ||
                other.restriction == restriction) &&
            (identical(other.priceDetails, priceDetails) ||
                other.priceDetails == priceDetails) &&
            (identical(other.isAdvancedPricing, isAdvancedPricing) ||
                other.isAdvancedPricing == isAdvancedPricing) &&
            (identical(
                  other.allowMultiplePricingOptions,
                  allowMultiplePricingOptions,
                ) ||
                other.allowMultiplePricingOptions ==
                    allowMultiplePricingOptions) &&
            const DeepCollectionEquality().equals(
              other._ticketOptions,
              _ticketOptions,
            ) &&
            (identical(other.accessRequestData, accessRequestData) ||
                other.accessRequestData == accessRequestData) &&
            (identical(other.hasForm, hasForm) || other.hasForm == hasForm) &&
            (identical(other.hasOffer, hasOffer) ||
                other.hasOffer == hasOffer) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.isFormMandatory, isFormMandatory) ||
                other.isFormMandatory == isFormMandatory) &&
            (identical(other.isRefundNotPossible, isRefundNotPossible) ||
                other.isRefundNotPossible == isRefundNotPossible) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality().equals(
              other._priceTierList,
              _priceTierList,
            ) &&
            (identical(other.ratingGiven, ratingGiven) ||
                other.ratingGiven == ratingGiven) &&
            (identical(other.loginNotRequired, loginNotRequired) ||
                other.loginNotRequired == loginNotRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    createdDate,
    userId,
    lobbyStatus,
    filter,
    description,
    title,
    const DeepCollectionEquality().hash(_mediaUrls),
    lobbyType,
    totalMembers,
    currentMembers,
    membersRequired,
    colorScheme,
    gender,
    userStatus,
    adminSummary,
    content,
    setting,
    activity,
    form,
    houseDetail,
    const DeepCollectionEquality().hash(_userSummaries),
    const DeepCollectionEquality().hash(_dateRange),
    restriction,
    priceDetails,
    isAdvancedPricing,
    allowMultiplePricingOptions,
    const DeepCollectionEquality().hash(_ticketOptions),
    accessRequestData,
    hasForm,
    hasOffer,
    isSaved,
    isFormMandatory,
    isRefundNotPossible,
    rating,
    const DeepCollectionEquality().hash(_priceTierList),
    ratingGiven,
    loginNotRequired,
  ]);

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LobbyImplCopyWith<_$LobbyImpl> get copyWith =>
      __$$LobbyImplCopyWithImpl<_$LobbyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LobbyImplToJson(this);
  }
}

abstract class _Lobby implements Lobby {
  factory _Lobby({
    required final String id,
    required final int createdDate,
    required final String userId,
    final String lobbyStatus,
    required final Filter filter,
    final String description,
    final String title,
    final List<String> mediaUrls,
    final String lobbyType,
    final int totalMembers,
    final int currentMembers,
    final int membersRequired,
    @JsonKey(includeFromJson: false) final CardColorScheme colorScheme,
    final String gender,
    final String userStatus,
    final AdminSummary adminSummary,
    final ContentModel? content,
    final Setting setting,
    final String activity,
    final FormModel? form,
    final HouseInfo? houseDetail,
    final List<UserSummary>? userSummaries,
    final Map<String, dynamic> dateRange,
    final LobbyRestriction? restriction,
    final PriceDetails priceDetails,
    final bool isAdvancedPricing,
    final bool allowMultiplePricingOptions,
    final List<LobbyTicketOption> ticketOptions,
    final AccessRequestData? accessRequestData,
    final bool hasForm,
    final bool hasOffer,
    final bool isSaved,
    final bool isFormMandatory,
    final bool isRefundNotPossible,
    final Rating rating,
    final List<PriceTier>? priceTierList,
    final bool ratingGiven,
    final bool loginNotRequired,
  }) = _$LobbyImpl;

  factory _Lobby.fromJson(Map<String, dynamic> json) = _$LobbyImpl.fromJson;

  @override
  String get id;
  @override
  int get createdDate; // required int lastModifiedDate,
  @override
  String get userId;
  @override
  String get lobbyStatus;
  @override
  Filter get filter;
  @override
  String get description;
  @override
  String get title;
  @override
  List<String> get mediaUrls;
  @override
  String get lobbyType;
  @override
  int get totalMembers;
  @override
  int get currentMembers;
  @override
  int get membersRequired;
  @override
  @JsonKey(includeFromJson: false)
  CardColorScheme get colorScheme;
  @override
  String get gender;
  @override
  String get userStatus;
  @override
  AdminSummary get adminSummary;
  @override
  ContentModel? get content;
  @override
  Setting get setting; // Setting? settings,
  @override
  String get activity; // Map<String,dynamic>? lobbyRules,
  @override
  FormModel? get form;
  @override
  HouseInfo? get houseDetail;
  @override
  List<UserSummary>? get userSummaries;
  @override
  Map<String, dynamic> get dateRange; // @Default(0.0) double price,
  @override
  LobbyRestriction? get restriction;
  @override
  PriceDetails get priceDetails;
  @override
  bool get isAdvancedPricing;
  @override
  bool get allowMultiplePricingOptions;
  @override
  List<LobbyTicketOption> get ticketOptions;
  @override
  AccessRequestData? get accessRequestData;
  @override
  bool get hasForm;
  @override
  bool get hasOffer;
  @override
  bool get isSaved;
  @override
  bool get isFormMandatory;
  @override
  bool get isRefundNotPossible;
  @override
  Rating get rating;
  @override
  List<PriceTier>? get priceTierList;
  @override
  bool get ratingGiven;
  @override
  bool get loginNotRequired;

  /// Create a copy of Lobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LobbyImplCopyWith<_$LobbyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return _Rating.fromJson(json);
}

/// @nodoc
mixin _$Rating {
  double get average => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this Rating to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingCopyWith<Rating> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingCopyWith<$Res> {
  factory $RatingCopyWith(Rating value, $Res Function(Rating) then) =
      _$RatingCopyWithImpl<$Res, Rating>;
  @useResult
  $Res call({double average, int count});
}

/// @nodoc
class _$RatingCopyWithImpl<$Res, $Val extends Rating>
    implements $RatingCopyWith<$Res> {
  _$RatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? average = null, Object? count = null}) {
    return _then(
      _value.copyWith(
            average: null == average
                ? _value.average
                : average // ignore: cast_nullable_to_non_nullable
                      as double,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RatingImplCopyWith<$Res> implements $RatingCopyWith<$Res> {
  factory _$$RatingImplCopyWith(
    _$RatingImpl value,
    $Res Function(_$RatingImpl) then,
  ) = __$$RatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double average, int count});
}

/// @nodoc
class __$$RatingImplCopyWithImpl<$Res>
    extends _$RatingCopyWithImpl<$Res, _$RatingImpl>
    implements _$$RatingImplCopyWith<$Res> {
  __$$RatingImplCopyWithImpl(
    _$RatingImpl _value,
    $Res Function(_$RatingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? average = null, Object? count = null}) {
    return _then(
      _$RatingImpl(
        average: null == average
            ? _value.average
            : average // ignore: cast_nullable_to_non_nullable
                  as double,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$RatingImpl implements _Rating {
  const _$RatingImpl({this.average = 0.0, this.count = 0});

  factory _$RatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingImplFromJson(json);

  @override
  @JsonKey()
  final double average;
  @override
  @JsonKey()
  final int count;

  @override
  String toString() {
    return 'Rating(average: $average, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingImpl &&
            (identical(other.average, average) || other.average == average) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, average, count);

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingImplCopyWith<_$RatingImpl> get copyWith =>
      __$$RatingImplCopyWithImpl<_$RatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingImplToJson(this);
  }
}

abstract class _Rating implements Rating {
  const factory _Rating({final double average, final int count}) = _$RatingImpl;

  factory _Rating.fromJson(Map<String, dynamic> json) = _$RatingImpl.fromJson;

  @override
  double get average;
  @override
  int get count;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingImplCopyWith<_$RatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FormModel _$FormModelFromJson(Map<String, dynamic> json) {
  return _FormModel.fromJson(json);
}

/// @nodoc
mixin _$FormModel {
  String get title => throw _privateConstructorUsedError;
  List<Question> get questions => throw _privateConstructorUsedError;

  /// Serializes this FormModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FormModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormModelCopyWith<FormModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormModelCopyWith<$Res> {
  factory $FormModelCopyWith(FormModel value, $Res Function(FormModel) then) =
      _$FormModelCopyWithImpl<$Res, FormModel>;
  @useResult
  $Res call({String title, List<Question> questions});
}

/// @nodoc
class _$FormModelCopyWithImpl<$Res, $Val extends FormModel>
    implements $FormModelCopyWith<$Res> {
  _$FormModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? questions = null}) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<Question>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FormModelImplCopyWith<$Res>
    implements $FormModelCopyWith<$Res> {
  factory _$$FormModelImplCopyWith(
    _$FormModelImpl value,
    $Res Function(_$FormModelImpl) then,
  ) = __$$FormModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<Question> questions});
}

/// @nodoc
class __$$FormModelImplCopyWithImpl<$Res>
    extends _$FormModelCopyWithImpl<$Res, _$FormModelImpl>
    implements _$$FormModelImplCopyWith<$Res> {
  __$$FormModelImplCopyWithImpl(
    _$FormModelImpl _value,
    $Res Function(_$FormModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FormModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? questions = null}) {
    return _then(
      _$FormModelImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<Question>,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$FormModelImpl implements _FormModel {
  const _$FormModelImpl({
    this.title = '',
    final List<Question> questions = const <Question>[],
  }) : _questions = questions;

  factory _$FormModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FormModelImplFromJson(json);

  @override
  @JsonKey()
  final String title;
  final List<Question> _questions;
  @override
  @JsonKey()
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString() {
    return 'FormModel(title: $title, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    const DeepCollectionEquality().hash(_questions),
  );

  /// Create a copy of FormModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormModelImplCopyWith<_$FormModelImpl> get copyWith =>
      __$$FormModelImplCopyWithImpl<_$FormModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FormModelImplToJson(this);
  }
}

abstract class _FormModel implements FormModel {
  const factory _FormModel({
    final String title,
    final List<Question> questions,
  }) = _$FormModelImpl;

  factory _FormModel.fromJson(Map<String, dynamic> json) =
      _$FormModelImpl.fromJson;

  @override
  String get title;
  @override
  List<Question> get questions;

  /// Create a copy of FormModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormModelImplCopyWith<_$FormModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Setting _$SettingFromJson(Map<String, dynamic> json) {
  return _Setting.fromJson(json);
}

/// @nodoc
mixin _$Setting {
  bool get showLobbyMembers => throw _privateConstructorUsedError;
  bool get enableChat => throw _privateConstructorUsedError;
  bool get showMembers => throw _privateConstructorUsedError;

  /// Serializes this Setting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingCopyWith<Setting> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingCopyWith<$Res> {
  factory $SettingCopyWith(Setting value, $Res Function(Setting) then) =
      _$SettingCopyWithImpl<$Res, Setting>;
  @useResult
  $Res call({bool showLobbyMembers, bool enableChat, bool showMembers});
}

/// @nodoc
class _$SettingCopyWithImpl<$Res, $Val extends Setting>
    implements $SettingCopyWith<$Res> {
  _$SettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showLobbyMembers = null,
    Object? enableChat = null,
    Object? showMembers = null,
  }) {
    return _then(
      _value.copyWith(
            showLobbyMembers: null == showLobbyMembers
                ? _value.showLobbyMembers
                : showLobbyMembers // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableChat: null == enableChat
                ? _value.enableChat
                : enableChat // ignore: cast_nullable_to_non_nullable
                      as bool,
            showMembers: null == showMembers
                ? _value.showMembers
                : showMembers // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SettingImplCopyWith<$Res> implements $SettingCopyWith<$Res> {
  factory _$$SettingImplCopyWith(
    _$SettingImpl value,
    $Res Function(_$SettingImpl) then,
  ) = __$$SettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool showLobbyMembers, bool enableChat, bool showMembers});
}

/// @nodoc
class __$$SettingImplCopyWithImpl<$Res>
    extends _$SettingCopyWithImpl<$Res, _$SettingImpl>
    implements _$$SettingImplCopyWith<$Res> {
  __$$SettingImplCopyWithImpl(
    _$SettingImpl _value,
    $Res Function(_$SettingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showLobbyMembers = null,
    Object? enableChat = null,
    Object? showMembers = null,
  }) {
    return _then(
      _$SettingImpl(
        showLobbyMembers: null == showLobbyMembers
            ? _value.showLobbyMembers
            : showLobbyMembers // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableChat: null == enableChat
            ? _value.enableChat
            : enableChat // ignore: cast_nullable_to_non_nullable
                  as bool,
        showMembers: null == showMembers
            ? _value.showMembers
            : showMembers // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SettingImpl implements _Setting {
  const _$SettingImpl({
    this.showLobbyMembers = true,
    this.enableChat = true,
    this.showMembers = true,
  });

  factory _$SettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingImplFromJson(json);

  @override
  @JsonKey()
  final bool showLobbyMembers;
  @override
  @JsonKey()
  final bool enableChat;
  @override
  @JsonKey()
  final bool showMembers;

  @override
  String toString() {
    return 'Setting(showLobbyMembers: $showLobbyMembers, enableChat: $enableChat, showMembers: $showMembers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingImpl &&
            (identical(other.showLobbyMembers, showLobbyMembers) ||
                other.showLobbyMembers == showLobbyMembers) &&
            (identical(other.enableChat, enableChat) ||
                other.enableChat == enableChat) &&
            (identical(other.showMembers, showMembers) ||
                other.showMembers == showMembers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, showLobbyMembers, enableChat, showMembers);

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingImplCopyWith<_$SettingImpl> get copyWith =>
      __$$SettingImplCopyWithImpl<_$SettingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingImplToJson(this);
  }
}

abstract class _Setting implements Setting {
  const factory _Setting({
    final bool showLobbyMembers,
    final bool enableChat,
    final bool showMembers,
  }) = _$SettingImpl;

  factory _Setting.fromJson(Map<String, dynamic> json) = _$SettingImpl.fromJson;

  @override
  bool get showLobbyMembers;
  @override
  bool get enableChat;
  @override
  bool get showMembers;

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingImplCopyWith<_$SettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

/// @nodoc
mixin _$Question {
  String get id => throw _privateConstructorUsedError;
  String get questionText => throw _privateConstructorUsedError;
  String get questionType => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  bool get isMandatory => throw _privateConstructorUsedError;
  String get questionLabel => throw _privateConstructorUsedError;
  String get dataKey => throw _privateConstructorUsedError;

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call({
    String id,
    String questionText,
    String questionType,
    List<String> options,
    String answer,
    bool isMandatory,
    String questionLabel,
    String dataKey,
  });
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? questionText = null,
    Object? questionType = null,
    Object? options = null,
    Object? answer = null,
    Object? isMandatory = null,
    Object? questionLabel = null,
    Object? dataKey = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            questionText: null == questionText
                ? _value.questionText
                : questionText // ignore: cast_nullable_to_non_nullable
                      as String,
            questionType: null == questionType
                ? _value.questionType
                : questionType // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            answer: null == answer
                ? _value.answer
                : answer // ignore: cast_nullable_to_non_nullable
                      as String,
            isMandatory: null == isMandatory
                ? _value.isMandatory
                : isMandatory // ignore: cast_nullable_to_non_nullable
                      as bool,
            questionLabel: null == questionLabel
                ? _value.questionLabel
                : questionLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            dataKey: null == dataKey
                ? _value.dataKey
                : dataKey // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionImplCopyWith<$Res>
    implements $QuestionCopyWith<$Res> {
  factory _$$QuestionImplCopyWith(
    _$QuestionImpl value,
    $Res Function(_$QuestionImpl) then,
  ) = __$$QuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String questionText,
    String questionType,
    List<String> options,
    String answer,
    bool isMandatory,
    String questionLabel,
    String dataKey,
  });
}

/// @nodoc
class __$$QuestionImplCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$QuestionImpl>
    implements _$$QuestionImplCopyWith<$Res> {
  __$$QuestionImplCopyWithImpl(
    _$QuestionImpl _value,
    $Res Function(_$QuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? questionText = null,
    Object? questionType = null,
    Object? options = null,
    Object? answer = null,
    Object? isMandatory = null,
    Object? questionLabel = null,
    Object? dataKey = null,
  }) {
    return _then(
      _$QuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        questionText: null == questionText
            ? _value.questionText
            : questionText // ignore: cast_nullable_to_non_nullable
                  as String,
        questionType: null == questionType
            ? _value.questionType
            : questionType // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        answer: null == answer
            ? _value.answer
            : answer // ignore: cast_nullable_to_non_nullable
                  as String,
        isMandatory: null == isMandatory
            ? _value.isMandatory
            : isMandatory // ignore: cast_nullable_to_non_nullable
                  as bool,
        questionLabel: null == questionLabel
            ? _value.questionLabel
            : questionLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        dataKey: null == dataKey
            ? _value.dataKey
            : dataKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$QuestionImpl implements _Question {
  const _$QuestionImpl({
    this.id = '',
    this.questionText = '',
    this.questionType = '',
    final List<String> options = const <String>[],
    this.answer = '',
    this.isMandatory = false,
    this.questionLabel = '',
    this.dataKey = '',
  }) : _options = options;

  factory _$QuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String questionText;
  @override
  @JsonKey()
  final String questionType;
  final List<String> _options;
  @override
  @JsonKey()
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey()
  final String answer;
  @override
  @JsonKey()
  final bool isMandatory;
  @override
  @JsonKey()
  final String questionLabel;
  @override
  @JsonKey()
  final String dataKey;

  @override
  String toString() {
    return 'Question(id: $id, questionText: $questionText, questionType: $questionType, options: $options, answer: $answer, isMandatory: $isMandatory, questionLabel: $questionLabel, dataKey: $dataKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.questionText, questionText) ||
                other.questionText == questionText) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.isMandatory, isMandatory) ||
                other.isMandatory == isMandatory) &&
            (identical(other.questionLabel, questionLabel) ||
                other.questionLabel == questionLabel) &&
            (identical(other.dataKey, dataKey) || other.dataKey == dataKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    questionText,
    questionType,
    const DeepCollectionEquality().hash(_options),
    answer,
    isMandatory,
    questionLabel,
    dataKey,
  );

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      __$$QuestionImplCopyWithImpl<_$QuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionImplToJson(this);
  }
}

abstract class _Question implements Question {
  const factory _Question({
    final String id,
    final String questionText,
    final String questionType,
    final List<String> options,
    final String answer,
    final bool isMandatory,
    final String questionLabel,
    final String dataKey,
  }) = _$QuestionImpl;

  factory _Question.fromJson(Map<String, dynamic> json) =
      _$QuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get questionText;
  @override
  String get questionType;
  @override
  List<String> get options;
  @override
  String get answer;
  @override
  bool get isMandatory;
  @override
  String get questionLabel;
  @override
  String get dataKey;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) {
  return _UserSummary.fromJson(json);
}

/// @nodoc
mixin _$UserSummary {
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get profilePictureUrl => throw _privateConstructorUsedError;
  Location? get location => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  String get dob => throw _privateConstructorUsedError;

  /// Serializes this UserSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSummaryCopyWith<UserSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSummaryCopyWith<$Res> {
  factory $UserSummaryCopyWith(
    UserSummary value,
    $Res Function(UserSummary) then,
  ) = _$UserSummaryCopyWithImpl<$Res, UserSummary>;
  @useResult
  $Res call({
    String userId,
    String userName,
    String name,
    String email,
    String gender,
    String profilePictureUrl,
    Location? location,
    bool active,
    String dob,
  });

  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class _$UserSummaryCopyWithImpl<$Res, $Val extends UserSummary>
    implements $UserSummaryCopyWith<$Res> {
  _$UserSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? name = null,
    Object? email = null,
    Object? gender = null,
    Object? profilePictureUrl = null,
    Object? location = freezed,
    Object? active = null,
    Object? dob = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            profilePictureUrl: null == profilePictureUrl
                ? _value.profilePictureUrl
                : profilePictureUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as Location?,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            dob: null == dob
                ? _value.dob
                : dob // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserSummaryImplCopyWith<$Res>
    implements $UserSummaryCopyWith<$Res> {
  factory _$$UserSummaryImplCopyWith(
    _$UserSummaryImpl value,
    $Res Function(_$UserSummaryImpl) then,
  ) = __$$UserSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String userName,
    String name,
    String email,
    String gender,
    String profilePictureUrl,
    Location? location,
    bool active,
    String dob,
  });

  @override
  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class __$$UserSummaryImplCopyWithImpl<$Res>
    extends _$UserSummaryCopyWithImpl<$Res, _$UserSummaryImpl>
    implements _$$UserSummaryImplCopyWith<$Res> {
  __$$UserSummaryImplCopyWithImpl(
    _$UserSummaryImpl _value,
    $Res Function(_$UserSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? name = null,
    Object? email = null,
    Object? gender = null,
    Object? profilePictureUrl = null,
    Object? location = freezed,
    Object? active = null,
    Object? dob = null,
  }) {
    return _then(
      _$UserSummaryImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        profilePictureUrl: null == profilePictureUrl
            ? _value.profilePictureUrl
            : profilePictureUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as Location?,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        dob: null == dob
            ? _value.dob
            : dob // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$UserSummaryImpl implements _UserSummary {
  const _$UserSummaryImpl({
    this.userId = "",
    this.userName = "",
    this.name = "",
    this.email = "",
    this.gender = "",
    this.profilePictureUrl = "",
    this.location,
    this.active = false,
    this.dob = "",
  });

  factory _$UserSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSummaryImplFromJson(json);

  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String gender;
  @override
  @JsonKey()
  final String profilePictureUrl;
  @override
  final Location? location;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final String dob;

  @override
  String toString() {
    return 'UserSummary(userId: $userId, userName: $userName, name: $name, email: $email, gender: $gender, profilePictureUrl: $profilePictureUrl, location: $location, active: $active, dob: $dob)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSummaryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.profilePictureUrl, profilePictureUrl) ||
                other.profilePictureUrl == profilePictureUrl) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.dob, dob) || other.dob == dob));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    userName,
    name,
    email,
    gender,
    profilePictureUrl,
    location,
    active,
    dob,
  );

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSummaryImplCopyWith<_$UserSummaryImpl> get copyWith =>
      __$$UserSummaryImplCopyWithImpl<_$UserSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSummaryImplToJson(this);
  }
}

abstract class _UserSummary implements UserSummary {
  const factory _UserSummary({
    final String userId,
    final String userName,
    final String name,
    final String email,
    final String gender,
    final String profilePictureUrl,
    final Location? location,
    final bool active,
    final String dob,
  }) = _$UserSummaryImpl;

  factory _UserSummary.fromJson(Map<String, dynamic> json) =
      _$UserSummaryImpl.fromJson;

  @override
  String get userId;
  @override
  String get userName;
  @override
  String get name;
  @override
  String get email;
  @override
  String get gender;
  @override
  String get profilePictureUrl;
  @override
  Location? get location;
  @override
  bool get active;
  @override
  String get dob;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSummaryImplCopyWith<_$UserSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LobbyRestriction _$LobbyRestrictionFromJson(Map<String, dynamic> json) {
  return _LobbyRestriction.fromJson(json);
}

/// @nodoc
mixin _$LobbyRestriction {
  String get genderRestriction => throw _privateConstructorUsedError;
  AgeRange get ageRange => throw _privateConstructorUsedError;
  int? get maxMales => throw _privateConstructorUsedError;
  int? get maxFemales => throw _privateConstructorUsedError;
  int? get maxOthers => throw _privateConstructorUsedError;

  /// Serializes this LobbyRestriction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LobbyRestriction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LobbyRestrictionCopyWith<LobbyRestriction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LobbyRestrictionCopyWith<$Res> {
  factory $LobbyRestrictionCopyWith(
    LobbyRestriction value,
    $Res Function(LobbyRestriction) then,
  ) = _$LobbyRestrictionCopyWithImpl<$Res, LobbyRestriction>;
  @useResult
  $Res call({
    String genderRestriction,
    AgeRange ageRange,
    int? maxMales,
    int? maxFemales,
    int? maxOthers,
  });

  $AgeRangeCopyWith<$Res> get ageRange;
}

/// @nodoc
class _$LobbyRestrictionCopyWithImpl<$Res, $Val extends LobbyRestriction>
    implements $LobbyRestrictionCopyWith<$Res> {
  _$LobbyRestrictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LobbyRestriction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genderRestriction = null,
    Object? ageRange = null,
    Object? maxMales = freezed,
    Object? maxFemales = freezed,
    Object? maxOthers = freezed,
  }) {
    return _then(
      _value.copyWith(
            genderRestriction: null == genderRestriction
                ? _value.genderRestriction
                : genderRestriction // ignore: cast_nullable_to_non_nullable
                      as String,
            ageRange: null == ageRange
                ? _value.ageRange
                : ageRange // ignore: cast_nullable_to_non_nullable
                      as AgeRange,
            maxMales: freezed == maxMales
                ? _value.maxMales
                : maxMales // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxFemales: freezed == maxFemales
                ? _value.maxFemales
                : maxFemales // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxOthers: freezed == maxOthers
                ? _value.maxOthers
                : maxOthers // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of LobbyRestriction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AgeRangeCopyWith<$Res> get ageRange {
    return $AgeRangeCopyWith<$Res>(_value.ageRange, (value) {
      return _then(_value.copyWith(ageRange: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LobbyRestrictionImplCopyWith<$Res>
    implements $LobbyRestrictionCopyWith<$Res> {
  factory _$$LobbyRestrictionImplCopyWith(
    _$LobbyRestrictionImpl value,
    $Res Function(_$LobbyRestrictionImpl) then,
  ) = __$$LobbyRestrictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String genderRestriction,
    AgeRange ageRange,
    int? maxMales,
    int? maxFemales,
    int? maxOthers,
  });

  @override
  $AgeRangeCopyWith<$Res> get ageRange;
}

/// @nodoc
class __$$LobbyRestrictionImplCopyWithImpl<$Res>
    extends _$LobbyRestrictionCopyWithImpl<$Res, _$LobbyRestrictionImpl>
    implements _$$LobbyRestrictionImplCopyWith<$Res> {
  __$$LobbyRestrictionImplCopyWithImpl(
    _$LobbyRestrictionImpl _value,
    $Res Function(_$LobbyRestrictionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LobbyRestriction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? genderRestriction = null,
    Object? ageRange = null,
    Object? maxMales = freezed,
    Object? maxFemales = freezed,
    Object? maxOthers = freezed,
  }) {
    return _then(
      _$LobbyRestrictionImpl(
        genderRestriction: null == genderRestriction
            ? _value.genderRestriction
            : genderRestriction // ignore: cast_nullable_to_non_nullable
                  as String,
        ageRange: null == ageRange
            ? _value.ageRange
            : ageRange // ignore: cast_nullable_to_non_nullable
                  as AgeRange,
        maxMales: freezed == maxMales
            ? _value.maxMales
            : maxMales // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxFemales: freezed == maxFemales
            ? _value.maxFemales
            : maxFemales // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxOthers: freezed == maxOthers
            ? _value.maxOthers
            : maxOthers // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LobbyRestrictionImpl implements _LobbyRestriction {
  const _$LobbyRestrictionImpl({
    this.genderRestriction = "",
    this.ageRange = const AgeRange(),
    this.maxMales,
    this.maxFemales,
    this.maxOthers,
  });

  factory _$LobbyRestrictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$LobbyRestrictionImplFromJson(json);

  @override
  @JsonKey()
  final String genderRestriction;
  @override
  @JsonKey()
  final AgeRange ageRange;
  @override
  final int? maxMales;
  @override
  final int? maxFemales;
  @override
  final int? maxOthers;

  @override
  String toString() {
    return 'LobbyRestriction(genderRestriction: $genderRestriction, ageRange: $ageRange, maxMales: $maxMales, maxFemales: $maxFemales, maxOthers: $maxOthers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LobbyRestrictionImpl &&
            (identical(other.genderRestriction, genderRestriction) ||
                other.genderRestriction == genderRestriction) &&
            (identical(other.ageRange, ageRange) ||
                other.ageRange == ageRange) &&
            (identical(other.maxMales, maxMales) ||
                other.maxMales == maxMales) &&
            (identical(other.maxFemales, maxFemales) ||
                other.maxFemales == maxFemales) &&
            (identical(other.maxOthers, maxOthers) ||
                other.maxOthers == maxOthers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    genderRestriction,
    ageRange,
    maxMales,
    maxFemales,
    maxOthers,
  );

  /// Create a copy of LobbyRestriction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LobbyRestrictionImplCopyWith<_$LobbyRestrictionImpl> get copyWith =>
      __$$LobbyRestrictionImplCopyWithImpl<_$LobbyRestrictionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LobbyRestrictionImplToJson(this);
  }
}

abstract class _LobbyRestriction implements LobbyRestriction {
  const factory _LobbyRestriction({
    final String genderRestriction,
    final AgeRange ageRange,
    final int? maxMales,
    final int? maxFemales,
    final int? maxOthers,
  }) = _$LobbyRestrictionImpl;

  factory _LobbyRestriction.fromJson(Map<String, dynamic> json) =
      _$LobbyRestrictionImpl.fromJson;

  @override
  String get genderRestriction;
  @override
  AgeRange get ageRange;
  @override
  int? get maxMales;
  @override
  int? get maxFemales;
  @override
  int? get maxOthers;

  /// Create a copy of LobbyRestriction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LobbyRestrictionImplCopyWith<_$LobbyRestrictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AgeRange _$AgeRangeFromJson(Map<String, dynamic> json) {
  return _AgeRange.fromJson(json);
}

/// @nodoc
mixin _$AgeRange {
  int get minAge => throw _privateConstructorUsedError;
  int get maxAge => throw _privateConstructorUsedError;

  /// Serializes this AgeRange to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AgeRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgeRangeCopyWith<AgeRange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgeRangeCopyWith<$Res> {
  factory $AgeRangeCopyWith(AgeRange value, $Res Function(AgeRange) then) =
      _$AgeRangeCopyWithImpl<$Res, AgeRange>;
  @useResult
  $Res call({int minAge, int maxAge});
}

/// @nodoc
class _$AgeRangeCopyWithImpl<$Res, $Val extends AgeRange>
    implements $AgeRangeCopyWith<$Res> {
  _$AgeRangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgeRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? minAge = null, Object? maxAge = null}) {
    return _then(
      _value.copyWith(
            minAge: null == minAge
                ? _value.minAge
                : minAge // ignore: cast_nullable_to_non_nullable
                      as int,
            maxAge: null == maxAge
                ? _value.maxAge
                : maxAge // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AgeRangeImplCopyWith<$Res>
    implements $AgeRangeCopyWith<$Res> {
  factory _$$AgeRangeImplCopyWith(
    _$AgeRangeImpl value,
    $Res Function(_$AgeRangeImpl) then,
  ) = __$$AgeRangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int minAge, int maxAge});
}

/// @nodoc
class __$$AgeRangeImplCopyWithImpl<$Res>
    extends _$AgeRangeCopyWithImpl<$Res, _$AgeRangeImpl>
    implements _$$AgeRangeImplCopyWith<$Res> {
  __$$AgeRangeImplCopyWithImpl(
    _$AgeRangeImpl _value,
    $Res Function(_$AgeRangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AgeRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? minAge = null, Object? maxAge = null}) {
    return _then(
      _$AgeRangeImpl(
        minAge: null == minAge
            ? _value.minAge
            : minAge // ignore: cast_nullable_to_non_nullable
                  as int,
        maxAge: null == maxAge
            ? _value.maxAge
            : maxAge // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AgeRangeImpl implements _AgeRange {
  const _$AgeRangeImpl({this.minAge = 0, this.maxAge = 100});

  factory _$AgeRangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgeRangeImplFromJson(json);

  @override
  @JsonKey()
  final int minAge;
  @override
  @JsonKey()
  final int maxAge;

  @override
  String toString() {
    return 'AgeRange(minAge: $minAge, maxAge: $maxAge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgeRangeImpl &&
            (identical(other.minAge, minAge) || other.minAge == minAge) &&
            (identical(other.maxAge, maxAge) || other.maxAge == maxAge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minAge, maxAge);

  /// Create a copy of AgeRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgeRangeImplCopyWith<_$AgeRangeImpl> get copyWith =>
      __$$AgeRangeImplCopyWithImpl<_$AgeRangeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgeRangeImplToJson(this);
  }
}

abstract class _AgeRange implements AgeRange {
  const factory _AgeRange({final int minAge, final int maxAge}) =
      _$AgeRangeImpl;

  factory _AgeRange.fromJson(Map<String, dynamic> json) =
      _$AgeRangeImpl.fromJson;

  @override
  int get minAge;
  @override
  int get maxAge;

  /// Create a copy of AgeRange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgeRangeImplCopyWith<_$AgeRangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceDetails _$PriceDetailsFromJson(Map<String, dynamic> json) {
  return _PriceDetails.fromJson(json);
}

/// @nodoc
mixin _$PriceDetails {
  double get price => throw _privateConstructorUsedError;
  double get originalPrice => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  bool get isRefundAllowed => throw _privateConstructorUsedError;

  /// Serializes this PriceDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceDetailsCopyWith<PriceDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceDetailsCopyWith<$Res> {
  factory $PriceDetailsCopyWith(
    PriceDetails value,
    $Res Function(PriceDetails) then,
  ) = _$PriceDetailsCopyWithImpl<$Res, PriceDetails>;
  @useResult
  $Res call({
    double price,
    double originalPrice,
    String currency,
    bool isRefundAllowed,
  });
}

/// @nodoc
class _$PriceDetailsCopyWithImpl<$Res, $Val extends PriceDetails>
    implements $PriceDetailsCopyWith<$Res> {
  _$PriceDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? originalPrice = null,
    Object? currency = null,
    Object? isRefundAllowed = null,
  }) {
    return _then(
      _value.copyWith(
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            originalPrice: null == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            isRefundAllowed: null == isRefundAllowed
                ? _value.isRefundAllowed
                : isRefundAllowed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceDetailsImplCopyWith<$Res>
    implements $PriceDetailsCopyWith<$Res> {
  factory _$$PriceDetailsImplCopyWith(
    _$PriceDetailsImpl value,
    $Res Function(_$PriceDetailsImpl) then,
  ) = __$$PriceDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double price,
    double originalPrice,
    String currency,
    bool isRefundAllowed,
  });
}

/// @nodoc
class __$$PriceDetailsImplCopyWithImpl<$Res>
    extends _$PriceDetailsCopyWithImpl<$Res, _$PriceDetailsImpl>
    implements _$$PriceDetailsImplCopyWith<$Res> {
  __$$PriceDetailsImplCopyWithImpl(
    _$PriceDetailsImpl _value,
    $Res Function(_$PriceDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? originalPrice = null,
    Object? currency = null,
    Object? isRefundAllowed = null,
  }) {
    return _then(
      _$PriceDetailsImpl(
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        originalPrice: null == originalPrice
            ? _value.originalPrice
            : originalPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        isRefundAllowed: null == isRefundAllowed
            ? _value.isRefundAllowed
            : isRefundAllowed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PriceDetailsImpl implements _PriceDetails {
  const _$PriceDetailsImpl({
    this.price = 0.0,
    this.originalPrice = 0.0,
    this.currency = "INR",
    this.isRefundAllowed = false,
  });

  factory _$PriceDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceDetailsImplFromJson(json);

  @override
  @JsonKey()
  final double price;
  @override
  @JsonKey()
  final double originalPrice;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final bool isRefundAllowed;

  @override
  String toString() {
    return 'PriceDetails(price: $price, originalPrice: $originalPrice, currency: $currency, isRefundAllowed: $isRefundAllowed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceDetailsImpl &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.isRefundAllowed, isRefundAllowed) ||
                other.isRefundAllowed == isRefundAllowed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, price, originalPrice, currency, isRefundAllowed);

  /// Create a copy of PriceDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceDetailsImplCopyWith<_$PriceDetailsImpl> get copyWith =>
      __$$PriceDetailsImplCopyWithImpl<_$PriceDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceDetailsImplToJson(this);
  }
}

abstract class _PriceDetails implements PriceDetails {
  const factory _PriceDetails({
    final double price,
    final double originalPrice,
    final String currency,
    final bool isRefundAllowed,
  }) = _$PriceDetailsImpl;

  factory _PriceDetails.fromJson(Map<String, dynamic> json) =
      _$PriceDetailsImpl.fromJson;

  @override
  double get price;
  @override
  double get originalPrice;
  @override
  String get currency;
  @override
  bool get isRefundAllowed;

  /// Create a copy of PriceDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceDetailsImplCopyWith<_$PriceDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LobbyTicketOption _$LobbyTicketOptionFromJson(Map<String, dynamic> json) {
  return _LobbyTicketOption.fromJson(json);
}

/// @nodoc
mixin _$LobbyTicketOption {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get totalSlots => throw _privateConstructorUsedError;
  int get bookedSlots => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  int get minQuantity => throw _privateConstructorUsedError;
  int get maxQuantity => throw _privateConstructorUsedError; // per person
  String get activity =>
      throw _privateConstructorUsedError; // HIGH, LOW, MID, FULL
  bool get isDisabled => throw _privateConstructorUsedError;

  /// Serializes this LobbyTicketOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LobbyTicketOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LobbyTicketOptionCopyWith<LobbyTicketOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LobbyTicketOptionCopyWith<$Res> {
  factory $LobbyTicketOptionCopyWith(
    LobbyTicketOption value,
    $Res Function(LobbyTicketOption) then,
  ) = _$LobbyTicketOptionCopyWithImpl<$Res, LobbyTicketOption>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    double price,
    int totalSlots,
    int bookedSlots,
    String currency,
    int minQuantity,
    int maxQuantity,
    String activity,
    bool isDisabled,
  });
}

/// @nodoc
class _$LobbyTicketOptionCopyWithImpl<$Res, $Val extends LobbyTicketOption>
    implements $LobbyTicketOptionCopyWith<$Res> {
  _$LobbyTicketOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LobbyTicketOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? totalSlots = null,
    Object? bookedSlots = null,
    Object? currency = null,
    Object? minQuantity = null,
    Object? maxQuantity = null,
    Object? activity = null,
    Object? isDisabled = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            totalSlots: null == totalSlots
                ? _value.totalSlots
                : totalSlots // ignore: cast_nullable_to_non_nullable
                      as int,
            bookedSlots: null == bookedSlots
                ? _value.bookedSlots
                : bookedSlots // ignore: cast_nullable_to_non_nullable
                      as int,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            minQuantity: null == minQuantity
                ? _value.minQuantity
                : minQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            maxQuantity: null == maxQuantity
                ? _value.maxQuantity
                : maxQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            activity: null == activity
                ? _value.activity
                : activity // ignore: cast_nullable_to_non_nullable
                      as String,
            isDisabled: null == isDisabled
                ? _value.isDisabled
                : isDisabled // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LobbyTicketOptionImplCopyWith<$Res>
    implements $LobbyTicketOptionCopyWith<$Res> {
  factory _$$LobbyTicketOptionImplCopyWith(
    _$LobbyTicketOptionImpl value,
    $Res Function(_$LobbyTicketOptionImpl) then,
  ) = __$$LobbyTicketOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    double price,
    int totalSlots,
    int bookedSlots,
    String currency,
    int minQuantity,
    int maxQuantity,
    String activity,
    bool isDisabled,
  });
}

/// @nodoc
class __$$LobbyTicketOptionImplCopyWithImpl<$Res>
    extends _$LobbyTicketOptionCopyWithImpl<$Res, _$LobbyTicketOptionImpl>
    implements _$$LobbyTicketOptionImplCopyWith<$Res> {
  __$$LobbyTicketOptionImplCopyWithImpl(
    _$LobbyTicketOptionImpl _value,
    $Res Function(_$LobbyTicketOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LobbyTicketOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? totalSlots = null,
    Object? bookedSlots = null,
    Object? currency = null,
    Object? minQuantity = null,
    Object? maxQuantity = null,
    Object? activity = null,
    Object? isDisabled = null,
  }) {
    return _then(
      _$LobbyTicketOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        totalSlots: null == totalSlots
            ? _value.totalSlots
            : totalSlots // ignore: cast_nullable_to_non_nullable
                  as int,
        bookedSlots: null == bookedSlots
            ? _value.bookedSlots
            : bookedSlots // ignore: cast_nullable_to_non_nullable
                  as int,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        minQuantity: null == minQuantity
            ? _value.minQuantity
            : minQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        maxQuantity: null == maxQuantity
            ? _value.maxQuantity
            : maxQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        activity: null == activity
            ? _value.activity
            : activity // ignore: cast_nullable_to_non_nullable
                  as String,
        isDisabled: null == isDisabled
            ? _value.isDisabled
            : isDisabled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LobbyTicketOptionImpl implements _LobbyTicketOption {
  const _$LobbyTicketOptionImpl({
    this.id = "",
    this.name = "",
    this.description = "",
    this.price = 0.0,
    this.totalSlots = 0,
    this.bookedSlots = 0,
    this.currency = "INR",
    this.minQuantity = 1,
    this.maxQuantity = 1,
    this.activity = "",
    this.isDisabled = false,
  });

  factory _$LobbyTicketOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$LobbyTicketOptionImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final double price;
  @override
  @JsonKey()
  final int totalSlots;
  @override
  @JsonKey()
  final int bookedSlots;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final int minQuantity;
  @override
  @JsonKey()
  final int maxQuantity;
  // per person
  @override
  @JsonKey()
  final String activity;
  // HIGH, LOW, MID, FULL
  @override
  @JsonKey()
  final bool isDisabled;

  @override
  String toString() {
    return 'LobbyTicketOption(id: $id, name: $name, description: $description, price: $price, totalSlots: $totalSlots, bookedSlots: $bookedSlots, currency: $currency, minQuantity: $minQuantity, maxQuantity: $maxQuantity, activity: $activity, isDisabled: $isDisabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LobbyTicketOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.totalSlots, totalSlots) ||
                other.totalSlots == totalSlots) &&
            (identical(other.bookedSlots, bookedSlots) ||
                other.bookedSlots == bookedSlots) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.minQuantity, minQuantity) ||
                other.minQuantity == minQuantity) &&
            (identical(other.maxQuantity, maxQuantity) ||
                other.maxQuantity == maxQuantity) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.isDisabled, isDisabled) ||
                other.isDisabled == isDisabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    price,
    totalSlots,
    bookedSlots,
    currency,
    minQuantity,
    maxQuantity,
    activity,
    isDisabled,
  );

  /// Create a copy of LobbyTicketOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LobbyTicketOptionImplCopyWith<_$LobbyTicketOptionImpl> get copyWith =>
      __$$LobbyTicketOptionImplCopyWithImpl<_$LobbyTicketOptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LobbyTicketOptionImplToJson(this);
  }
}

abstract class _LobbyTicketOption implements LobbyTicketOption {
  const factory _LobbyTicketOption({
    final String id,
    final String name,
    final String description,
    final double price,
    final int totalSlots,
    final int bookedSlots,
    final String currency,
    final int minQuantity,
    final int maxQuantity,
    final String activity,
    final bool isDisabled,
  }) = _$LobbyTicketOptionImpl;

  factory _LobbyTicketOption.fromJson(Map<String, dynamic> json) =
      _$LobbyTicketOptionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  double get price;
  @override
  int get totalSlots;
  @override
  int get bookedSlots;
  @override
  String get currency;
  @override
  int get minQuantity;
  @override
  int get maxQuantity; // per person
  @override
  String get activity; // HIGH, LOW, MID, FULL
  @override
  bool get isDisabled;

  /// Create a copy of LobbyTicketOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LobbyTicketOptionImplCopyWith<_$LobbyTicketOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AccessRequestData _$AccessRequestDataFromJson(Map<String, dynamic> json) {
  return _AccessRequestData.fromJson(json);
}

/// @nodoc
mixin _$AccessRequestData {
  String get accessId => throw _privateConstructorUsedError;
  bool get isGroupAccess => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;

  /// Serializes this AccessRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccessRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccessRequestDataCopyWith<AccessRequestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccessRequestDataCopyWith<$Res> {
  factory $AccessRequestDataCopyWith(
    AccessRequestData value,
    $Res Function(AccessRequestData) then,
  ) = _$AccessRequestDataCopyWithImpl<$Res, AccessRequestData>;
  @useResult
  $Res call({
    String accessId,
    bool isGroupAccess,
    int count,
    double price,
    bool isAdmin,
  });
}

/// @nodoc
class _$AccessRequestDataCopyWithImpl<$Res, $Val extends AccessRequestData>
    implements $AccessRequestDataCopyWith<$Res> {
  _$AccessRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccessRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessId = null,
    Object? isGroupAccess = null,
    Object? count = null,
    Object? price = null,
    Object? isAdmin = null,
  }) {
    return _then(
      _value.copyWith(
            accessId: null == accessId
                ? _value.accessId
                : accessId // ignore: cast_nullable_to_non_nullable
                      as String,
            isGroupAccess: null == isGroupAccess
                ? _value.isGroupAccess
                : isGroupAccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            isAdmin: null == isAdmin
                ? _value.isAdmin
                : isAdmin // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccessRequestDataImplCopyWith<$Res>
    implements $AccessRequestDataCopyWith<$Res> {
  factory _$$AccessRequestDataImplCopyWith(
    _$AccessRequestDataImpl value,
    $Res Function(_$AccessRequestDataImpl) then,
  ) = __$$AccessRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accessId,
    bool isGroupAccess,
    int count,
    double price,
    bool isAdmin,
  });
}

/// @nodoc
class __$$AccessRequestDataImplCopyWithImpl<$Res>
    extends _$AccessRequestDataCopyWithImpl<$Res, _$AccessRequestDataImpl>
    implements _$$AccessRequestDataImplCopyWith<$Res> {
  __$$AccessRequestDataImplCopyWithImpl(
    _$AccessRequestDataImpl _value,
    $Res Function(_$AccessRequestDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccessRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessId = null,
    Object? isGroupAccess = null,
    Object? count = null,
    Object? price = null,
    Object? isAdmin = null,
  }) {
    return _then(
      _$AccessRequestDataImpl(
        accessId: null == accessId
            ? _value.accessId
            : accessId // ignore: cast_nullable_to_non_nullable
                  as String,
        isGroupAccess: null == isGroupAccess
            ? _value.isGroupAccess
            : isGroupAccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        isAdmin: null == isAdmin
            ? _value.isAdmin
            : isAdmin // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AccessRequestDataImpl implements _AccessRequestData {
  const _$AccessRequestDataImpl({
    this.accessId = "",
    this.isGroupAccess = false,
    this.count = 0,
    this.price = 0.0,
    this.isAdmin = false,
  });

  factory _$AccessRequestDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccessRequestDataImplFromJson(json);

  @override
  @JsonKey()
  final String accessId;
  @override
  @JsonKey()
  final bool isGroupAccess;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final double price;
  @override
  @JsonKey()
  final bool isAdmin;

  @override
  String toString() {
    return 'AccessRequestData(accessId: $accessId, isGroupAccess: $isGroupAccess, count: $count, price: $price, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccessRequestDataImpl &&
            (identical(other.accessId, accessId) ||
                other.accessId == accessId) &&
            (identical(other.isGroupAccess, isGroupAccess) ||
                other.isGroupAccess == isGroupAccess) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessId, isGroupAccess, count, price, isAdmin);

  /// Create a copy of AccessRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccessRequestDataImplCopyWith<_$AccessRequestDataImpl> get copyWith =>
      __$$AccessRequestDataImplCopyWithImpl<_$AccessRequestDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AccessRequestDataImplToJson(this);
  }
}

abstract class _AccessRequestData implements AccessRequestData {
  const factory _AccessRequestData({
    final String accessId,
    final bool isGroupAccess,
    final int count,
    final double price,
    final bool isAdmin,
  }) = _$AccessRequestDataImpl;

  factory _AccessRequestData.fromJson(Map<String, dynamic> json) =
      _$AccessRequestDataImpl.fromJson;

  @override
  String get accessId;
  @override
  bool get isGroupAccess;
  @override
  int get count;
  @override
  double get price;
  @override
  bool get isAdmin;

  /// Create a copy of AccessRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccessRequestDataImplCopyWith<_$AccessRequestDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HouseInfo _$HouseInfoFromJson(Map<String, dynamic> json) {
  return _HouseInfo.fromJson(json);
}

/// @nodoc
mixin _$HouseInfo {
  String get houseId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get profilePhoto => throw _privateConstructorUsedError;
  bool get panVerified => throw _privateConstructorUsedError;
  bool get accountVerified => throw _privateConstructorUsedError;
  bool get gstVerified => throw _privateConstructorUsedError;
  bool get loginNotRequired => throw _privateConstructorUsedError;

  /// Serializes this HouseInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HouseInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HouseInfoCopyWith<HouseInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HouseInfoCopyWith<$Res> {
  factory $HouseInfoCopyWith(HouseInfo value, $Res Function(HouseInfo) then) =
      _$HouseInfoCopyWithImpl<$Res, HouseInfo>;
  @useResult
  $Res call({
    String houseId,
    String name,
    String description,
    String profilePhoto,
    bool panVerified,
    bool accountVerified,
    bool gstVerified,
    bool loginNotRequired,
  });
}

/// @nodoc
class _$HouseInfoCopyWithImpl<$Res, $Val extends HouseInfo>
    implements $HouseInfoCopyWith<$Res> {
  _$HouseInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HouseInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? houseId = null,
    Object? name = null,
    Object? description = null,
    Object? profilePhoto = null,
    Object? panVerified = null,
    Object? accountVerified = null,
    Object? gstVerified = null,
    Object? loginNotRequired = null,
  }) {
    return _then(
      _value.copyWith(
            houseId: null == houseId
                ? _value.houseId
                : houseId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            profilePhoto: null == profilePhoto
                ? _value.profilePhoto
                : profilePhoto // ignore: cast_nullable_to_non_nullable
                      as String,
            panVerified: null == panVerified
                ? _value.panVerified
                : panVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            accountVerified: null == accountVerified
                ? _value.accountVerified
                : accountVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            gstVerified: null == gstVerified
                ? _value.gstVerified
                : gstVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            loginNotRequired: null == loginNotRequired
                ? _value.loginNotRequired
                : loginNotRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HouseInfoImplCopyWith<$Res>
    implements $HouseInfoCopyWith<$Res> {
  factory _$$HouseInfoImplCopyWith(
    _$HouseInfoImpl value,
    $Res Function(_$HouseInfoImpl) then,
  ) = __$$HouseInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String houseId,
    String name,
    String description,
    String profilePhoto,
    bool panVerified,
    bool accountVerified,
    bool gstVerified,
    bool loginNotRequired,
  });
}

/// @nodoc
class __$$HouseInfoImplCopyWithImpl<$Res>
    extends _$HouseInfoCopyWithImpl<$Res, _$HouseInfoImpl>
    implements _$$HouseInfoImplCopyWith<$Res> {
  __$$HouseInfoImplCopyWithImpl(
    _$HouseInfoImpl _value,
    $Res Function(_$HouseInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HouseInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? houseId = null,
    Object? name = null,
    Object? description = null,
    Object? profilePhoto = null,
    Object? panVerified = null,
    Object? accountVerified = null,
    Object? gstVerified = null,
    Object? loginNotRequired = null,
  }) {
    return _then(
      _$HouseInfoImpl(
        houseId: null == houseId
            ? _value.houseId
            : houseId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        profilePhoto: null == profilePhoto
            ? _value.profilePhoto
            : profilePhoto // ignore: cast_nullable_to_non_nullable
                  as String,
        panVerified: null == panVerified
            ? _value.panVerified
            : panVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        accountVerified: null == accountVerified
            ? _value.accountVerified
            : accountVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        gstVerified: null == gstVerified
            ? _value.gstVerified
            : gstVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        loginNotRequired: null == loginNotRequired
            ? _value.loginNotRequired
            : loginNotRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$HouseInfoImpl implements _HouseInfo {
  const _$HouseInfoImpl({
    this.houseId = "",
    this.name = "",
    this.description = "",
    this.profilePhoto = "",
    this.panVerified = false,
    this.accountVerified = false,
    this.gstVerified = false,
    this.loginNotRequired = false,
  });

  factory _$HouseInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HouseInfoImplFromJson(json);

  @override
  @JsonKey()
  final String houseId;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String profilePhoto;
  @override
  @JsonKey()
  final bool panVerified;
  @override
  @JsonKey()
  final bool accountVerified;
  @override
  @JsonKey()
  final bool gstVerified;
  @override
  @JsonKey()
  final bool loginNotRequired;

  @override
  String toString() {
    return 'HouseInfo(houseId: $houseId, name: $name, description: $description, profilePhoto: $profilePhoto, panVerified: $panVerified, accountVerified: $accountVerified, gstVerified: $gstVerified, loginNotRequired: $loginNotRequired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HouseInfoImpl &&
            (identical(other.houseId, houseId) || other.houseId == houseId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.profilePhoto, profilePhoto) ||
                other.profilePhoto == profilePhoto) &&
            (identical(other.panVerified, panVerified) ||
                other.panVerified == panVerified) &&
            (identical(other.accountVerified, accountVerified) ||
                other.accountVerified == accountVerified) &&
            (identical(other.gstVerified, gstVerified) ||
                other.gstVerified == gstVerified) &&
            (identical(other.loginNotRequired, loginNotRequired) ||
                other.loginNotRequired == loginNotRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    houseId,
    name,
    description,
    profilePhoto,
    panVerified,
    accountVerified,
    gstVerified,
    loginNotRequired,
  );

  /// Create a copy of HouseInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HouseInfoImplCopyWith<_$HouseInfoImpl> get copyWith =>
      __$$HouseInfoImplCopyWithImpl<_$HouseInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HouseInfoImplToJson(this);
  }
}

abstract class _HouseInfo implements HouseInfo {
  const factory _HouseInfo({
    final String houseId,
    final String name,
    final String description,
    final String profilePhoto,
    final bool panVerified,
    final bool accountVerified,
    final bool gstVerified,
    final bool loginNotRequired,
  }) = _$HouseInfoImpl;

  factory _HouseInfo.fromJson(Map<String, dynamic> json) =
      _$HouseInfoImpl.fromJson;

  @override
  String get houseId;
  @override
  String get name;
  @override
  String get description;
  @override
  String get profilePhoto;
  @override
  bool get panVerified;
  @override
  bool get accountVerified;
  @override
  bool get gstVerified;
  @override
  bool get loginNotRequired;

  /// Create a copy of HouseInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HouseInfoImplCopyWith<_$HouseInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdminSummary _$AdminSummaryFromJson(Map<String, dynamic> json) {
  return _AdminSummary.fromJson(json);
}

/// @nodoc
mixin _$AdminSummary {
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get profilePictureUrl => throw _privateConstructorUsedError;
  bool get isFriend => throw _privateConstructorUsedError;
  bool get requestSent => throw _privateConstructorUsedError;
  bool get requestReceived => throw _privateConstructorUsedError;
  Location? get location => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this AdminSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminSummaryCopyWith<AdminSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminSummaryCopyWith<$Res> {
  factory $AdminSummaryCopyWith(
    AdminSummary value,
    $Res Function(AdminSummary) then,
  ) = _$AdminSummaryCopyWithImpl<$Res, AdminSummary>;
  @useResult
  $Res call({
    String userId,
    String userName,
    String name,
    String gender,
    String profilePictureUrl,
    bool isFriend,
    bool requestSent,
    bool requestReceived,
    Location? location,
    bool active,
  });

  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class _$AdminSummaryCopyWithImpl<$Res, $Val extends AdminSummary>
    implements $AdminSummaryCopyWith<$Res> {
  _$AdminSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? name = null,
    Object? gender = null,
    Object? profilePictureUrl = null,
    Object? isFriend = null,
    Object? requestSent = null,
    Object? requestReceived = null,
    Object? location = freezed,
    Object? active = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            profilePictureUrl: null == profilePictureUrl
                ? _value.profilePictureUrl
                : profilePictureUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            isFriend: null == isFriend
                ? _value.isFriend
                : isFriend // ignore: cast_nullable_to_non_nullable
                      as bool,
            requestSent: null == requestSent
                ? _value.requestSent
                : requestSent // ignore: cast_nullable_to_non_nullable
                      as bool,
            requestReceived: null == requestReceived
                ? _value.requestReceived
                : requestReceived // ignore: cast_nullable_to_non_nullable
                      as bool,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as Location?,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of AdminSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdminSummaryImplCopyWith<$Res>
    implements $AdminSummaryCopyWith<$Res> {
  factory _$$AdminSummaryImplCopyWith(
    _$AdminSummaryImpl value,
    $Res Function(_$AdminSummaryImpl) then,
  ) = __$$AdminSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String userName,
    String name,
    String gender,
    String profilePictureUrl,
    bool isFriend,
    bool requestSent,
    bool requestReceived,
    Location? location,
    bool active,
  });

  @override
  $LocationCopyWith<$Res>? get location;
}

/// @nodoc
class __$$AdminSummaryImplCopyWithImpl<$Res>
    extends _$AdminSummaryCopyWithImpl<$Res, _$AdminSummaryImpl>
    implements _$$AdminSummaryImplCopyWith<$Res> {
  __$$AdminSummaryImplCopyWithImpl(
    _$AdminSummaryImpl _value,
    $Res Function(_$AdminSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? name = null,
    Object? gender = null,
    Object? profilePictureUrl = null,
    Object? isFriend = null,
    Object? requestSent = null,
    Object? requestReceived = null,
    Object? location = freezed,
    Object? active = null,
  }) {
    return _then(
      _$AdminSummaryImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        profilePictureUrl: null == profilePictureUrl
            ? _value.profilePictureUrl
            : profilePictureUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        isFriend: null == isFriend
            ? _value.isFriend
            : isFriend // ignore: cast_nullable_to_non_nullable
                  as bool,
        requestSent: null == requestSent
            ? _value.requestSent
            : requestSent // ignore: cast_nullable_to_non_nullable
                  as bool,
        requestReceived: null == requestReceived
            ? _value.requestReceived
            : requestReceived // ignore: cast_nullable_to_non_nullable
                  as bool,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as Location?,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AdminSummaryImpl implements _AdminSummary {
  const _$AdminSummaryImpl({
    required this.userId,
    this.userName = "",
    this.name = "",
    this.gender = "",
    this.profilePictureUrl = "",
    this.isFriend = false,
    this.requestSent = false,
    this.requestReceived = false,
    this.location,
    this.active = false,
  });

  factory _$AdminSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminSummaryImplFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String gender;
  @override
  @JsonKey()
  final String profilePictureUrl;
  @override
  @JsonKey()
  final bool isFriend;
  @override
  @JsonKey()
  final bool requestSent;
  @override
  @JsonKey()
  final bool requestReceived;
  @override
  final Location? location;
  @override
  @JsonKey()
  final bool active;

  @override
  String toString() {
    return 'AdminSummary(userId: $userId, userName: $userName, name: $name, gender: $gender, profilePictureUrl: $profilePictureUrl, isFriend: $isFriend, requestSent: $requestSent, requestReceived: $requestReceived, location: $location, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminSummaryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.profilePictureUrl, profilePictureUrl) ||
                other.profilePictureUrl == profilePictureUrl) &&
            (identical(other.isFriend, isFriend) ||
                other.isFriend == isFriend) &&
            (identical(other.requestSent, requestSent) ||
                other.requestSent == requestSent) &&
            (identical(other.requestReceived, requestReceived) ||
                other.requestReceived == requestReceived) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    userName,
    name,
    gender,
    profilePictureUrl,
    isFriend,
    requestSent,
    requestReceived,
    location,
    active,
  );

  /// Create a copy of AdminSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminSummaryImplCopyWith<_$AdminSummaryImpl> get copyWith =>
      __$$AdminSummaryImplCopyWithImpl<_$AdminSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminSummaryImplToJson(this);
  }
}

abstract class _AdminSummary implements AdminSummary {
  const factory _AdminSummary({
    required final String userId,
    final String userName,
    final String name,
    final String gender,
    final String profilePictureUrl,
    final bool isFriend,
    final bool requestSent,
    final bool requestReceived,
    final Location? location,
    final bool active,
  }) = _$AdminSummaryImpl;

  factory _AdminSummary.fromJson(Map<String, dynamic> json) =
      _$AdminSummaryImpl.fromJson;

  @override
  String get userId;
  @override
  String get userName;
  @override
  String get name;
  @override
  String get gender;
  @override
  String get profilePictureUrl;
  @override
  bool get isFriend;
  @override
  bool get requestSent;
  @override
  bool get requestReceived;
  @override
  Location? get location;
  @override
  bool get active;

  /// Create a copy of AdminSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminSummaryImplCopyWith<_$AdminSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContentModel _$ContentModelFromJson(Map<String, dynamic> json) {
  return _ContentModel.fromJson(json);
}

/// @nodoc
mixin _$ContentModel {
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;

  /// Serializes this ContentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentModelCopyWith<ContentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentModelCopyWith<$Res> {
  factory $ContentModelCopyWith(
    ContentModel value,
    $Res Function(ContentModel) then,
  ) = _$ContentModelCopyWithImpl<$Res, ContentModel>;
  @useResult
  $Res call({String title, String body});
}

/// @nodoc
class _$ContentModelCopyWithImpl<$Res, $Val extends ContentModel>
    implements $ContentModelCopyWith<$Res> {
  _$ContentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? body = null}) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContentModelImplCopyWith<$Res>
    implements $ContentModelCopyWith<$Res> {
  factory _$$ContentModelImplCopyWith(
    _$ContentModelImpl value,
    $Res Function(_$ContentModelImpl) then,
  ) = __$$ContentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String body});
}

/// @nodoc
class __$$ContentModelImplCopyWithImpl<$Res>
    extends _$ContentModelCopyWithImpl<$Res, _$ContentModelImpl>
    implements _$$ContentModelImplCopyWith<$Res> {
  __$$ContentModelImplCopyWithImpl(
    _$ContentModelImpl _value,
    $Res Function(_$ContentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? body = null}) {
    return _then(
      _$ContentModelImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentModelImpl implements _ContentModel {
  const _$ContentModelImpl({this.title = "", this.body = ""});

  factory _$ContentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentModelImplFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String body;

  @override
  String toString() {
    return 'ContentModel(title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, body);

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentModelImplCopyWith<_$ContentModelImpl> get copyWith =>
      __$$ContentModelImplCopyWithImpl<_$ContentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentModelImplToJson(this);
  }
}

abstract class _ContentModel implements ContentModel {
  const factory _ContentModel({final String title, final String body}) =
      _$ContentModelImpl;

  factory _ContentModel.fromJson(Map<String, dynamic> json) =
      _$ContentModelImpl.fromJson;

  @override
  String get title;
  @override
  String get body;

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentModelImplCopyWith<_$ContentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceTier _$PriceTierFromJson(Map<String, dynamic> json) {
  return _PriceTier.fromJson(json);
}

/// @nodoc
mixin _$PriceTier {
  int get minSlots => throw _privateConstructorUsedError;
  int get maxSlots => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  /// Serializes this PriceTier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceTier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceTierCopyWith<PriceTier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceTierCopyWith<$Res> {
  factory $PriceTierCopyWith(PriceTier value, $Res Function(PriceTier) then) =
      _$PriceTierCopyWithImpl<$Res, PriceTier>;
  @useResult
  $Res call({int minSlots, int maxSlots, double price});
}

/// @nodoc
class _$PriceTierCopyWithImpl<$Res, $Val extends PriceTier>
    implements $PriceTierCopyWith<$Res> {
  _$PriceTierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceTier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minSlots = null,
    Object? maxSlots = null,
    Object? price = null,
  }) {
    return _then(
      _value.copyWith(
            minSlots: null == minSlots
                ? _value.minSlots
                : minSlots // ignore: cast_nullable_to_non_nullable
                      as int,
            maxSlots: null == maxSlots
                ? _value.maxSlots
                : maxSlots // ignore: cast_nullable_to_non_nullable
                      as int,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceTierImplCopyWith<$Res>
    implements $PriceTierCopyWith<$Res> {
  factory _$$PriceTierImplCopyWith(
    _$PriceTierImpl value,
    $Res Function(_$PriceTierImpl) then,
  ) = __$$PriceTierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int minSlots, int maxSlots, double price});
}

/// @nodoc
class __$$PriceTierImplCopyWithImpl<$Res>
    extends _$PriceTierCopyWithImpl<$Res, _$PriceTierImpl>
    implements _$$PriceTierImplCopyWith<$Res> {
  __$$PriceTierImplCopyWithImpl(
    _$PriceTierImpl _value,
    $Res Function(_$PriceTierImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceTier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minSlots = null,
    Object? maxSlots = null,
    Object? price = null,
  }) {
    return _then(
      _$PriceTierImpl(
        minSlots: null == minSlots
            ? _value.minSlots
            : minSlots // ignore: cast_nullable_to_non_nullable
                  as int,
        maxSlots: null == maxSlots
            ? _value.maxSlots
            : maxSlots // ignore: cast_nullable_to_non_nullable
                  as int,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PriceTierImpl implements _PriceTier {
  const _$PriceTierImpl({
    this.minSlots = 0,
    this.maxSlots = 0,
    this.price = 0.0,
  });

  factory _$PriceTierImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceTierImplFromJson(json);

  @override
  @JsonKey()
  final int minSlots;
  @override
  @JsonKey()
  final int maxSlots;
  @override
  @JsonKey()
  final double price;

  @override
  String toString() {
    return 'PriceTier(minSlots: $minSlots, maxSlots: $maxSlots, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceTierImpl &&
            (identical(other.minSlots, minSlots) ||
                other.minSlots == minSlots) &&
            (identical(other.maxSlots, maxSlots) ||
                other.maxSlots == maxSlots) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minSlots, maxSlots, price);

  /// Create a copy of PriceTier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceTierImplCopyWith<_$PriceTierImpl> get copyWith =>
      __$$PriceTierImplCopyWithImpl<_$PriceTierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceTierImplToJson(this);
  }
}

abstract class _PriceTier implements PriceTier {
  const factory _PriceTier({
    final int minSlots,
    final int maxSlots,
    final double price,
  }) = _$PriceTierImpl;

  factory _PriceTier.fromJson(Map<String, dynamic> json) =
      _$PriceTierImpl.fromJson;

  @override
  int get minSlots;
  @override
  int get maxSlots;
  @override
  double get price;

  /// Create a copy of PriceTier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceTierImplCopyWith<_$PriceTierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return _Filter.fromJson(json);
}

/// @nodoc
mixin _$Filter {
  String get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  String get subCategoryId => throw _privateConstructorUsedError;
  String get subCategoryName => throw _privateConstructorUsedError;
  List<FilterInfo> get filterInfoList => throw _privateConstructorUsedError;
  List<FilterInfo> get advancedFilterInfoList =>
      throw _privateConstructorUsedError;
  OtherFilterInfo get otherFilterInfo => throw _privateConstructorUsedError;
  int? get createdDate => throw _privateConstructorUsedError;

  /// Serializes this Filter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterCopyWith<Filter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterCopyWith<$Res> {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) then) =
      _$FilterCopyWithImpl<$Res, Filter>;
  @useResult
  $Res call({
    String categoryId,
    String categoryName,
    String subCategoryId,
    String subCategoryName,
    List<FilterInfo> filterInfoList,
    List<FilterInfo> advancedFilterInfoList,
    OtherFilterInfo otherFilterInfo,
    int? createdDate,
  });

  $OtherFilterInfoCopyWith<$Res> get otherFilterInfo;
}

/// @nodoc
class _$FilterCopyWithImpl<$Res, $Val extends Filter>
    implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? subCategoryId = null,
    Object? subCategoryName = null,
    Object? filterInfoList = null,
    Object? advancedFilterInfoList = null,
    Object? otherFilterInfo = null,
    Object? createdDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            subCategoryId: null == subCategoryId
                ? _value.subCategoryId
                : subCategoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            subCategoryName: null == subCategoryName
                ? _value.subCategoryName
                : subCategoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            filterInfoList: null == filterInfoList
                ? _value.filterInfoList
                : filterInfoList // ignore: cast_nullable_to_non_nullable
                      as List<FilterInfo>,
            advancedFilterInfoList: null == advancedFilterInfoList
                ? _value.advancedFilterInfoList
                : advancedFilterInfoList // ignore: cast_nullable_to_non_nullable
                      as List<FilterInfo>,
            otherFilterInfo: null == otherFilterInfo
                ? _value.otherFilterInfo
                : otherFilterInfo // ignore: cast_nullable_to_non_nullable
                      as OtherFilterInfo,
            createdDate: freezed == createdDate
                ? _value.createdDate
                : createdDate // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtherFilterInfoCopyWith<$Res> get otherFilterInfo {
    return $OtherFilterInfoCopyWith<$Res>(_value.otherFilterInfo, (value) {
      return _then(_value.copyWith(otherFilterInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FilterImplCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory _$$FilterImplCopyWith(
    _$FilterImpl value,
    $Res Function(_$FilterImpl) then,
  ) = __$$FilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String categoryId,
    String categoryName,
    String subCategoryId,
    String subCategoryName,
    List<FilterInfo> filterInfoList,
    List<FilterInfo> advancedFilterInfoList,
    OtherFilterInfo otherFilterInfo,
    int? createdDate,
  });

  @override
  $OtherFilterInfoCopyWith<$Res> get otherFilterInfo;
}

/// @nodoc
class __$$FilterImplCopyWithImpl<$Res>
    extends _$FilterCopyWithImpl<$Res, _$FilterImpl>
    implements _$$FilterImplCopyWith<$Res> {
  __$$FilterImplCopyWithImpl(
    _$FilterImpl _value,
    $Res Function(_$FilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? subCategoryId = null,
    Object? subCategoryName = null,
    Object? filterInfoList = null,
    Object? advancedFilterInfoList = null,
    Object? otherFilterInfo = null,
    Object? createdDate = freezed,
  }) {
    return _then(
      _$FilterImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        subCategoryId: null == subCategoryId
            ? _value.subCategoryId
            : subCategoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        subCategoryName: null == subCategoryName
            ? _value.subCategoryName
            : subCategoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        filterInfoList: null == filterInfoList
            ? _value._filterInfoList
            : filterInfoList // ignore: cast_nullable_to_non_nullable
                  as List<FilterInfo>,
        advancedFilterInfoList: null == advancedFilterInfoList
            ? _value._advancedFilterInfoList
            : advancedFilterInfoList // ignore: cast_nullable_to_non_nullable
                  as List<FilterInfo>,
        otherFilterInfo: null == otherFilterInfo
            ? _value.otherFilterInfo
            : otherFilterInfo // ignore: cast_nullable_to_non_nullable
                  as OtherFilterInfo,
        createdDate: freezed == createdDate
            ? _value.createdDate
            : createdDate // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$FilterImpl implements _Filter {
  const _$FilterImpl({
    required this.categoryId,
    this.categoryName = '',
    required this.subCategoryId,
    this.subCategoryName = '',
    final List<FilterInfo> filterInfoList = const [],
    final List<FilterInfo> advancedFilterInfoList = const [],
    this.otherFilterInfo = const OtherFilterInfo(),
    required this.createdDate,
  }) : _filterInfoList = filterInfoList,
       _advancedFilterInfoList = advancedFilterInfoList;

  factory _$FilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterImplFromJson(json);

  @override
  final String categoryId;
  @override
  @JsonKey()
  final String categoryName;
  @override
  final String subCategoryId;
  @override
  @JsonKey()
  final String subCategoryName;
  final List<FilterInfo> _filterInfoList;
  @override
  @JsonKey()
  List<FilterInfo> get filterInfoList {
    if (_filterInfoList is EqualUnmodifiableListView) return _filterInfoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filterInfoList);
  }

  final List<FilterInfo> _advancedFilterInfoList;
  @override
  @JsonKey()
  List<FilterInfo> get advancedFilterInfoList {
    if (_advancedFilterInfoList is EqualUnmodifiableListView)
      return _advancedFilterInfoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_advancedFilterInfoList);
  }

  @override
  @JsonKey()
  final OtherFilterInfo otherFilterInfo;
  @override
  final int? createdDate;

  @override
  String toString() {
    return 'Filter(categoryId: $categoryId, categoryName: $categoryName, subCategoryId: $subCategoryId, subCategoryName: $subCategoryName, filterInfoList: $filterInfoList, advancedFilterInfoList: $advancedFilterInfoList, otherFilterInfo: $otherFilterInfo, createdDate: $createdDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.subCategoryId, subCategoryId) ||
                other.subCategoryId == subCategoryId) &&
            (identical(other.subCategoryName, subCategoryName) ||
                other.subCategoryName == subCategoryName) &&
            const DeepCollectionEquality().equals(
              other._filterInfoList,
              _filterInfoList,
            ) &&
            const DeepCollectionEquality().equals(
              other._advancedFilterInfoList,
              _advancedFilterInfoList,
            ) &&
            (identical(other.otherFilterInfo, otherFilterInfo) ||
                other.otherFilterInfo == otherFilterInfo) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    categoryName,
    subCategoryId,
    subCategoryName,
    const DeepCollectionEquality().hash(_filterInfoList),
    const DeepCollectionEquality().hash(_advancedFilterInfoList),
    otherFilterInfo,
    createdDate,
  );

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterImplCopyWith<_$FilterImpl> get copyWith =>
      __$$FilterImplCopyWithImpl<_$FilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterImplToJson(this);
  }
}

abstract class _Filter implements Filter {
  const factory _Filter({
    required final String categoryId,
    final String categoryName,
    required final String subCategoryId,
    final String subCategoryName,
    final List<FilterInfo> filterInfoList,
    final List<FilterInfo> advancedFilterInfoList,
    final OtherFilterInfo otherFilterInfo,
    required final int? createdDate,
  }) = _$FilterImpl;

  factory _Filter.fromJson(Map<String, dynamic> json) = _$FilterImpl.fromJson;

  @override
  String get categoryId;
  @override
  String get categoryName;
  @override
  String get subCategoryId;
  @override
  String get subCategoryName;
  @override
  List<FilterInfo> get filterInfoList;
  @override
  List<FilterInfo> get advancedFilterInfoList;
  @override
  OtherFilterInfo get otherFilterInfo;
  @override
  int? get createdDate;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterImplCopyWith<_$FilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FilterInfo _$FilterInfoFromJson(Map<String, dynamic> json) {
  return _FilterInfo.fromJson(json);
}

/// @nodoc
mixin _$FilterInfo {
  List<String> get options => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;

  /// Serializes this FilterInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterInfoCopyWith<FilterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterInfoCopyWith<$Res> {
  factory $FilterInfoCopyWith(
    FilterInfo value,
    $Res Function(FilterInfo) then,
  ) = _$FilterInfoCopyWithImpl<$Res, FilterInfo>;
  @useResult
  $Res call({
    List<String> options,
    String title,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class _$FilterInfoCopyWithImpl<$Res, $Val extends FilterInfo>
    implements $FilterInfoCopyWith<$Res> {
  _$FilterInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
    Object? title = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _value.copyWith(
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FilterInfoImplCopyWith<$Res>
    implements $FilterInfoCopyWith<$Res> {
  factory _$$FilterInfoImplCopyWith(
    _$FilterInfoImpl value,
    $Res Function(_$FilterInfoImpl) then,
  ) = __$$FilterInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String> options,
    String title,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class __$$FilterInfoImplCopyWithImpl<$Res>
    extends _$FilterInfoCopyWithImpl<$Res, _$FilterInfoImpl>
    implements _$$FilterInfoImplCopyWith<$Res> {
  __$$FilterInfoImplCopyWithImpl(
    _$FilterInfoImpl _value,
    $Res Function(_$FilterInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
    Object? title = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _$FilterInfoImpl(
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$FilterInfoImpl implements _FilterInfo {
  const _$FilterInfoImpl({
    final List<String> options = const [],
    required this.title,
    this.iconUrl,
    this.filterType = "",
    this.weightage = 0,
    this.showInCompactView = false,
  }) : _options = options;

  factory _$FilterInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterInfoImplFromJson(json);

  final List<String> _options;
  @override
  @JsonKey()
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final String title;
  @override
  final String? iconUrl;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final int weightage;
  @override
  @JsonKey()
  final bool showInCompactView;

  @override
  String toString() {
    return 'FilterInfo(options: $options, title: $title, iconUrl: $iconUrl, filterType: $filterType, weightage: $weightage, showInCompactView: $showInCompactView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterInfoImpl &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_options),
    title,
    iconUrl,
    filterType,
    weightage,
    showInCompactView,
  );

  /// Create a copy of FilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterInfoImplCopyWith<_$FilterInfoImpl> get copyWith =>
      __$$FilterInfoImplCopyWithImpl<_$FilterInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterInfoImplToJson(this);
  }
}

abstract class _FilterInfo implements FilterInfo {
  const factory _FilterInfo({
    final List<String> options,
    required final String title,
    final String? iconUrl,
    final String filterType,
    final int weightage,
    final bool showInCompactView,
  }) = _$FilterInfoImpl;

  factory _FilterInfo.fromJson(Map<String, dynamic> json) =
      _$FilterInfoImpl.fromJson;

  @override
  List<String> get options;
  @override
  String get title;
  @override
  String? get iconUrl;
  @override
  String get filterType;
  @override
  int get weightage;
  @override
  bool get showInCompactView;

  /// Create a copy of FilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterInfoImplCopyWith<_$FilterInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtherFilterInfo _$OtherFilterInfoFromJson(Map<String, dynamic> json) {
  return _OtherFilterInfo.fromJson(json);
}

/// @nodoc
mixin _$OtherFilterInfo {
  DateInfo? get dateInfo => throw _privateConstructorUsedError;
  DateRange? get dateRange => throw _privateConstructorUsedError;
  Destination? get destination => throw _privateConstructorUsedError;
  PaidLobby? get paidLobby => throw _privateConstructorUsedError;
  PickUp? get pickUp => throw _privateConstructorUsedError;
  MemberCount? get memberCount => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  CurrentCount? get currentCount => throw _privateConstructorUsedError;
  Range? get range => throw _privateConstructorUsedError;
  LocationInfo? get locationInfo => throw _privateConstructorUsedError;
  LocationInfo? get multipleLocations => throw _privateConstructorUsedError;
  List<Info>? get info => throw _privateConstructorUsedError;

  /// Serializes this OtherFilterInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtherFilterInfoCopyWith<OtherFilterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtherFilterInfoCopyWith<$Res> {
  factory $OtherFilterInfoCopyWith(
    OtherFilterInfo value,
    $Res Function(OtherFilterInfo) then,
  ) = _$OtherFilterInfoCopyWithImpl<$Res, OtherFilterInfo>;
  @useResult
  $Res call({
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
  });

  $DateInfoCopyWith<$Res>? get dateInfo;
  $DateRangeCopyWith<$Res>? get dateRange;
  $DestinationCopyWith<$Res>? get destination;
  $PaidLobbyCopyWith<$Res>? get paidLobby;
  $PickUpCopyWith<$Res>? get pickUp;
  $MemberCountCopyWith<$Res>? get memberCount;
  $CurrentCountCopyWith<$Res>? get currentCount;
  $RangeCopyWith<$Res>? get range;
  $LocationInfoCopyWith<$Res>? get locationInfo;
  $LocationInfoCopyWith<$Res>? get multipleLocations;
}

/// @nodoc
class _$OtherFilterInfoCopyWithImpl<$Res, $Val extends OtherFilterInfo>
    implements $OtherFilterInfoCopyWith<$Res> {
  _$OtherFilterInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateInfo = freezed,
    Object? dateRange = freezed,
    Object? destination = freezed,
    Object? paidLobby = freezed,
    Object? pickUp = freezed,
    Object? memberCount = freezed,
    Object? currentCount = freezed,
    Object? range = freezed,
    Object? locationInfo = freezed,
    Object? multipleLocations = freezed,
    Object? info = freezed,
  }) {
    return _then(
      _value.copyWith(
            dateInfo: freezed == dateInfo
                ? _value.dateInfo
                : dateInfo // ignore: cast_nullable_to_non_nullable
                      as DateInfo?,
            dateRange: freezed == dateRange
                ? _value.dateRange
                : dateRange // ignore: cast_nullable_to_non_nullable
                      as DateRange?,
            destination: freezed == destination
                ? _value.destination
                : destination // ignore: cast_nullable_to_non_nullable
                      as Destination?,
            paidLobby: freezed == paidLobby
                ? _value.paidLobby
                : paidLobby // ignore: cast_nullable_to_non_nullable
                      as PaidLobby?,
            pickUp: freezed == pickUp
                ? _value.pickUp
                : pickUp // ignore: cast_nullable_to_non_nullable
                      as PickUp?,
            memberCount: freezed == memberCount
                ? _value.memberCount
                : memberCount // ignore: cast_nullable_to_non_nullable
                      as MemberCount?,
            currentCount: freezed == currentCount
                ? _value.currentCount
                : currentCount // ignore: cast_nullable_to_non_nullable
                      as CurrentCount?,
            range: freezed == range
                ? _value.range
                : range // ignore: cast_nullable_to_non_nullable
                      as Range?,
            locationInfo: freezed == locationInfo
                ? _value.locationInfo
                : locationInfo // ignore: cast_nullable_to_non_nullable
                      as LocationInfo?,
            multipleLocations: freezed == multipleLocations
                ? _value.multipleLocations
                : multipleLocations // ignore: cast_nullable_to_non_nullable
                      as LocationInfo?,
            info: freezed == info
                ? _value.info
                : info // ignore: cast_nullable_to_non_nullable
                      as List<Info>?,
          )
          as $Val,
    );
  }

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DateInfoCopyWith<$Res>? get dateInfo {
    if (_value.dateInfo == null) {
      return null;
    }

    return $DateInfoCopyWith<$Res>(_value.dateInfo!, (value) {
      return _then(_value.copyWith(dateInfo: value) as $Val);
    });
  }

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DateRangeCopyWith<$Res>? get dateRange {
    if (_value.dateRange == null) {
      return null;
    }

    return $DateRangeCopyWith<$Res>(_value.dateRange!, (value) {
      return _then(_value.copyWith(dateRange: value) as $Val);
    });
  }

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DestinationCopyWith<$Res>? get destination {
    if (_value.destination == null) {
      return null;
    }

    return $DestinationCopyWith<$Res>(_value.destination!, (value) {
      return _then(_value.copyWith(destination: value) as $Val);
    });
  }

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaidLobbyCopyWith<$Res>? get paidLobby {
    if (_value.paidLobby == null) {
      return null;
    }

    return $PaidLobbyCopyWith<$Res>(_value.paidLobby!, (value) {
      return _then(_value.copyWith(paidLobby: value) as $Val);
    });
  }

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PickUpCopyWith<$Res>? get pickUp {
    if (_value.pickUp == null) {
      return null;
    }

    return $PickUpCopyWith<$Res>(_value.pickUp!, (value) {
      return _then(_value.copyWith(pickUp: value) as $Val);
    });
  }

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MemberCountCopyWith<$Res>? get memberCount {
    if (_value.memberCount == null) {
      return null;
    }

    return $MemberCountCopyWith<$Res>(_value.memberCount!, (value) {
      return _then(_value.copyWith(memberCount: value) as $Val);
    });
  }

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CurrentCountCopyWith<$Res>? get currentCount {
    if (_value.currentCount == null) {
      return null;
    }

    return $CurrentCountCopyWith<$Res>(_value.currentCount!, (value) {
      return _then(_value.copyWith(currentCount: value) as $Val);
    });
  }

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RangeCopyWith<$Res>? get range {
    if (_value.range == null) {
      return null;
    }

    return $RangeCopyWith<$Res>(_value.range!, (value) {
      return _then(_value.copyWith(range: value) as $Val);
    });
  }

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationInfoCopyWith<$Res>? get locationInfo {
    if (_value.locationInfo == null) {
      return null;
    }

    return $LocationInfoCopyWith<$Res>(_value.locationInfo!, (value) {
      return _then(_value.copyWith(locationInfo: value) as $Val);
    });
  }

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationInfoCopyWith<$Res>? get multipleLocations {
    if (_value.multipleLocations == null) {
      return null;
    }

    return $LocationInfoCopyWith<$Res>(_value.multipleLocations!, (value) {
      return _then(_value.copyWith(multipleLocations: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OtherFilterInfoImplCopyWith<$Res>
    implements $OtherFilterInfoCopyWith<$Res> {
  factory _$$OtherFilterInfoImplCopyWith(
    _$OtherFilterInfoImpl value,
    $Res Function(_$OtherFilterInfoImpl) then,
  ) = __$$OtherFilterInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
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
  });

  @override
  $DateInfoCopyWith<$Res>? get dateInfo;
  @override
  $DateRangeCopyWith<$Res>? get dateRange;
  @override
  $DestinationCopyWith<$Res>? get destination;
  @override
  $PaidLobbyCopyWith<$Res>? get paidLobby;
  @override
  $PickUpCopyWith<$Res>? get pickUp;
  @override
  $MemberCountCopyWith<$Res>? get memberCount;
  @override
  $CurrentCountCopyWith<$Res>? get currentCount;
  @override
  $RangeCopyWith<$Res>? get range;
  @override
  $LocationInfoCopyWith<$Res>? get locationInfo;
  @override
  $LocationInfoCopyWith<$Res>? get multipleLocations;
}

/// @nodoc
class __$$OtherFilterInfoImplCopyWithImpl<$Res>
    extends _$OtherFilterInfoCopyWithImpl<$Res, _$OtherFilterInfoImpl>
    implements _$$OtherFilterInfoImplCopyWith<$Res> {
  __$$OtherFilterInfoImplCopyWithImpl(
    _$OtherFilterInfoImpl _value,
    $Res Function(_$OtherFilterInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateInfo = freezed,
    Object? dateRange = freezed,
    Object? destination = freezed,
    Object? paidLobby = freezed,
    Object? pickUp = freezed,
    Object? memberCount = freezed,
    Object? currentCount = freezed,
    Object? range = freezed,
    Object? locationInfo = freezed,
    Object? multipleLocations = freezed,
    Object? info = freezed,
  }) {
    return _then(
      _$OtherFilterInfoImpl(
        dateInfo: freezed == dateInfo
            ? _value.dateInfo
            : dateInfo // ignore: cast_nullable_to_non_nullable
                  as DateInfo?,
        dateRange: freezed == dateRange
            ? _value.dateRange
            : dateRange // ignore: cast_nullable_to_non_nullable
                  as DateRange?,
        destination: freezed == destination
            ? _value.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as Destination?,
        paidLobby: freezed == paidLobby
            ? _value.paidLobby
            : paidLobby // ignore: cast_nullable_to_non_nullable
                  as PaidLobby?,
        pickUp: freezed == pickUp
            ? _value.pickUp
            : pickUp // ignore: cast_nullable_to_non_nullable
                  as PickUp?,
        memberCount: freezed == memberCount
            ? _value.memberCount
            : memberCount // ignore: cast_nullable_to_non_nullable
                  as MemberCount?,
        currentCount: freezed == currentCount
            ? _value.currentCount
            : currentCount // ignore: cast_nullable_to_non_nullable
                  as CurrentCount?,
        range: freezed == range
            ? _value.range
            : range // ignore: cast_nullable_to_non_nullable
                  as Range?,
        locationInfo: freezed == locationInfo
            ? _value.locationInfo
            : locationInfo // ignore: cast_nullable_to_non_nullable
                  as LocationInfo?,
        multipleLocations: freezed == multipleLocations
            ? _value.multipleLocations
            : multipleLocations // ignore: cast_nullable_to_non_nullable
                  as LocationInfo?,
        info: freezed == info
            ? _value._info
            : info // ignore: cast_nullable_to_non_nullable
                  as List<Info>?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$OtherFilterInfoImpl implements _OtherFilterInfo {
  const _$OtherFilterInfoImpl({
    this.dateInfo,
    this.dateRange,
    this.destination,
    this.paidLobby,
    this.pickUp,
    this.memberCount,
    @JsonKey(includeToJson: false) this.currentCount,
    this.range,
    this.locationInfo,
    this.multipleLocations,
    final List<Info>? info,
  }) : _info = info;

  factory _$OtherFilterInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtherFilterInfoImplFromJson(json);

  @override
  final DateInfo? dateInfo;
  @override
  final DateRange? dateRange;
  @override
  final Destination? destination;
  @override
  final PaidLobby? paidLobby;
  @override
  final PickUp? pickUp;
  @override
  final MemberCount? memberCount;
  @override
  @JsonKey(includeToJson: false)
  final CurrentCount? currentCount;
  @override
  final Range? range;
  @override
  final LocationInfo? locationInfo;
  @override
  final LocationInfo? multipleLocations;
  final List<Info>? _info;
  @override
  List<Info>? get info {
    final value = _info;
    if (value == null) return null;
    if (_info is EqualUnmodifiableListView) return _info;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'OtherFilterInfo(dateInfo: $dateInfo, dateRange: $dateRange, destination: $destination, paidLobby: $paidLobby, pickUp: $pickUp, memberCount: $memberCount, currentCount: $currentCount, range: $range, locationInfo: $locationInfo, multipleLocations: $multipleLocations, info: $info)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtherFilterInfoImpl &&
            (identical(other.dateInfo, dateInfo) ||
                other.dateInfo == dateInfo) &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.paidLobby, paidLobby) ||
                other.paidLobby == paidLobby) &&
            (identical(other.pickUp, pickUp) || other.pickUp == pickUp) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.currentCount, currentCount) ||
                other.currentCount == currentCount) &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.locationInfo, locationInfo) ||
                other.locationInfo == locationInfo) &&
            (identical(other.multipleLocations, multipleLocations) ||
                other.multipleLocations == multipleLocations) &&
            const DeepCollectionEquality().equals(other._info, _info));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dateInfo,
    dateRange,
    destination,
    paidLobby,
    pickUp,
    memberCount,
    currentCount,
    range,
    locationInfo,
    multipleLocations,
    const DeepCollectionEquality().hash(_info),
  );

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherFilterInfoImplCopyWith<_$OtherFilterInfoImpl> get copyWith =>
      __$$OtherFilterInfoImplCopyWithImpl<_$OtherFilterInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OtherFilterInfoImplToJson(this);
  }
}

abstract class _OtherFilterInfo implements OtherFilterInfo {
  const factory _OtherFilterInfo({
    final DateInfo? dateInfo,
    final DateRange? dateRange,
    final Destination? destination,
    final PaidLobby? paidLobby,
    final PickUp? pickUp,
    final MemberCount? memberCount,
    @JsonKey(includeToJson: false) final CurrentCount? currentCount,
    final Range? range,
    final LocationInfo? locationInfo,
    final LocationInfo? multipleLocations,
    final List<Info>? info,
  }) = _$OtherFilterInfoImpl;

  factory _OtherFilterInfo.fromJson(Map<String, dynamic> json) =
      _$OtherFilterInfoImpl.fromJson;

  @override
  DateInfo? get dateInfo;
  @override
  DateRange? get dateRange;
  @override
  Destination? get destination;
  @override
  PaidLobby? get paidLobby;
  @override
  PickUp? get pickUp;
  @override
  MemberCount? get memberCount;
  @override
  @JsonKey(includeToJson: false)
  CurrentCount? get currentCount;
  @override
  Range? get range;
  @override
  LocationInfo? get locationInfo;
  @override
  LocationInfo? get multipleLocations;
  @override
  List<Info>? get info;

  /// Create a copy of OtherFilterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtherFilterInfoImplCopyWith<_$OtherFilterInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DateInfo _$DateInfoFromJson(Map<String, dynamic> json) {
  return _DateInfo.fromJson(json);
}

/// @nodoc
mixin _$DateInfo {
  int get date => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get formattedDate => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;

  /// Serializes this DateInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DateInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DateInfoCopyWith<DateInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateInfoCopyWith<$Res> {
  factory $DateInfoCopyWith(DateInfo value, $Res Function(DateInfo) then) =
      _$DateInfoCopyWithImpl<$Res, DateInfo>;
  @useResult
  $Res call({
    int date,
    String title,
    String? formattedDate,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class _$DateInfoCopyWithImpl<$Res, $Val extends DateInfo>
    implements $DateInfoCopyWith<$Res> {
  _$DateInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DateInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? formattedDate = freezed,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            formattedDate: freezed == formattedDate
                ? _value.formattedDate
                : formattedDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DateInfoImplCopyWith<$Res>
    implements $DateInfoCopyWith<$Res> {
  factory _$$DateInfoImplCopyWith(
    _$DateInfoImpl value,
    $Res Function(_$DateInfoImpl) then,
  ) = __$$DateInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int date,
    String title,
    String? formattedDate,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class __$$DateInfoImplCopyWithImpl<$Res>
    extends _$DateInfoCopyWithImpl<$Res, _$DateInfoImpl>
    implements _$$DateInfoImplCopyWith<$Res> {
  __$$DateInfoImplCopyWithImpl(
    _$DateInfoImpl _value,
    $Res Function(_$DateInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DateInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? formattedDate = freezed,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _$DateInfoImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        formattedDate: freezed == formattedDate
            ? _value.formattedDate
            : formattedDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$DateInfoImpl implements _DateInfo {
  const _$DateInfoImpl({
    required this.date,
    required this.title,
    this.formattedDate,
    this.iconUrl,
    this.filterType = "DATE",
    this.weightage = 0,
    this.showInCompactView = false,
  });

  factory _$DateInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateInfoImplFromJson(json);

  @override
  final int date;
  @override
  final String title;
  @override
  final String? formattedDate;
  @override
  final String? iconUrl;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final int weightage;
  @override
  @JsonKey()
  final bool showInCompactView;

  @override
  String toString() {
    return 'DateInfo(date: $date, title: $title, formattedDate: $formattedDate, iconUrl: $iconUrl, filterType: $filterType, weightage: $weightage, showInCompactView: $showInCompactView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateInfoImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.formattedDate, formattedDate) ||
                other.formattedDate == formattedDate) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    title,
    formattedDate,
    iconUrl,
    filterType,
    weightage,
    showInCompactView,
  );

  /// Create a copy of DateInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateInfoImplCopyWith<_$DateInfoImpl> get copyWith =>
      __$$DateInfoImplCopyWithImpl<_$DateInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateInfoImplToJson(this);
  }
}

abstract class _DateInfo implements DateInfo {
  const factory _DateInfo({
    required final int date,
    required final String title,
    final String? formattedDate,
    final String? iconUrl,
    final String filterType,
    final int weightage,
    final bool showInCompactView,
  }) = _$DateInfoImpl;

  factory _DateInfo.fromJson(Map<String, dynamic> json) =
      _$DateInfoImpl.fromJson;

  @override
  int get date;
  @override
  String get title;
  @override
  String? get formattedDate;
  @override
  String? get iconUrl;
  @override
  String get filterType;
  @override
  int get weightage;
  @override
  bool get showInCompactView;

  /// Create a copy of DateInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateInfoImplCopyWith<_$DateInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DateRange _$DateRangeFromJson(Map<String, dynamic> json) {
  return _DateRange.fromJson(json);
}

/// @nodoc
mixin _$DateRange {
  int get startDate => throw _privateConstructorUsedError;
  int get endDate => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get formattedDate => throw _privateConstructorUsedError;
  String get formattedDateCompactView => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;

  /// Serializes this DateRange to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DateRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DateRangeCopyWith<DateRange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateRangeCopyWith<$Res> {
  factory $DateRangeCopyWith(DateRange value, $Res Function(DateRange) then) =
      _$DateRangeCopyWithImpl<$Res, DateRange>;
  @useResult
  $Res call({
    int startDate,
    int endDate,
    String title,
    String? formattedDate,
    String formattedDateCompactView,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class _$DateRangeCopyWithImpl<$Res, $Val extends DateRange>
    implements $DateRangeCopyWith<$Res> {
  _$DateRangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DateRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? title = null,
    Object? formattedDate = freezed,
    Object? formattedDateCompactView = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _value.copyWith(
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as int,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            formattedDate: freezed == formattedDate
                ? _value.formattedDate
                : formattedDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            formattedDateCompactView: null == formattedDateCompactView
                ? _value.formattedDateCompactView
                : formattedDateCompactView // ignore: cast_nullable_to_non_nullable
                      as String,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DateRangeImplCopyWith<$Res>
    implements $DateRangeCopyWith<$Res> {
  factory _$$DateRangeImplCopyWith(
    _$DateRangeImpl value,
    $Res Function(_$DateRangeImpl) then,
  ) = __$$DateRangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int startDate,
    int endDate,
    String title,
    String? formattedDate,
    String formattedDateCompactView,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class __$$DateRangeImplCopyWithImpl<$Res>
    extends _$DateRangeCopyWithImpl<$Res, _$DateRangeImpl>
    implements _$$DateRangeImplCopyWith<$Res> {
  __$$DateRangeImplCopyWithImpl(
    _$DateRangeImpl _value,
    $Res Function(_$DateRangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DateRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? title = null,
    Object? formattedDate = freezed,
    Object? formattedDateCompactView = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _$DateRangeImpl(
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as int,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        formattedDate: freezed == formattedDate
            ? _value.formattedDate
            : formattedDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        formattedDateCompactView: null == formattedDateCompactView
            ? _value.formattedDateCompactView
            : formattedDateCompactView // ignore: cast_nullable_to_non_nullable
                  as String,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$DateRangeImpl implements _DateRange {
  const _$DateRangeImpl({
    required this.startDate,
    required this.endDate,
    required this.title,
    this.formattedDate,
    this.formattedDateCompactView = "",
    this.iconUrl,
    this.filterType = "DATE_RANGE",
    this.weightage = 0,
    this.showInCompactView = false,
  });

  factory _$DateRangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateRangeImplFromJson(json);

  @override
  final int startDate;
  @override
  final int endDate;
  @override
  final String title;
  @override
  final String? formattedDate;
  @override
  @JsonKey()
  final String formattedDateCompactView;
  @override
  final String? iconUrl;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final int weightage;
  @override
  @JsonKey()
  final bool showInCompactView;

  @override
  String toString() {
    return 'DateRange(startDate: $startDate, endDate: $endDate, title: $title, formattedDate: $formattedDate, formattedDateCompactView: $formattedDateCompactView, iconUrl: $iconUrl, filterType: $filterType, weightage: $weightage, showInCompactView: $showInCompactView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateRangeImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.formattedDate, formattedDate) ||
                other.formattedDate == formattedDate) &&
            (identical(
                  other.formattedDateCompactView,
                  formattedDateCompactView,
                ) ||
                other.formattedDateCompactView == formattedDateCompactView) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    startDate,
    endDate,
    title,
    formattedDate,
    formattedDateCompactView,
    iconUrl,
    filterType,
    weightage,
    showInCompactView,
  );

  /// Create a copy of DateRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateRangeImplCopyWith<_$DateRangeImpl> get copyWith =>
      __$$DateRangeImplCopyWithImpl<_$DateRangeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateRangeImplToJson(this);
  }
}

abstract class _DateRange implements DateRange {
  const factory _DateRange({
    required final int startDate,
    required final int endDate,
    required final String title,
    final String? formattedDate,
    final String formattedDateCompactView,
    final String? iconUrl,
    final String filterType,
    final int weightage,
    final bool showInCompactView,
  }) = _$DateRangeImpl;

  factory _DateRange.fromJson(Map<String, dynamic> json) =
      _$DateRangeImpl.fromJson;

  @override
  int get startDate;
  @override
  int get endDate;
  @override
  String get title;
  @override
  String? get formattedDate;
  @override
  String get formattedDateCompactView;
  @override
  String? get iconUrl;
  @override
  String get filterType;
  @override
  int get weightage;
  @override
  bool get showInCompactView;

  /// Create a copy of DateRange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateRangeImplCopyWith<_$DateRangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Destination _$DestinationFromJson(Map<String, dynamic> json) {
  return _Destination.fromJson(json);
}

/// @nodoc
mixin _$Destination {
  String get title => throw _privateConstructorUsedError;
  Location? get location => throw _privateConstructorUsedError;
  LocationResponse? get locationResponse => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  GoogleSearchResponse? get googleSearchResponse =>
      throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;

  /// Serializes this Destination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DestinationCopyWith<Destination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DestinationCopyWith<$Res> {
  factory $DestinationCopyWith(
    Destination value,
    $Res Function(Destination) then,
  ) = _$DestinationCopyWithImpl<$Res, Destination>;
  @useResult
  $Res call({
    String title,
    Location? location,
    LocationResponse? locationResponse,
    String? iconUrl,
    GoogleSearchResponse? googleSearchResponse,
    String filterType,
    int weightage,
    bool showInCompactView,
  });

  $LocationCopyWith<$Res>? get location;
  $LocationResponseCopyWith<$Res>? get locationResponse;
  $GoogleSearchResponseCopyWith<$Res>? get googleSearchResponse;
}

/// @nodoc
class _$DestinationCopyWithImpl<$Res, $Val extends Destination>
    implements $DestinationCopyWith<$Res> {
  _$DestinationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? location = freezed,
    Object? locationResponse = freezed,
    Object? iconUrl = freezed,
    Object? googleSearchResponse = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as Location?,
            locationResponse: freezed == locationResponse
                ? _value.locationResponse
                : locationResponse // ignore: cast_nullable_to_non_nullable
                      as LocationResponse?,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            googleSearchResponse: freezed == googleSearchResponse
                ? _value.googleSearchResponse
                : googleSearchResponse // ignore: cast_nullable_to_non_nullable
                      as GoogleSearchResponse?,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationResponseCopyWith<$Res>? get locationResponse {
    if (_value.locationResponse == null) {
      return null;
    }

    return $LocationResponseCopyWith<$Res>(_value.locationResponse!, (value) {
      return _then(_value.copyWith(locationResponse: value) as $Val);
    });
  }

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoogleSearchResponseCopyWith<$Res>? get googleSearchResponse {
    if (_value.googleSearchResponse == null) {
      return null;
    }

    return $GoogleSearchResponseCopyWith<$Res>(_value.googleSearchResponse!, (
      value,
    ) {
      return _then(_value.copyWith(googleSearchResponse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DestinationImplCopyWith<$Res>
    implements $DestinationCopyWith<$Res> {
  factory _$$DestinationImplCopyWith(
    _$DestinationImpl value,
    $Res Function(_$DestinationImpl) then,
  ) = __$$DestinationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    Location? location,
    LocationResponse? locationResponse,
    String? iconUrl,
    GoogleSearchResponse? googleSearchResponse,
    String filterType,
    int weightage,
    bool showInCompactView,
  });

  @override
  $LocationCopyWith<$Res>? get location;
  @override
  $LocationResponseCopyWith<$Res>? get locationResponse;
  @override
  $GoogleSearchResponseCopyWith<$Res>? get googleSearchResponse;
}

/// @nodoc
class __$$DestinationImplCopyWithImpl<$Res>
    extends _$DestinationCopyWithImpl<$Res, _$DestinationImpl>
    implements _$$DestinationImplCopyWith<$Res> {
  __$$DestinationImplCopyWithImpl(
    _$DestinationImpl _value,
    $Res Function(_$DestinationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? location = freezed,
    Object? locationResponse = freezed,
    Object? iconUrl = freezed,
    Object? googleSearchResponse = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _$DestinationImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as Location?,
        locationResponse: freezed == locationResponse
            ? _value.locationResponse
            : locationResponse // ignore: cast_nullable_to_non_nullable
                  as LocationResponse?,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        googleSearchResponse: freezed == googleSearchResponse
            ? _value.googleSearchResponse
            : googleSearchResponse // ignore: cast_nullable_to_non_nullable
                  as GoogleSearchResponse?,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$DestinationImpl implements _Destination {
  const _$DestinationImpl({
    required this.title,
    this.location,
    this.locationResponse,
    this.iconUrl,
    this.googleSearchResponse,
    this.filterType = "LOCATION",
    this.weightage = 0,
    this.showInCompactView = false,
  });

  factory _$DestinationImpl.fromJson(Map<String, dynamic> json) =>
      _$$DestinationImplFromJson(json);

  @override
  final String title;
  @override
  final Location? location;
  @override
  final LocationResponse? locationResponse;
  @override
  final String? iconUrl;
  @override
  final GoogleSearchResponse? googleSearchResponse;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final int weightage;
  @override
  @JsonKey()
  final bool showInCompactView;

  @override
  String toString() {
    return 'Destination(title: $title, location: $location, locationResponse: $locationResponse, iconUrl: $iconUrl, googleSearchResponse: $googleSearchResponse, filterType: $filterType, weightage: $weightage, showInCompactView: $showInCompactView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DestinationImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.locationResponse, locationResponse) ||
                other.locationResponse == locationResponse) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.googleSearchResponse, googleSearchResponse) ||
                other.googleSearchResponse == googleSearchResponse) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    location,
    locationResponse,
    iconUrl,
    googleSearchResponse,
    filterType,
    weightage,
    showInCompactView,
  );

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DestinationImplCopyWith<_$DestinationImpl> get copyWith =>
      __$$DestinationImplCopyWithImpl<_$DestinationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DestinationImplToJson(this);
  }
}

abstract class _Destination implements Destination {
  const factory _Destination({
    required final String title,
    final Location? location,
    final LocationResponse? locationResponse,
    final String? iconUrl,
    final GoogleSearchResponse? googleSearchResponse,
    final String filterType,
    final int weightage,
    final bool showInCompactView,
  }) = _$DestinationImpl;

  factory _Destination.fromJson(Map<String, dynamic> json) =
      _$DestinationImpl.fromJson;

  @override
  String get title;
  @override
  Location? get location;
  @override
  LocationResponse? get locationResponse;
  @override
  String? get iconUrl;
  @override
  GoogleSearchResponse? get googleSearchResponse;
  @override
  String get filterType;
  @override
  int get weightage;
  @override
  bool get showInCompactView;

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DestinationImplCopyWith<_$DestinationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaidLobby _$PaidLobbyFromJson(Map<String, dynamic> json) {
  return _PaidLobby.fromJson(json);
}

/// @nodoc
mixin _$PaidLobby {
  bool get isPaid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;

  /// Serializes this PaidLobby to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaidLobby
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaidLobbyCopyWith<PaidLobby> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaidLobbyCopyWith<$Res> {
  factory $PaidLobbyCopyWith(PaidLobby value, $Res Function(PaidLobby) then) =
      _$PaidLobbyCopyWithImpl<$Res, PaidLobby>;
  @useResult
  $Res call({
    bool isPaid,
    String title,
    String? iconUrl,
    double value,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class _$PaidLobbyCopyWithImpl<$Res, $Val extends PaidLobby>
    implements $PaidLobbyCopyWith<$Res> {
  _$PaidLobbyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaidLobby
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPaid = null,
    Object? title = null,
    Object? iconUrl = freezed,
    Object? value = null,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _value.copyWith(
            isPaid: null == isPaid
                ? _value.isPaid
                : isPaid // ignore: cast_nullable_to_non_nullable
                      as bool,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as double,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaidLobbyImplCopyWith<$Res>
    implements $PaidLobbyCopyWith<$Res> {
  factory _$$PaidLobbyImplCopyWith(
    _$PaidLobbyImpl value,
    $Res Function(_$PaidLobbyImpl) then,
  ) = __$$PaidLobbyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isPaid,
    String title,
    String? iconUrl,
    double value,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class __$$PaidLobbyImplCopyWithImpl<$Res>
    extends _$PaidLobbyCopyWithImpl<$Res, _$PaidLobbyImpl>
    implements _$$PaidLobbyImplCopyWith<$Res> {
  __$$PaidLobbyImplCopyWithImpl(
    _$PaidLobbyImpl _value,
    $Res Function(_$PaidLobbyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaidLobby
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPaid = null,
    Object? title = null,
    Object? iconUrl = freezed,
    Object? value = null,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _$PaidLobbyImpl(
        isPaid: null == isPaid
            ? _value.isPaid
            : isPaid // ignore: cast_nullable_to_non_nullable
                  as bool,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as double,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PaidLobbyImpl implements _PaidLobby {
  const _$PaidLobbyImpl({
    this.isPaid = false,
    required this.title,
    this.iconUrl,
    this.value = 0,
    this.filterType = "RADIO_BUTTON_WITH_INPUT",
    this.weightage = 0,
    this.showInCompactView = false,
  });

  factory _$PaidLobbyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaidLobbyImplFromJson(json);

  @override
  @JsonKey()
  final bool isPaid;
  @override
  final String title;
  @override
  final String? iconUrl;
  @override
  @JsonKey()
  final double value;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final int weightage;
  @override
  @JsonKey()
  final bool showInCompactView;

  @override
  String toString() {
    return 'PaidLobby(isPaid: $isPaid, title: $title, iconUrl: $iconUrl, value: $value, filterType: $filterType, weightage: $weightage, showInCompactView: $showInCompactView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaidLobbyImpl &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isPaid,
    title,
    iconUrl,
    value,
    filterType,
    weightage,
    showInCompactView,
  );

  /// Create a copy of PaidLobby
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaidLobbyImplCopyWith<_$PaidLobbyImpl> get copyWith =>
      __$$PaidLobbyImplCopyWithImpl<_$PaidLobbyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaidLobbyImplToJson(this);
  }
}

abstract class _PaidLobby implements PaidLobby {
  const factory _PaidLobby({
    final bool isPaid,
    required final String title,
    final String? iconUrl,
    final double value,
    final String filterType,
    final int weightage,
    final bool showInCompactView,
  }) = _$PaidLobbyImpl;

  factory _PaidLobby.fromJson(Map<String, dynamic> json) =
      _$PaidLobbyImpl.fromJson;

  @override
  bool get isPaid;
  @override
  String get title;
  @override
  String? get iconUrl;
  @override
  double get value;
  @override
  String get filterType;
  @override
  int get weightage;
  @override
  bool get showInCompactView;

  /// Create a copy of PaidLobby
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaidLobbyImplCopyWith<_$PaidLobbyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PickUp _$PickUpFromJson(Map<String, dynamic> json) {
  return _PickUp.fromJson(json);
}

/// @nodoc
mixin _$PickUp {
  String get title => throw _privateConstructorUsedError;
  Location? get location => throw _privateConstructorUsedError;
  LocationResponse? get locationResponse => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  GoogleSearchResponse? get googleSearchResponse =>
      throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;

  /// Serializes this PickUp to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PickUp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PickUpCopyWith<PickUp> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickUpCopyWith<$Res> {
  factory $PickUpCopyWith(PickUp value, $Res Function(PickUp) then) =
      _$PickUpCopyWithImpl<$Res, PickUp>;
  @useResult
  $Res call({
    String title,
    Location? location,
    LocationResponse? locationResponse,
    String? iconUrl,
    GoogleSearchResponse? googleSearchResponse,
    String filterType,
    int weightage,
    bool showInCompactView,
  });

  $LocationCopyWith<$Res>? get location;
  $LocationResponseCopyWith<$Res>? get locationResponse;
  $GoogleSearchResponseCopyWith<$Res>? get googleSearchResponse;
}

/// @nodoc
class _$PickUpCopyWithImpl<$Res, $Val extends PickUp>
    implements $PickUpCopyWith<$Res> {
  _$PickUpCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PickUp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? location = freezed,
    Object? locationResponse = freezed,
    Object? iconUrl = freezed,
    Object? googleSearchResponse = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as Location?,
            locationResponse: freezed == locationResponse
                ? _value.locationResponse
                : locationResponse // ignore: cast_nullable_to_non_nullable
                      as LocationResponse?,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            googleSearchResponse: freezed == googleSearchResponse
                ? _value.googleSearchResponse
                : googleSearchResponse // ignore: cast_nullable_to_non_nullable
                      as GoogleSearchResponse?,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of PickUp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of PickUp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationResponseCopyWith<$Res>? get locationResponse {
    if (_value.locationResponse == null) {
      return null;
    }

    return $LocationResponseCopyWith<$Res>(_value.locationResponse!, (value) {
      return _then(_value.copyWith(locationResponse: value) as $Val);
    });
  }

  /// Create a copy of PickUp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoogleSearchResponseCopyWith<$Res>? get googleSearchResponse {
    if (_value.googleSearchResponse == null) {
      return null;
    }

    return $GoogleSearchResponseCopyWith<$Res>(_value.googleSearchResponse!, (
      value,
    ) {
      return _then(_value.copyWith(googleSearchResponse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PickUpImplCopyWith<$Res> implements $PickUpCopyWith<$Res> {
  factory _$$PickUpImplCopyWith(
    _$PickUpImpl value,
    $Res Function(_$PickUpImpl) then,
  ) = __$$PickUpImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    Location? location,
    LocationResponse? locationResponse,
    String? iconUrl,
    GoogleSearchResponse? googleSearchResponse,
    String filterType,
    int weightage,
    bool showInCompactView,
  });

  @override
  $LocationCopyWith<$Res>? get location;
  @override
  $LocationResponseCopyWith<$Res>? get locationResponse;
  @override
  $GoogleSearchResponseCopyWith<$Res>? get googleSearchResponse;
}

/// @nodoc
class __$$PickUpImplCopyWithImpl<$Res>
    extends _$PickUpCopyWithImpl<$Res, _$PickUpImpl>
    implements _$$PickUpImplCopyWith<$Res> {
  __$$PickUpImplCopyWithImpl(
    _$PickUpImpl _value,
    $Res Function(_$PickUpImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PickUp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? location = freezed,
    Object? locationResponse = freezed,
    Object? iconUrl = freezed,
    Object? googleSearchResponse = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _$PickUpImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as Location?,
        locationResponse: freezed == locationResponse
            ? _value.locationResponse
            : locationResponse // ignore: cast_nullable_to_non_nullable
                  as LocationResponse?,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        googleSearchResponse: freezed == googleSearchResponse
            ? _value.googleSearchResponse
            : googleSearchResponse // ignore: cast_nullable_to_non_nullable
                  as GoogleSearchResponse?,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PickUpImpl implements _PickUp {
  const _$PickUpImpl({
    required this.title,
    this.location,
    this.locationResponse,
    this.iconUrl,
    this.googleSearchResponse,
    this.filterType = "LOCATION",
    this.weightage = 0,
    this.showInCompactView = false,
  });

  factory _$PickUpImpl.fromJson(Map<String, dynamic> json) =>
      _$$PickUpImplFromJson(json);

  @override
  final String title;
  @override
  final Location? location;
  @override
  final LocationResponse? locationResponse;
  @override
  final String? iconUrl;
  @override
  final GoogleSearchResponse? googleSearchResponse;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final int weightage;
  @override
  @JsonKey()
  final bool showInCompactView;

  @override
  String toString() {
    return 'PickUp(title: $title, location: $location, locationResponse: $locationResponse, iconUrl: $iconUrl, googleSearchResponse: $googleSearchResponse, filterType: $filterType, weightage: $weightage, showInCompactView: $showInCompactView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickUpImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.locationResponse, locationResponse) ||
                other.locationResponse == locationResponse) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.googleSearchResponse, googleSearchResponse) ||
                other.googleSearchResponse == googleSearchResponse) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    location,
    locationResponse,
    iconUrl,
    googleSearchResponse,
    filterType,
    weightage,
    showInCompactView,
  );

  /// Create a copy of PickUp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PickUpImplCopyWith<_$PickUpImpl> get copyWith =>
      __$$PickUpImplCopyWithImpl<_$PickUpImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PickUpImplToJson(this);
  }
}

abstract class _PickUp implements PickUp {
  const factory _PickUp({
    required final String title,
    final Location? location,
    final LocationResponse? locationResponse,
    final String? iconUrl,
    final GoogleSearchResponse? googleSearchResponse,
    final String filterType,
    final int weightage,
    final bool showInCompactView,
  }) = _$PickUpImpl;

  factory _PickUp.fromJson(Map<String, dynamic> json) = _$PickUpImpl.fromJson;

  @override
  String get title;
  @override
  Location? get location;
  @override
  LocationResponse? get locationResponse;
  @override
  String? get iconUrl;
  @override
  GoogleSearchResponse? get googleSearchResponse;
  @override
  String get filterType;
  @override
  int get weightage;
  @override
  bool get showInCompactView;

  /// Create a copy of PickUp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PickUpImplCopyWith<_$PickUpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemberCount _$MemberCountFromJson(Map<String, dynamic> json) {
  return _MemberCount.fromJson(json);
}

/// @nodoc
mixin _$MemberCount {
  int get value => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;

  /// Serializes this MemberCount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemberCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberCountCopyWith<MemberCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberCountCopyWith<$Res> {
  factory $MemberCountCopyWith(
    MemberCount value,
    $Res Function(MemberCount) then,
  ) = _$MemberCountCopyWithImpl<$Res, MemberCount>;
  @useResult
  $Res call({
    int value,
    String title,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class _$MemberCountCopyWithImpl<$Res, $Val extends MemberCount>
    implements $MemberCountCopyWith<$Res> {
  _$MemberCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemberCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? title = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MemberCountImplCopyWith<$Res>
    implements $MemberCountCopyWith<$Res> {
  factory _$$MemberCountImplCopyWith(
    _$MemberCountImpl value,
    $Res Function(_$MemberCountImpl) then,
  ) = __$$MemberCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int value,
    String title,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class __$$MemberCountImplCopyWithImpl<$Res>
    extends _$MemberCountCopyWithImpl<$Res, _$MemberCountImpl>
    implements _$$MemberCountImplCopyWith<$Res> {
  __$$MemberCountImplCopyWithImpl(
    _$MemberCountImpl _value,
    $Res Function(_$MemberCountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MemberCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? title = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _$MemberCountImpl(
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MemberCountImpl implements _MemberCount {
  const _$MemberCountImpl({
    this.value = 0,
    required this.title,
    this.iconUrl,
    this.filterType = "INPUT",
    this.weightage = 0,
    this.showInCompactView = false,
  });

  factory _$MemberCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberCountImplFromJson(json);

  @override
  @JsonKey()
  final int value;
  @override
  final String title;
  @override
  final String? iconUrl;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final int weightage;
  @override
  @JsonKey()
  final bool showInCompactView;

  @override
  String toString() {
    return 'MemberCount(value: $value, title: $title, iconUrl: $iconUrl, filterType: $filterType, weightage: $weightage, showInCompactView: $showInCompactView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberCountImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    value,
    title,
    iconUrl,
    filterType,
    weightage,
    showInCompactView,
  );

  /// Create a copy of MemberCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberCountImplCopyWith<_$MemberCountImpl> get copyWith =>
      __$$MemberCountImplCopyWithImpl<_$MemberCountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberCountImplToJson(this);
  }
}

abstract class _MemberCount implements MemberCount {
  const factory _MemberCount({
    final int value,
    required final String title,
    final String? iconUrl,
    final String filterType,
    final int weightage,
    final bool showInCompactView,
  }) = _$MemberCountImpl;

  factory _MemberCount.fromJson(Map<String, dynamic> json) =
      _$MemberCountImpl.fromJson;

  @override
  int get value;
  @override
  String get title;
  @override
  String? get iconUrl;
  @override
  String get filterType;
  @override
  int get weightage;
  @override
  bool get showInCompactView;

  /// Create a copy of MemberCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberCountImplCopyWith<_$MemberCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CurrentCount _$CurrentCountFromJson(Map<String, dynamic> json) {
  return _CurrentCount.fromJson(json);
}

/// @nodoc
mixin _$CurrentCount {
  int get value => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;

  /// Serializes this CurrentCount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CurrentCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CurrentCountCopyWith<CurrentCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentCountCopyWith<$Res> {
  factory $CurrentCountCopyWith(
    CurrentCount value,
    $Res Function(CurrentCount) then,
  ) = _$CurrentCountCopyWithImpl<$Res, CurrentCount>;
  @useResult
  $Res call({
    int value,
    String title,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class _$CurrentCountCopyWithImpl<$Res, $Val extends CurrentCount>
    implements $CurrentCountCopyWith<$Res> {
  _$CurrentCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurrentCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? title = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CurrentCountImplCopyWith<$Res>
    implements $CurrentCountCopyWith<$Res> {
  factory _$$CurrentCountImplCopyWith(
    _$CurrentCountImpl value,
    $Res Function(_$CurrentCountImpl) then,
  ) = __$$CurrentCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int value,
    String title,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class __$$CurrentCountImplCopyWithImpl<$Res>
    extends _$CurrentCountCopyWithImpl<$Res, _$CurrentCountImpl>
    implements _$$CurrentCountImplCopyWith<$Res> {
  __$$CurrentCountImplCopyWithImpl(
    _$CurrentCountImpl _value,
    $Res Function(_$CurrentCountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CurrentCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? title = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _$CurrentCountImpl(
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentCountImpl implements _CurrentCount {
  const _$CurrentCountImpl({
    this.value = 0,
    this.title = 'Current count',
    this.iconUrl,
    this.filterType = "INPUT",
    this.weightage = 0,
    this.showInCompactView = false,
  });

  factory _$CurrentCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentCountImplFromJson(json);

  @override
  @JsonKey()
  final int value;
  @override
  @JsonKey()
  final String title;
  @override
  final String? iconUrl;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final int weightage;
  @override
  @JsonKey()
  final bool showInCompactView;

  @override
  String toString() {
    return 'CurrentCount(value: $value, title: $title, iconUrl: $iconUrl, filterType: $filterType, weightage: $weightage, showInCompactView: $showInCompactView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentCountImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    value,
    title,
    iconUrl,
    filterType,
    weightage,
    showInCompactView,
  );

  /// Create a copy of CurrentCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentCountImplCopyWith<_$CurrentCountImpl> get copyWith =>
      __$$CurrentCountImplCopyWithImpl<_$CurrentCountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentCountImplToJson(this);
  }
}

abstract class _CurrentCount implements CurrentCount {
  const factory _CurrentCount({
    final int value,
    final String title,
    final String? iconUrl,
    final String filterType,
    final int weightage,
    final bool showInCompactView,
  }) = _$CurrentCountImpl;

  factory _CurrentCount.fromJson(Map<String, dynamic> json) =
      _$CurrentCountImpl.fromJson;

  @override
  int get value;
  @override
  String get title;
  @override
  String? get iconUrl;
  @override
  String get filterType;
  @override
  int get weightage;
  @override
  bool get showInCompactView;

  /// Create a copy of CurrentCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CurrentCountImplCopyWith<_$CurrentCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Range _$RangeFromJson(Map<String, dynamic> json) {
  return _Range.fromJson(json);
}

/// @nodoc
mixin _$Range {
  int get min => throw _privateConstructorUsedError;
  int get max => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;

  /// Serializes this Range to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Range
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RangeCopyWith<Range> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RangeCopyWith<$Res> {
  factory $RangeCopyWith(Range value, $Res Function(Range) then) =
      _$RangeCopyWithImpl<$Res, Range>;
  @useResult
  $Res call({
    int min,
    int max,
    String title,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class _$RangeCopyWithImpl<$Res, $Val extends Range>
    implements $RangeCopyWith<$Res> {
  _$RangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Range
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
    Object? title = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _value.copyWith(
            min: null == min
                ? _value.min
                : min // ignore: cast_nullable_to_non_nullable
                      as int,
            max: null == max
                ? _value.max
                : max // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RangeImplCopyWith<$Res> implements $RangeCopyWith<$Res> {
  factory _$$RangeImplCopyWith(
    _$RangeImpl value,
    $Res Function(_$RangeImpl) then,
  ) = __$$RangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int min,
    int max,
    String title,
    String? iconUrl,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class __$$RangeImplCopyWithImpl<$Res>
    extends _$RangeCopyWithImpl<$Res, _$RangeImpl>
    implements _$$RangeImplCopyWith<$Res> {
  __$$RangeImplCopyWithImpl(
    _$RangeImpl _value,
    $Res Function(_$RangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Range
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
    Object? title = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _$RangeImpl(
        min: null == min
            ? _value.min
            : min // ignore: cast_nullable_to_non_nullable
                  as int,
        max: null == max
            ? _value.max
            : max // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$RangeImpl implements _Range {
  const _$RangeImpl({
    this.min = 0,
    this.max = 0,
    required this.title,
    this.iconUrl,
    this.filterType = "SLIDER",
    this.weightage = 0,
    this.showInCompactView = false,
  });

  factory _$RangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RangeImplFromJson(json);

  @override
  @JsonKey()
  final int min;
  @override
  @JsonKey()
  final int max;
  @override
  final String title;
  @override
  final String? iconUrl;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final int weightage;
  @override
  @JsonKey()
  final bool showInCompactView;

  @override
  String toString() {
    return 'Range(min: $min, max: $max, title: $title, iconUrl: $iconUrl, filterType: $filterType, weightage: $weightage, showInCompactView: $showInCompactView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RangeImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    min,
    max,
    title,
    iconUrl,
    filterType,
    weightage,
    showInCompactView,
  );

  /// Create a copy of Range
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RangeImplCopyWith<_$RangeImpl> get copyWith =>
      __$$RangeImplCopyWithImpl<_$RangeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RangeImplToJson(this);
  }
}

abstract class _Range implements Range {
  const factory _Range({
    final int min,
    final int max,
    required final String title,
    final String? iconUrl,
    final String filterType,
    final int weightage,
    final bool showInCompactView,
  }) = _$RangeImpl;

  factory _Range.fromJson(Map<String, dynamic> json) = _$RangeImpl.fromJson;

  @override
  int get min;
  @override
  int get max;
  @override
  String get title;
  @override
  String? get iconUrl;
  @override
  String get filterType;
  @override
  int get weightage;
  @override
  bool get showInCompactView;

  /// Create a copy of Range
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RangeImplCopyWith<_$RangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Info _$InfoFromJson(Map<String, dynamic> json) {
  return _Info.fromJson(json);
}

/// @nodoc
mixin _$Info {
  double get value => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;

  /// Serializes this Info to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Info
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InfoCopyWith<Info> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoCopyWith<$Res> {
  factory $InfoCopyWith(Info value, $Res Function(Info) then) =
      _$InfoCopyWithImpl<$Res, Info>;
  @useResult
  $Res call({
    double value,
    String? iconUrl,
    String title,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class _$InfoCopyWithImpl<$Res, $Val extends Info>
    implements $InfoCopyWith<$Res> {
  _$InfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Info
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? iconUrl = freezed,
    Object? title = null,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as double,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InfoImplCopyWith<$Res> implements $InfoCopyWith<$Res> {
  factory _$$InfoImplCopyWith(
    _$InfoImpl value,
    $Res Function(_$InfoImpl) then,
  ) = __$$InfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double value,
    String? iconUrl,
    String title,
    String filterType,
    int weightage,
    bool showInCompactView,
  });
}

/// @nodoc
class __$$InfoImplCopyWithImpl<$Res>
    extends _$InfoCopyWithImpl<$Res, _$InfoImpl>
    implements _$$InfoImplCopyWith<$Res> {
  __$$InfoImplCopyWithImpl(_$InfoImpl _value, $Res Function(_$InfoImpl) _then)
    : super(_value, _then);

  /// Create a copy of Info
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? iconUrl = freezed,
    Object? title = null,
    Object? filterType = null,
    Object? weightage = null,
    Object? showInCompactView = null,
  }) {
    return _then(
      _$InfoImpl(
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as double,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$InfoImpl implements _Info {
  const _$InfoImpl({
    this.value = 0,
    this.iconUrl,
    required this.title,
    this.filterType = "INPUT",
    this.weightage = 0,
    this.showInCompactView = false,
  });

  factory _$InfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$InfoImplFromJson(json);

  @override
  @JsonKey()
  final double value;
  @override
  final String? iconUrl;
  @override
  final String title;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final int weightage;
  @override
  @JsonKey()
  final bool showInCompactView;

  @override
  String toString() {
    return 'Info(value: $value, iconUrl: $iconUrl, title: $title, filterType: $filterType, weightage: $weightage, showInCompactView: $showInCompactView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfoImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    value,
    iconUrl,
    title,
    filterType,
    weightage,
    showInCompactView,
  );

  /// Create a copy of Info
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InfoImplCopyWith<_$InfoImpl> get copyWith =>
      __$$InfoImplCopyWithImpl<_$InfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InfoImplToJson(this);
  }
}

abstract class _Info implements Info {
  const factory _Info({
    final double value,
    final String? iconUrl,
    required final String title,
    final String filterType,
    final int weightage,
    final bool showInCompactView,
  }) = _$InfoImpl;

  factory _Info.fromJson(Map<String, dynamic> json) = _$InfoImpl.fromJson;

  @override
  double get value;
  @override
  String? get iconUrl;
  @override
  String get title;
  @override
  String get filterType;
  @override
  int get weightage;
  @override
  bool get showInCompactView;

  /// Create a copy of Info
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InfoImplCopyWith<_$InfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationInfo _$LocationInfoFromJson(Map<String, dynamic> json) {
  return _LocationInfo.fromJson(json);
}

/// @nodoc
mixin _$LocationInfo {
  String? get title => throw _privateConstructorUsedError;
  List<LocationResponse> get locationResponses =>
      throw _privateConstructorUsedError;
  int get weightage => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String get filterType => throw _privateConstructorUsedError;
  bool get showInCompactView => throw _privateConstructorUsedError;
  bool get hideLocation => throw _privateConstructorUsedError;
  List<GoogleSearchResponse> get googleSearchResponses =>
      throw _privateConstructorUsedError;

  /// Serializes this LocationInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationInfoCopyWith<LocationInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationInfoCopyWith<$Res> {
  factory $LocationInfoCopyWith(
    LocationInfo value,
    $Res Function(LocationInfo) then,
  ) = _$LocationInfoCopyWithImpl<$Res, LocationInfo>;
  @useResult
  $Res call({
    String? title,
    List<LocationResponse> locationResponses,
    int weightage,
    String? iconUrl,
    String filterType,
    bool showInCompactView,
    bool hideLocation,
    List<GoogleSearchResponse> googleSearchResponses,
  });
}

/// @nodoc
class _$LocationInfoCopyWithImpl<$Res, $Val extends LocationInfo>
    implements $LocationInfoCopyWith<$Res> {
  _$LocationInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? locationResponses = null,
    Object? weightage = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? showInCompactView = null,
    Object? hideLocation = null,
    Object? googleSearchResponses = null,
  }) {
    return _then(
      _value.copyWith(
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            locationResponses: null == locationResponses
                ? _value.locationResponses
                : locationResponses // ignore: cast_nullable_to_non_nullable
                      as List<LocationResponse>,
            weightage: null == weightage
                ? _value.weightage
                : weightage // ignore: cast_nullable_to_non_nullable
                      as int,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            filterType: null == filterType
                ? _value.filterType
                : filterType // ignore: cast_nullable_to_non_nullable
                      as String,
            showInCompactView: null == showInCompactView
                ? _value.showInCompactView
                : showInCompactView // ignore: cast_nullable_to_non_nullable
                      as bool,
            hideLocation: null == hideLocation
                ? _value.hideLocation
                : hideLocation // ignore: cast_nullable_to_non_nullable
                      as bool,
            googleSearchResponses: null == googleSearchResponses
                ? _value.googleSearchResponses
                : googleSearchResponses // ignore: cast_nullable_to_non_nullable
                      as List<GoogleSearchResponse>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationInfoImplCopyWith<$Res>
    implements $LocationInfoCopyWith<$Res> {
  factory _$$LocationInfoImplCopyWith(
    _$LocationInfoImpl value,
    $Res Function(_$LocationInfoImpl) then,
  ) = __$$LocationInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? title,
    List<LocationResponse> locationResponses,
    int weightage,
    String? iconUrl,
    String filterType,
    bool showInCompactView,
    bool hideLocation,
    List<GoogleSearchResponse> googleSearchResponses,
  });
}

/// @nodoc
class __$$LocationInfoImplCopyWithImpl<$Res>
    extends _$LocationInfoCopyWithImpl<$Res, _$LocationInfoImpl>
    implements _$$LocationInfoImplCopyWith<$Res> {
  __$$LocationInfoImplCopyWithImpl(
    _$LocationInfoImpl _value,
    $Res Function(_$LocationInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? locationResponses = null,
    Object? weightage = null,
    Object? iconUrl = freezed,
    Object? filterType = null,
    Object? showInCompactView = null,
    Object? hideLocation = null,
    Object? googleSearchResponses = null,
  }) {
    return _then(
      _$LocationInfoImpl(
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        locationResponses: null == locationResponses
            ? _value._locationResponses
            : locationResponses // ignore: cast_nullable_to_non_nullable
                  as List<LocationResponse>,
        weightage: null == weightage
            ? _value.weightage
            : weightage // ignore: cast_nullable_to_non_nullable
                  as int,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        filterType: null == filterType
            ? _value.filterType
            : filterType // ignore: cast_nullable_to_non_nullable
                  as String,
        showInCompactView: null == showInCompactView
            ? _value.showInCompactView
            : showInCompactView // ignore: cast_nullable_to_non_nullable
                  as bool,
        hideLocation: null == hideLocation
            ? _value.hideLocation
            : hideLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
        googleSearchResponses: null == googleSearchResponses
            ? _value._googleSearchResponses
            : googleSearchResponses // ignore: cast_nullable_to_non_nullable
                  as List<GoogleSearchResponse>,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LocationInfoImpl implements _LocationInfo {
  const _$LocationInfoImpl({
    this.title,
    final List<LocationResponse> locationResponses = const [],
    this.weightage = 0,
    this.iconUrl,
    this.filterType = "LOCATION",
    this.showInCompactView = true,
    this.hideLocation = false,
    final List<GoogleSearchResponse> googleSearchResponses = const [],
  }) : _locationResponses = locationResponses,
       _googleSearchResponses = googleSearchResponses;

  factory _$LocationInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationInfoImplFromJson(json);

  @override
  final String? title;
  final List<LocationResponse> _locationResponses;
  @override
  @JsonKey()
  List<LocationResponse> get locationResponses {
    if (_locationResponses is EqualUnmodifiableListView)
      return _locationResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locationResponses);
  }

  @override
  @JsonKey()
  final int weightage;
  @override
  final String? iconUrl;
  @override
  @JsonKey()
  final String filterType;
  @override
  @JsonKey()
  final bool showInCompactView;
  @override
  @JsonKey()
  final bool hideLocation;
  final List<GoogleSearchResponse> _googleSearchResponses;
  @override
  @JsonKey()
  List<GoogleSearchResponse> get googleSearchResponses {
    if (_googleSearchResponses is EqualUnmodifiableListView)
      return _googleSearchResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_googleSearchResponses);
  }

  @override
  String toString() {
    return 'LocationInfo(title: $title, locationResponses: $locationResponses, weightage: $weightage, iconUrl: $iconUrl, filterType: $filterType, showInCompactView: $showInCompactView, hideLocation: $hideLocation, googleSearchResponses: $googleSearchResponses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationInfoImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(
              other._locationResponses,
              _locationResponses,
            ) &&
            (identical(other.weightage, weightage) ||
                other.weightage == weightage) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.showInCompactView, showInCompactView) ||
                other.showInCompactView == showInCompactView) &&
            (identical(other.hideLocation, hideLocation) ||
                other.hideLocation == hideLocation) &&
            const DeepCollectionEquality().equals(
              other._googleSearchResponses,
              _googleSearchResponses,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    const DeepCollectionEquality().hash(_locationResponses),
    weightage,
    iconUrl,
    filterType,
    showInCompactView,
    hideLocation,
    const DeepCollectionEquality().hash(_googleSearchResponses),
  );

  /// Create a copy of LocationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationInfoImplCopyWith<_$LocationInfoImpl> get copyWith =>
      __$$LocationInfoImplCopyWithImpl<_$LocationInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationInfoImplToJson(this);
  }
}

abstract class _LocationInfo implements LocationInfo {
  const factory _LocationInfo({
    final String? title,
    final List<LocationResponse> locationResponses,
    final int weightage,
    final String? iconUrl,
    final String filterType,
    final bool showInCompactView,
    final bool hideLocation,
    final List<GoogleSearchResponse> googleSearchResponses,
  }) = _$LocationInfoImpl;

  factory _LocationInfo.fromJson(Map<String, dynamic> json) =
      _$LocationInfoImpl.fromJson;

  @override
  String? get title;
  @override
  List<LocationResponse> get locationResponses;
  @override
  int get weightage;
  @override
  String? get iconUrl;
  @override
  String get filterType;
  @override
  bool get showInCompactView;
  @override
  bool get hideLocation;
  @override
  List<GoogleSearchResponse> get googleSearchResponses;

  /// Create a copy of LocationInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationInfoImplCopyWith<_$LocationInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  double? get lat => throw _privateConstructorUsedError;
  double? get lon => throw _privateConstructorUsedError;

  /// Serializes this Location to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res, Location>;
  @useResult
  $Res call({double? lat, double? lon});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = freezed, Object? lon = freezed}) {
    return _then(
      _value.copyWith(
            lat: freezed == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double?,
            lon: freezed == lon
                ? _value.lon
                : lon // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationImplCopyWith<$Res>
    implements $LocationCopyWith<$Res> {
  factory _$$LocationImplCopyWith(
    _$LocationImpl value,
    $Res Function(_$LocationImpl) then,
  ) = __$$LocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? lat, double? lon});
}

/// @nodoc
class __$$LocationImplCopyWithImpl<$Res>
    extends _$LocationCopyWithImpl<$Res, _$LocationImpl>
    implements _$$LocationImplCopyWith<$Res> {
  __$$LocationImplCopyWithImpl(
    _$LocationImpl _value,
    $Res Function(_$LocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = freezed, Object? lon = freezed}) {
    return _then(
      _$LocationImpl(
        lat: freezed == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double?,
        lon: freezed == lon
            ? _value.lon
            : lon // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LocationImpl implements _Location {
  const _$LocationImpl({this.lat = 0.0, this.lon = 0.0});

  factory _$LocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationImplFromJson(json);

  @override
  @JsonKey()
  final double? lat;
  @override
  @JsonKey()
  final double? lon;

  @override
  String toString() {
    return 'Location(lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lon);

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      __$$LocationImplCopyWithImpl<_$LocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationImplToJson(this);
  }
}

abstract class _Location implements Location {
  const factory _Location({final double? lat, final double? lon}) =
      _$LocationImpl;

  factory _Location.fromJson(Map<String, dynamic> json) =
      _$LocationImpl.fromJson;

  @override
  double? get lat;
  @override
  double? get lon;

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) {
  return _LocationResponse.fromJson(json);
}

/// @nodoc
mixin _$LocationResponse {
  Location get exactLocation => throw _privateConstructorUsedError;
  Location get approxLocation => throw _privateConstructorUsedError;
  String get areaName => throw _privateConstructorUsedError;
  String get fuzzyAddress => throw _privateConstructorUsedError;

  /// Serializes this LocationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationResponseCopyWith<LocationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationResponseCopyWith<$Res> {
  factory $LocationResponseCopyWith(
    LocationResponse value,
    $Res Function(LocationResponse) then,
  ) = _$LocationResponseCopyWithImpl<$Res, LocationResponse>;
  @useResult
  $Res call({
    Location exactLocation,
    Location approxLocation,
    String areaName,
    String fuzzyAddress,
  });

  $LocationCopyWith<$Res> get exactLocation;
  $LocationCopyWith<$Res> get approxLocation;
}

/// @nodoc
class _$LocationResponseCopyWithImpl<$Res, $Val extends LocationResponse>
    implements $LocationResponseCopyWith<$Res> {
  _$LocationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exactLocation = null,
    Object? approxLocation = null,
    Object? areaName = null,
    Object? fuzzyAddress = null,
  }) {
    return _then(
      _value.copyWith(
            exactLocation: null == exactLocation
                ? _value.exactLocation
                : exactLocation // ignore: cast_nullable_to_non_nullable
                      as Location,
            approxLocation: null == approxLocation
                ? _value.approxLocation
                : approxLocation // ignore: cast_nullable_to_non_nullable
                      as Location,
            areaName: null == areaName
                ? _value.areaName
                : areaName // ignore: cast_nullable_to_non_nullable
                      as String,
            fuzzyAddress: null == fuzzyAddress
                ? _value.fuzzyAddress
                : fuzzyAddress // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of LocationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get exactLocation {
    return $LocationCopyWith<$Res>(_value.exactLocation, (value) {
      return _then(_value.copyWith(exactLocation: value) as $Val);
    });
  }

  /// Create a copy of LocationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get approxLocation {
    return $LocationCopyWith<$Res>(_value.approxLocation, (value) {
      return _then(_value.copyWith(approxLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LocationResponseImplCopyWith<$Res>
    implements $LocationResponseCopyWith<$Res> {
  factory _$$LocationResponseImplCopyWith(
    _$LocationResponseImpl value,
    $Res Function(_$LocationResponseImpl) then,
  ) = __$$LocationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Location exactLocation,
    Location approxLocation,
    String areaName,
    String fuzzyAddress,
  });

  @override
  $LocationCopyWith<$Res> get exactLocation;
  @override
  $LocationCopyWith<$Res> get approxLocation;
}

/// @nodoc
class __$$LocationResponseImplCopyWithImpl<$Res>
    extends _$LocationResponseCopyWithImpl<$Res, _$LocationResponseImpl>
    implements _$$LocationResponseImplCopyWith<$Res> {
  __$$LocationResponseImplCopyWithImpl(
    _$LocationResponseImpl _value,
    $Res Function(_$LocationResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exactLocation = null,
    Object? approxLocation = null,
    Object? areaName = null,
    Object? fuzzyAddress = null,
  }) {
    return _then(
      _$LocationResponseImpl(
        exactLocation: null == exactLocation
            ? _value.exactLocation
            : exactLocation // ignore: cast_nullable_to_non_nullable
                  as Location,
        approxLocation: null == approxLocation
            ? _value.approxLocation
            : approxLocation // ignore: cast_nullable_to_non_nullable
                  as Location,
        areaName: null == areaName
            ? _value.areaName
            : areaName // ignore: cast_nullable_to_non_nullable
                  as String,
        fuzzyAddress: null == fuzzyAddress
            ? _value.fuzzyAddress
            : fuzzyAddress // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LocationResponseImpl implements _LocationResponse {
  const _$LocationResponseImpl({
    this.exactLocation = const Location(),
    this.approxLocation = const Location(),
    this.areaName = '',
    this.fuzzyAddress = '',
  });

  factory _$LocationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationResponseImplFromJson(json);

  @override
  @JsonKey()
  final Location exactLocation;
  @override
  @JsonKey()
  final Location approxLocation;
  @override
  @JsonKey()
  final String areaName;
  @override
  @JsonKey()
  final String fuzzyAddress;

  @override
  String toString() {
    return 'LocationResponse(exactLocation: $exactLocation, approxLocation: $approxLocation, areaName: $areaName, fuzzyAddress: $fuzzyAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationResponseImpl &&
            (identical(other.exactLocation, exactLocation) ||
                other.exactLocation == exactLocation) &&
            (identical(other.approxLocation, approxLocation) ||
                other.approxLocation == approxLocation) &&
            (identical(other.areaName, areaName) ||
                other.areaName == areaName) &&
            (identical(other.fuzzyAddress, fuzzyAddress) ||
                other.fuzzyAddress == fuzzyAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    exactLocation,
    approxLocation,
    areaName,
    fuzzyAddress,
  );

  /// Create a copy of LocationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationResponseImplCopyWith<_$LocationResponseImpl> get copyWith =>
      __$$LocationResponseImplCopyWithImpl<_$LocationResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationResponseImplToJson(this);
  }
}

abstract class _LocationResponse implements LocationResponse {
  const factory _LocationResponse({
    final Location exactLocation,
    final Location approxLocation,
    final String areaName,
    final String fuzzyAddress,
  }) = _$LocationResponseImpl;

  factory _LocationResponse.fromJson(Map<String, dynamic> json) =
      _$LocationResponseImpl.fromJson;

  @override
  Location get exactLocation;
  @override
  Location get approxLocation;
  @override
  String get areaName;
  @override
  String get fuzzyAddress;

  /// Create a copy of LocationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationResponseImplCopyWith<_$LocationResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Position _$PositionFromJson(Map<String, dynamic> json) {
  return _Position.fromJson(json);
}

/// @nodoc
mixin _$Position {
  int get row => throw _privateConstructorUsedError;
  int get column => throw _privateConstructorUsedError;

  /// Serializes this Position to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PositionCopyWith<Position> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PositionCopyWith<$Res> {
  factory $PositionCopyWith(Position value, $Res Function(Position) then) =
      _$PositionCopyWithImpl<$Res, Position>;
  @useResult
  $Res call({int row, int column});
}

/// @nodoc
class _$PositionCopyWithImpl<$Res, $Val extends Position>
    implements $PositionCopyWith<$Res> {
  _$PositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? row = null, Object? column = null}) {
    return _then(
      _value.copyWith(
            row: null == row
                ? _value.row
                : row // ignore: cast_nullable_to_non_nullable
                      as int,
            column: null == column
                ? _value.column
                : column // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PositionImplCopyWith<$Res>
    implements $PositionCopyWith<$Res> {
  factory _$$PositionImplCopyWith(
    _$PositionImpl value,
    $Res Function(_$PositionImpl) then,
  ) = __$$PositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int row, int column});
}

/// @nodoc
class __$$PositionImplCopyWithImpl<$Res>
    extends _$PositionCopyWithImpl<$Res, _$PositionImpl>
    implements _$$PositionImplCopyWith<$Res> {
  __$$PositionImplCopyWithImpl(
    _$PositionImpl _value,
    $Res Function(_$PositionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? row = null, Object? column = null}) {
    return _then(
      _$PositionImpl(
        row: null == row
            ? _value.row
            : row // ignore: cast_nullable_to_non_nullable
                  as int,
        column: null == column
            ? _value.column
            : column // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PositionImpl implements _Position {
  const _$PositionImpl({required this.row, required this.column});

  factory _$PositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PositionImplFromJson(json);

  @override
  final int row;
  @override
  final int column;

  @override
  String toString() {
    return 'Position(row: $row, column: $column)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PositionImpl &&
            (identical(other.row, row) || other.row == row) &&
            (identical(other.column, column) || other.column == column));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, row, column);

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PositionImplCopyWith<_$PositionImpl> get copyWith =>
      __$$PositionImplCopyWithImpl<_$PositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PositionImplToJson(this);
  }
}

abstract class _Position implements Position {
  const factory _Position({required final int row, required final int column}) =
      _$PositionImpl;

  factory _Position.fromJson(Map<String, dynamic> json) =
      _$PositionImpl.fromJson;

  @override
  int get row;
  @override
  int get column;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PositionImplCopyWith<_$PositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GoogleSearchResponse _$GoogleSearchResponseFromJson(Map<String, dynamic> json) {
  return _GoogleSearchResponse.fromJson(json);
}

/// @nodoc
mixin _$GoogleSearchResponse {
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'place_id')
  String? get placeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'structured_formatting')
  StructuredFormatting? get structuredFormatting =>
      throw _privateConstructorUsedError;

  /// Serializes this GoogleSearchResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoogleSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoogleSearchResponseCopyWith<GoogleSearchResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleSearchResponseCopyWith<$Res> {
  factory $GoogleSearchResponseCopyWith(
    GoogleSearchResponse value,
    $Res Function(GoogleSearchResponse) then,
  ) = _$GoogleSearchResponseCopyWithImpl<$Res, GoogleSearchResponse>;
  @useResult
  $Res call({
    String? description,
    @JsonKey(name: 'place_id') String? placeId,
    @JsonKey(name: 'structured_formatting')
    StructuredFormatting? structuredFormatting,
  });

  $StructuredFormattingCopyWith<$Res>? get structuredFormatting;
}

/// @nodoc
class _$GoogleSearchResponseCopyWithImpl<
  $Res,
  $Val extends GoogleSearchResponse
>
    implements $GoogleSearchResponseCopyWith<$Res> {
  _$GoogleSearchResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoogleSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? placeId = freezed,
    Object? structuredFormatting = freezed,
  }) {
    return _then(
      _value.copyWith(
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            placeId: freezed == placeId
                ? _value.placeId
                : placeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            structuredFormatting: freezed == structuredFormatting
                ? _value.structuredFormatting
                : structuredFormatting // ignore: cast_nullable_to_non_nullable
                      as StructuredFormatting?,
          )
          as $Val,
    );
  }

  /// Create a copy of GoogleSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StructuredFormattingCopyWith<$Res>? get structuredFormatting {
    if (_value.structuredFormatting == null) {
      return null;
    }

    return $StructuredFormattingCopyWith<$Res>(_value.structuredFormatting!, (
      value,
    ) {
      return _then(_value.copyWith(structuredFormatting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GoogleSearchResponseImplCopyWith<$Res>
    implements $GoogleSearchResponseCopyWith<$Res> {
  factory _$$GoogleSearchResponseImplCopyWith(
    _$GoogleSearchResponseImpl value,
    $Res Function(_$GoogleSearchResponseImpl) then,
  ) = __$$GoogleSearchResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? description,
    @JsonKey(name: 'place_id') String? placeId,
    @JsonKey(name: 'structured_formatting')
    StructuredFormatting? structuredFormatting,
  });

  @override
  $StructuredFormattingCopyWith<$Res>? get structuredFormatting;
}

/// @nodoc
class __$$GoogleSearchResponseImplCopyWithImpl<$Res>
    extends _$GoogleSearchResponseCopyWithImpl<$Res, _$GoogleSearchResponseImpl>
    implements _$$GoogleSearchResponseImplCopyWith<$Res> {
  __$$GoogleSearchResponseImplCopyWithImpl(
    _$GoogleSearchResponseImpl _value,
    $Res Function(_$GoogleSearchResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoogleSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? placeId = freezed,
    Object? structuredFormatting = freezed,
  }) {
    return _then(
      _$GoogleSearchResponseImpl(
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        placeId: freezed == placeId
            ? _value.placeId
            : placeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        structuredFormatting: freezed == structuredFormatting
            ? _value.structuredFormatting
            : structuredFormatting // ignore: cast_nullable_to_non_nullable
                  as StructuredFormatting?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$GoogleSearchResponseImpl implements _GoogleSearchResponse {
  const _$GoogleSearchResponseImpl({
    required this.description,
    @JsonKey(name: 'place_id') required this.placeId,
    @JsonKey(name: 'structured_formatting') required this.structuredFormatting,
  });

  factory _$GoogleSearchResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoogleSearchResponseImplFromJson(json);

  @override
  final String? description;
  @override
  @JsonKey(name: 'place_id')
  final String? placeId;
  @override
  @JsonKey(name: 'structured_formatting')
  final StructuredFormatting? structuredFormatting;

  @override
  String toString() {
    return 'GoogleSearchResponse(description: $description, placeId: $placeId, structuredFormatting: $structuredFormatting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoogleSearchResponseImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.structuredFormatting, structuredFormatting) ||
                other.structuredFormatting == structuredFormatting));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, description, placeId, structuredFormatting);

  /// Create a copy of GoogleSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoogleSearchResponseImplCopyWith<_$GoogleSearchResponseImpl>
  get copyWith =>
      __$$GoogleSearchResponseImplCopyWithImpl<_$GoogleSearchResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GoogleSearchResponseImplToJson(this);
  }
}

abstract class _GoogleSearchResponse implements GoogleSearchResponse {
  const factory _GoogleSearchResponse({
    required final String? description,
    @JsonKey(name: 'place_id') required final String? placeId,
    @JsonKey(name: 'structured_formatting')
    required final StructuredFormatting? structuredFormatting,
  }) = _$GoogleSearchResponseImpl;

  factory _GoogleSearchResponse.fromJson(Map<String, dynamic> json) =
      _$GoogleSearchResponseImpl.fromJson;

  @override
  String? get description;
  @override
  @JsonKey(name: 'place_id')
  String? get placeId;
  @override
  @JsonKey(name: 'structured_formatting')
  StructuredFormatting? get structuredFormatting;

  /// Create a copy of GoogleSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoogleSearchResponseImplCopyWith<_$GoogleSearchResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StructuredFormatting _$StructuredFormattingFromJson(Map<String, dynamic> json) {
  return _StructuredFormatting.fromJson(json);
}

/// @nodoc
mixin _$StructuredFormatting {
  @JsonKey(name: 'main_text')
  String? get mainText => throw _privateConstructorUsedError;
  @JsonKey(name: 'secondary_text')
  String? get secondaryText => throw _privateConstructorUsedError;

  /// Serializes this StructuredFormatting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StructuredFormatting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StructuredFormattingCopyWith<StructuredFormatting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StructuredFormattingCopyWith<$Res> {
  factory $StructuredFormattingCopyWith(
    StructuredFormatting value,
    $Res Function(StructuredFormatting) then,
  ) = _$StructuredFormattingCopyWithImpl<$Res, StructuredFormatting>;
  @useResult
  $Res call({
    @JsonKey(name: 'main_text') String? mainText,
    @JsonKey(name: 'secondary_text') String? secondaryText,
  });
}

/// @nodoc
class _$StructuredFormattingCopyWithImpl<
  $Res,
  $Val extends StructuredFormatting
>
    implements $StructuredFormattingCopyWith<$Res> {
  _$StructuredFormattingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StructuredFormatting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mainText = freezed, Object? secondaryText = freezed}) {
    return _then(
      _value.copyWith(
            mainText: freezed == mainText
                ? _value.mainText
                : mainText // ignore: cast_nullable_to_non_nullable
                      as String?,
            secondaryText: freezed == secondaryText
                ? _value.secondaryText
                : secondaryText // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StructuredFormattingImplCopyWith<$Res>
    implements $StructuredFormattingCopyWith<$Res> {
  factory _$$StructuredFormattingImplCopyWith(
    _$StructuredFormattingImpl value,
    $Res Function(_$StructuredFormattingImpl) then,
  ) = __$$StructuredFormattingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'main_text') String? mainText,
    @JsonKey(name: 'secondary_text') String? secondaryText,
  });
}

/// @nodoc
class __$$StructuredFormattingImplCopyWithImpl<$Res>
    extends _$StructuredFormattingCopyWithImpl<$Res, _$StructuredFormattingImpl>
    implements _$$StructuredFormattingImplCopyWith<$Res> {
  __$$StructuredFormattingImplCopyWithImpl(
    _$StructuredFormattingImpl _value,
    $Res Function(_$StructuredFormattingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StructuredFormatting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mainText = freezed, Object? secondaryText = freezed}) {
    return _then(
      _$StructuredFormattingImpl(
        mainText: freezed == mainText
            ? _value.mainText
            : mainText // ignore: cast_nullable_to_non_nullable
                  as String?,
        secondaryText: freezed == secondaryText
            ? _value.secondaryText
            : secondaryText // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$StructuredFormattingImpl implements _StructuredFormatting {
  const _$StructuredFormattingImpl({
    @JsonKey(name: 'main_text') this.mainText,
    @JsonKey(name: 'secondary_text') this.secondaryText,
  });

  factory _$StructuredFormattingImpl.fromJson(Map<String, dynamic> json) =>
      _$$StructuredFormattingImplFromJson(json);

  @override
  @JsonKey(name: 'main_text')
  final String? mainText;
  @override
  @JsonKey(name: 'secondary_text')
  final String? secondaryText;

  @override
  String toString() {
    return 'StructuredFormatting(mainText: $mainText, secondaryText: $secondaryText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StructuredFormattingImpl &&
            (identical(other.mainText, mainText) ||
                other.mainText == mainText) &&
            (identical(other.secondaryText, secondaryText) ||
                other.secondaryText == secondaryText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mainText, secondaryText);

  /// Create a copy of StructuredFormatting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StructuredFormattingImplCopyWith<_$StructuredFormattingImpl>
  get copyWith =>
      __$$StructuredFormattingImplCopyWithImpl<_$StructuredFormattingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StructuredFormattingImplToJson(this);
  }
}

abstract class _StructuredFormatting implements StructuredFormatting {
  const factory _StructuredFormatting({
    @JsonKey(name: 'main_text') final String? mainText,
    @JsonKey(name: 'secondary_text') final String? secondaryText,
  }) = _$StructuredFormattingImpl;

  factory _StructuredFormatting.fromJson(Map<String, dynamic> json) =
      _$StructuredFormattingImpl.fromJson;

  @override
  @JsonKey(name: 'main_text')
  String? get mainText;
  @override
  @JsonKey(name: 'secondary_text')
  String? get secondaryText;

  /// Create a copy of StructuredFormatting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StructuredFormattingImplCopyWith<_$StructuredFormattingImpl>
  get copyWith => throw _privateConstructorUsedError;
}
