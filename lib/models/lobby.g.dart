// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LobbyImpl _$$LobbyImplFromJson(Map<String, dynamic> json) => _$LobbyImpl(
  id: json['id'] as String,
  createdDate: (json['createdDate'] as num).toInt(),
  userId: json['userId'] as String,
  lobbyStatus: json['lobbyStatus'] as String? ?? "",
  filter: Filter.fromJson(json['filter'] as Map<String, dynamic>),
  description: json['description'] as String? ?? "",
  title: json['title'] as String? ?? "",
  mediaUrls:
      (json['mediaUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  lobbyType: json['lobbyType'] as String? ?? "PRIVATE",
  totalMembers: (json['totalMembers'] as num?)?.toInt() ?? 0,
  currentMembers: (json['currentMembers'] as num?)?.toInt() ?? 0,
  membersRequired: (json['membersRequired'] as num?)?.toInt() ?? 0,
  gender: json['gender'] as String? ?? "MALE",
  userStatus: json['userStatus'] as String? ?? "VISITOR",
  adminSummary: json['adminSummary'] == null
      ? const AdminSummary(userId: "", profilePictureUrl: "")
      : AdminSummary.fromJson(json['adminSummary'] as Map<String, dynamic>),
  content: json['content'] == null
      ? null
      : ContentModel.fromJson(json['content'] as Map<String, dynamic>),
  setting: json['setting'] == null
      ? const Setting()
      : Setting.fromJson(json['setting'] as Map<String, dynamic>),
  activity: json['activity'] as String? ?? "",
  form: json['form'] == null
      ? null
      : FormModel.fromJson(json['form'] as Map<String, dynamic>),
  houseDetail: json['houseDetail'] == null
      ? null
      : HouseInfo.fromJson(json['houseDetail'] as Map<String, dynamic>),
  userSummaries: (json['userSummaries'] as List<dynamic>?)
      ?.map((e) => UserSummary.fromJson(e as Map<String, dynamic>))
      .toList(),
  dateRange: json['dateRange'] as Map<String, dynamic>? ?? const {},
  restriction: json['restriction'] == null
      ? null
      : LobbyRestriction.fromJson(json['restriction'] as Map<String, dynamic>),
  priceDetails: json['priceDetails'] == null
      ? const PriceDetails()
      : PriceDetails.fromJson(json['priceDetails'] as Map<String, dynamic>),
  isAdvancedPricing: json['isAdvancedPricing'] as bool? ?? false,
  allowMultiplePricingOptions:
      json['allowMultiplePricingOptions'] as bool? ?? false,
  ticketOptions:
      (json['ticketOptions'] as List<dynamic>?)
          ?.map((e) => LobbyTicketOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LobbyTicketOption>[],
  accessRequestData: json['accessRequestData'] == null
      ? null
      : AccessRequestData.fromJson(
          json['accessRequestData'] as Map<String, dynamic>,
        ),
  hasForm: json['hasForm'] as bool? ?? false,
  hasOffer: json['hasOffer'] as bool? ?? false,
  isSaved: json['isSaved'] as bool? ?? false,
  isFormMandatory: json['isFormMandatory'] as bool? ?? false,
  isRefundNotPossible: json['isRefundNotPossible'] as bool? ?? false,
  rating: json['rating'] == null
      ? const Rating()
      : Rating.fromJson(json['rating'] as Map<String, dynamic>),
  priceTierList:
      (json['priceTierList'] as List<dynamic>?)
          ?.map((e) => PriceTier.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  ratingGiven: json['ratingGiven'] as bool? ?? false,
  loginNotRequired: json['loginNotRequired'] as bool? ?? false,
);

Map<String, dynamic> _$$LobbyImplToJson(_$LobbyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate,
      'userId': instance.userId,
      'lobbyStatus': instance.lobbyStatus,
      'filter': instance.filter.toJson(),
      'description': instance.description,
      'title': instance.title,
      'mediaUrls': instance.mediaUrls,
      'lobbyType': instance.lobbyType,
      'totalMembers': instance.totalMembers,
      'currentMembers': instance.currentMembers,
      'membersRequired': instance.membersRequired,
      'gender': instance.gender,
      'userStatus': instance.userStatus,
      'adminSummary': instance.adminSummary.toJson(),
      'content': instance.content?.toJson(),
      'setting': instance.setting.toJson(),
      'activity': instance.activity,
      'form': instance.form?.toJson(),
      'houseDetail': instance.houseDetail?.toJson(),
      'userSummaries': instance.userSummaries?.map((e) => e.toJson()).toList(),
      'dateRange': instance.dateRange,
      'restriction': instance.restriction?.toJson(),
      'priceDetails': instance.priceDetails.toJson(),
      'isAdvancedPricing': instance.isAdvancedPricing,
      'allowMultiplePricingOptions': instance.allowMultiplePricingOptions,
      'ticketOptions': instance.ticketOptions.map((e) => e.toJson()).toList(),
      'accessRequestData': instance.accessRequestData?.toJson(),
      'hasForm': instance.hasForm,
      'hasOffer': instance.hasOffer,
      'isSaved': instance.isSaved,
      'isFormMandatory': instance.isFormMandatory,
      'isRefundNotPossible': instance.isRefundNotPossible,
      'rating': instance.rating.toJson(),
      'priceTierList': instance.priceTierList?.map((e) => e.toJson()).toList(),
      'ratingGiven': instance.ratingGiven,
      'loginNotRequired': instance.loginNotRequired,
    };

_$RatingImpl _$$RatingImplFromJson(Map<String, dynamic> json) => _$RatingImpl(
  average: (json['average'] as num?)?.toDouble() ?? 0.0,
  count: (json['count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$RatingImplToJson(_$RatingImpl instance) =>
    <String, dynamic>{'average': instance.average, 'count': instance.count};

_$FormModelImpl _$$FormModelImplFromJson(Map<String, dynamic> json) =>
    _$FormModelImpl(
      title: json['title'] as String? ?? '',
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Question>[],
    );

Map<String, dynamic> _$$FormModelImplToJson(_$FormModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

_$SettingImpl _$$SettingImplFromJson(Map<String, dynamic> json) =>
    _$SettingImpl(
      showLobbyMembers: json['showLobbyMembers'] as bool? ?? true,
      enableChat: json['enableChat'] as bool? ?? true,
      showMembers: json['showMembers'] as bool? ?? true,
    );

Map<String, dynamic> _$$SettingImplToJson(_$SettingImpl instance) =>
    <String, dynamic>{
      'showLobbyMembers': instance.showLobbyMembers,
      'enableChat': instance.enableChat,
      'showMembers': instance.showMembers,
    };

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      id: json['id'] as String? ?? '',
      questionText: json['questionText'] as String? ?? '',
      questionType: json['questionType'] as String? ?? '',
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      answer: json['answer'] as String? ?? '',
      isMandatory: json['isMandatory'] as bool? ?? false,
      questionLabel: json['questionLabel'] as String? ?? '',
      dataKey: json['dataKey'] as String? ?? '',
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionText': instance.questionText,
      'questionType': instance.questionType,
      'options': instance.options,
      'answer': instance.answer,
      'isMandatory': instance.isMandatory,
      'questionLabel': instance.questionLabel,
      'dataKey': instance.dataKey,
    };

_$UserSummaryImpl _$$UserSummaryImplFromJson(Map<String, dynamic> json) =>
    _$UserSummaryImpl(
      userId: json['userId'] as String? ?? "",
      userName: json['userName'] as String? ?? "",
      name: json['name'] as String? ?? "",
      email: json['email'] as String? ?? "",
      gender: json['gender'] as String? ?? "",
      profilePictureUrl: json['profilePictureUrl'] as String? ?? "",
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      active: json['active'] as bool? ?? false,
      dob: json['dob'] as String? ?? "",
    );

Map<String, dynamic> _$$UserSummaryImplToJson(_$UserSummaryImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'profilePictureUrl': instance.profilePictureUrl,
      'location': instance.location?.toJson(),
      'active': instance.active,
      'dob': instance.dob,
    };

_$LobbyRestrictionImpl _$$LobbyRestrictionImplFromJson(
  Map<String, dynamic> json,
) => _$LobbyRestrictionImpl(
  genderRestriction: json['genderRestriction'] as String? ?? "",
  ageRange: json['ageRange'] == null
      ? null
      : AgeRange.fromJson(json['ageRange'] as Map<String, dynamic>),
  maxMales: (json['maxMales'] as num?)?.toInt(),
  maxFemales: (json['maxFemales'] as num?)?.toInt(),
  maxOthers: (json['maxOthers'] as num?)?.toInt(),
  restrictToOrganization: json['restrictToOrganization'] as bool? ?? false,
  organizationName: json['organizationName'] as String? ?? "",
  organizationEmailDomain: json['organizationEmailDomain'] as String? ?? "",
);

Map<String, dynamic> _$$LobbyRestrictionImplToJson(
  _$LobbyRestrictionImpl instance,
) => <String, dynamic>{
  'genderRestriction': instance.genderRestriction,
  'ageRange': instance.ageRange?.toJson(),
  'maxMales': instance.maxMales,
  'maxFemales': instance.maxFemales,
  'maxOthers': instance.maxOthers,
  'restrictToOrganization': instance.restrictToOrganization,
  'organizationName': instance.organizationName,
  'organizationEmailDomain': instance.organizationEmailDomain,
};

_$AgeRangeImpl _$$AgeRangeImplFromJson(Map<String, dynamic> json) =>
    _$AgeRangeImpl(
      minAge: (json['minAge'] as num?)?.toInt() ?? 0,
      maxAge: (json['maxAge'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$$AgeRangeImplToJson(_$AgeRangeImpl instance) =>
    <String, dynamic>{'minAge': instance.minAge, 'maxAge': instance.maxAge};

_$PriceDetailsImpl _$$PriceDetailsImplFromJson(Map<String, dynamic> json) =>
    _$PriceDetailsImpl(
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['originalPrice'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? "INR",
      isRefundAllowed: json['isRefundAllowed'] as bool? ?? false,
    );

Map<String, dynamic> _$$PriceDetailsImplToJson(_$PriceDetailsImpl instance) =>
    <String, dynamic>{
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'currency': instance.currency,
      'isRefundAllowed': instance.isRefundAllowed,
    };

_$LobbyTicketOptionImpl _$$LobbyTicketOptionImplFromJson(
  Map<String, dynamic> json,
) => _$LobbyTicketOptionImpl(
  id: json['id'] as String? ?? "",
  name: json['name'] as String? ?? "",
  description: json['description'] as String? ?? "",
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  totalSlots: (json['totalSlots'] as num?)?.toInt() ?? 0,
  bookedSlots: (json['bookedSlots'] as num?)?.toInt() ?? 0,
  currency: json['currency'] as String? ?? "INR",
  minQuantity: (json['minQuantity'] as num?)?.toInt() ?? 1,
  maxQuantity: (json['maxQuantity'] as num?)?.toInt() ?? 1,
  activity: json['activity'] as String? ?? "",
  isDisabled: json['isDisabled'] as bool? ?? false,
);

Map<String, dynamic> _$$LobbyTicketOptionImplToJson(
  _$LobbyTicketOptionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'totalSlots': instance.totalSlots,
  'bookedSlots': instance.bookedSlots,
  'currency': instance.currency,
  'minQuantity': instance.minQuantity,
  'maxQuantity': instance.maxQuantity,
  'activity': instance.activity,
  'isDisabled': instance.isDisabled,
};

_$AccessRequestDataImpl _$$AccessRequestDataImplFromJson(
  Map<String, dynamic> json,
) => _$AccessRequestDataImpl(
  accessId: json['accessId'] as String? ?? "",
  isGroupAccess: json['isGroupAccess'] as bool? ?? false,
  count: (json['count'] as num?)?.toInt() ?? 0,
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  isAdmin: json['isAdmin'] as bool? ?? false,
);

Map<String, dynamic> _$$AccessRequestDataImplToJson(
  _$AccessRequestDataImpl instance,
) => <String, dynamic>{
  'accessId': instance.accessId,
  'isGroupAccess': instance.isGroupAccess,
  'count': instance.count,
  'price': instance.price,
  'isAdmin': instance.isAdmin,
};

_$HouseInfoImpl _$$HouseInfoImplFromJson(Map<String, dynamic> json) =>
    _$HouseInfoImpl(
      houseId: json['houseId'] as String? ?? "",
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      profilePhoto: json['profilePhoto'] as String? ?? "",
      panVerified: json['panVerified'] as bool? ?? false,
      accountVerified: json['accountVerified'] as bool? ?? false,
      gstVerified: json['gstVerified'] as bool? ?? false,
      loginNotRequired: json['loginNotRequired'] as bool? ?? false,
    );

Map<String, dynamic> _$$HouseInfoImplToJson(_$HouseInfoImpl instance) =>
    <String, dynamic>{
      'houseId': instance.houseId,
      'name': instance.name,
      'description': instance.description,
      'profilePhoto': instance.profilePhoto,
      'panVerified': instance.panVerified,
      'accountVerified': instance.accountVerified,
      'gstVerified': instance.gstVerified,
      'loginNotRequired': instance.loginNotRequired,
    };

_$AdminSummaryImpl _$$AdminSummaryImplFromJson(Map<String, dynamic> json) =>
    _$AdminSummaryImpl(
      userId: json['userId'] as String,
      userName: json['userName'] as String? ?? "",
      name: json['name'] as String? ?? "",
      gender: json['gender'] as String? ?? "",
      profilePictureUrl: json['profilePictureUrl'] as String? ?? "",
      isFriend: json['isFriend'] as bool? ?? false,
      requestSent: json['requestSent'] as bool? ?? false,
      requestReceived: json['requestReceived'] as bool? ?? false,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      active: json['active'] as bool? ?? false,
    );

Map<String, dynamic> _$$AdminSummaryImplToJson(_$AdminSummaryImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'name': instance.name,
      'gender': instance.gender,
      'profilePictureUrl': instance.profilePictureUrl,
      'isFriend': instance.isFriend,
      'requestSent': instance.requestSent,
      'requestReceived': instance.requestReceived,
      'location': instance.location?.toJson(),
      'active': instance.active,
    };

_$ContentModelImpl _$$ContentModelImplFromJson(Map<String, dynamic> json) =>
    _$ContentModelImpl(
      title: json['title'] as String? ?? "",
      body: json['body'] as String? ?? "",
    );

Map<String, dynamic> _$$ContentModelImplToJson(_$ContentModelImpl instance) =>
    <String, dynamic>{'title': instance.title, 'body': instance.body};

_$PriceTierImpl _$$PriceTierImplFromJson(Map<String, dynamic> json) =>
    _$PriceTierImpl(
      minSlots: (json['minSlots'] as num?)?.toInt() ?? 0,
      maxSlots: (json['maxSlots'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$PriceTierImplToJson(_$PriceTierImpl instance) =>
    <String, dynamic>{
      'minSlots': instance.minSlots,
      'maxSlots': instance.maxSlots,
      'price': instance.price,
    };

_$FilterImpl _$$FilterImplFromJson(Map<String, dynamic> json) => _$FilterImpl(
  categoryId: json['categoryId'] as String,
  categoryName: json['categoryName'] as String? ?? '',
  subCategoryId: json['subCategoryId'] as String,
  subCategoryName: json['subCategoryName'] as String? ?? '',
  filterInfoList:
      (json['filterInfoList'] as List<dynamic>?)
          ?.map((e) => FilterInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  advancedFilterInfoList:
      (json['advancedFilterInfoList'] as List<dynamic>?)
          ?.map((e) => FilterInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  otherFilterInfo: json['otherFilterInfo'] == null
      ? const OtherFilterInfo()
      : OtherFilterInfo.fromJson(
          json['otherFilterInfo'] as Map<String, dynamic>,
        ),
  createdDate: (json['createdDate'] as num?)?.toInt(),
);

Map<String, dynamic> _$$FilterImplToJson(_$FilterImpl instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'subCategoryId': instance.subCategoryId,
      'subCategoryName': instance.subCategoryName,
      'filterInfoList': instance.filterInfoList.map((e) => e.toJson()).toList(),
      'advancedFilterInfoList': instance.advancedFilterInfoList
          .map((e) => e.toJson())
          .toList(),
      'otherFilterInfo': instance.otherFilterInfo.toJson(),
      'createdDate': instance.createdDate,
    };

_$FilterInfoImpl _$$FilterInfoImplFromJson(Map<String, dynamic> json) =>
    _$FilterInfoImpl(
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      title: json['title'] as String,
      iconUrl: json['iconUrl'] as String?,
      filterType: json['filterType'] as String? ?? "",
      weightage: (json['weightage'] as num?)?.toInt() ?? 0,
      showInCompactView: json['showInCompactView'] as bool? ?? false,
    );

Map<String, dynamic> _$$FilterInfoImplToJson(_$FilterInfoImpl instance) =>
    <String, dynamic>{
      'options': instance.options,
      'title': instance.title,
      'iconUrl': instance.iconUrl,
      'filterType': instance.filterType,
      'weightage': instance.weightage,
      'showInCompactView': instance.showInCompactView,
    };

_$OtherFilterInfoImpl _$$OtherFilterInfoImplFromJson(
  Map<String, dynamic> json,
) => _$OtherFilterInfoImpl(
  dateInfo: json['dateInfo'] == null
      ? null
      : DateInfo.fromJson(json['dateInfo'] as Map<String, dynamic>),
  dateRange: json['dateRange'] == null
      ? null
      : DateRange.fromJson(json['dateRange'] as Map<String, dynamic>),
  destination: json['destination'] == null
      ? null
      : Destination.fromJson(json['destination'] as Map<String, dynamic>),
  paidLobby: json['paidLobby'] == null
      ? null
      : PaidLobby.fromJson(json['paidLobby'] as Map<String, dynamic>),
  pickUp: json['pickUp'] == null
      ? null
      : PickUp.fromJson(json['pickUp'] as Map<String, dynamic>),
  memberCount: json['memberCount'] == null
      ? null
      : MemberCount.fromJson(json['memberCount'] as Map<String, dynamic>),
  currentCount: json['currentCount'] == null
      ? null
      : CurrentCount.fromJson(json['currentCount'] as Map<String, dynamic>),
  range: json['range'] == null
      ? null
      : Range.fromJson(json['range'] as Map<String, dynamic>),
  locationInfo: json['locationInfo'] == null
      ? null
      : LocationInfo.fromJson(json['locationInfo'] as Map<String, dynamic>),
  multipleLocations: json['multipleLocations'] == null
      ? null
      : LocationInfo.fromJson(
          json['multipleLocations'] as Map<String, dynamic>,
        ),
  info: (json['info'] as List<dynamic>?)
      ?.map((e) => Info.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$OtherFilterInfoImplToJson(
  _$OtherFilterInfoImpl instance,
) => <String, dynamic>{
  'dateInfo': instance.dateInfo?.toJson(),
  'dateRange': instance.dateRange?.toJson(),
  'destination': instance.destination?.toJson(),
  'paidLobby': instance.paidLobby?.toJson(),
  'pickUp': instance.pickUp?.toJson(),
  'memberCount': instance.memberCount?.toJson(),
  'range': instance.range?.toJson(),
  'locationInfo': instance.locationInfo?.toJson(),
  'multipleLocations': instance.multipleLocations?.toJson(),
  'info': instance.info?.map((e) => e.toJson()).toList(),
};

_$DateInfoImpl _$$DateInfoImplFromJson(Map<String, dynamic> json) =>
    _$DateInfoImpl(
      date: (json['date'] as num).toInt(),
      title: json['title'] as String,
      formattedDate: json['formattedDate'] as String?,
      iconUrl: json['iconUrl'] as String?,
      filterType: json['filterType'] as String? ?? "DATE",
      weightage: (json['weightage'] as num?)?.toInt() ?? 0,
      showInCompactView: json['showInCompactView'] as bool? ?? false,
    );

Map<String, dynamic> _$$DateInfoImplToJson(_$DateInfoImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'title': instance.title,
      'formattedDate': instance.formattedDate,
      'iconUrl': instance.iconUrl,
      'filterType': instance.filterType,
      'weightage': instance.weightage,
      'showInCompactView': instance.showInCompactView,
    };

_$DateRangeImpl _$$DateRangeImplFromJson(Map<String, dynamic> json) =>
    _$DateRangeImpl(
      startDate: (json['startDate'] as num).toInt(),
      endDate: (json['endDate'] as num).toInt(),
      title: json['title'] as String,
      formattedDate: json['formattedDate'] as String?,
      formattedDateCompactView:
          json['formattedDateCompactView'] as String? ?? "",
      iconUrl: json['iconUrl'] as String?,
      filterType: json['filterType'] as String? ?? "DATE_RANGE",
      weightage: (json['weightage'] as num?)?.toInt() ?? 0,
      showInCompactView: json['showInCompactView'] as bool? ?? false,
    );

Map<String, dynamic> _$$DateRangeImplToJson(_$DateRangeImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'title': instance.title,
      'formattedDate': instance.formattedDate,
      'formattedDateCompactView': instance.formattedDateCompactView,
      'iconUrl': instance.iconUrl,
      'filterType': instance.filterType,
      'weightage': instance.weightage,
      'showInCompactView': instance.showInCompactView,
    };

_$DestinationImpl _$$DestinationImplFromJson(Map<String, dynamic> json) =>
    _$DestinationImpl(
      title: json['title'] as String,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      locationResponse: json['locationResponse'] == null
          ? null
          : LocationResponse.fromJson(
              json['locationResponse'] as Map<String, dynamic>,
            ),
      iconUrl: json['iconUrl'] as String?,
      googleSearchResponse: json['googleSearchResponse'] == null
          ? null
          : GoogleSearchResponse.fromJson(
              json['googleSearchResponse'] as Map<String, dynamic>,
            ),
      filterType: json['filterType'] as String? ?? "LOCATION",
      weightage: (json['weightage'] as num?)?.toInt() ?? 0,
      showInCompactView: json['showInCompactView'] as bool? ?? false,
    );

Map<String, dynamic> _$$DestinationImplToJson(_$DestinationImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'location': instance.location?.toJson(),
      'locationResponse': instance.locationResponse?.toJson(),
      'iconUrl': instance.iconUrl,
      'googleSearchResponse': instance.googleSearchResponse?.toJson(),
      'filterType': instance.filterType,
      'weightage': instance.weightage,
      'showInCompactView': instance.showInCompactView,
    };

_$PaidLobbyImpl _$$PaidLobbyImplFromJson(Map<String, dynamic> json) =>
    _$PaidLobbyImpl(
      isPaid: json['isPaid'] as bool? ?? false,
      title: json['title'] as String,
      iconUrl: json['iconUrl'] as String?,
      value: (json['value'] as num?)?.toDouble() ?? 0,
      filterType: json['filterType'] as String? ?? "RADIO_BUTTON_WITH_INPUT",
      weightage: (json['weightage'] as num?)?.toInt() ?? 0,
      showInCompactView: json['showInCompactView'] as bool? ?? false,
    );

Map<String, dynamic> _$$PaidLobbyImplToJson(_$PaidLobbyImpl instance) =>
    <String, dynamic>{
      'isPaid': instance.isPaid,
      'title': instance.title,
      'iconUrl': instance.iconUrl,
      'value': instance.value,
      'filterType': instance.filterType,
      'weightage': instance.weightage,
      'showInCompactView': instance.showInCompactView,
    };

_$PickUpImpl _$$PickUpImplFromJson(Map<String, dynamic> json) => _$PickUpImpl(
  title: json['title'] as String,
  location: json['location'] == null
      ? null
      : Location.fromJson(json['location'] as Map<String, dynamic>),
  locationResponse: json['locationResponse'] == null
      ? null
      : LocationResponse.fromJson(
          json['locationResponse'] as Map<String, dynamic>,
        ),
  iconUrl: json['iconUrl'] as String?,
  googleSearchResponse: json['googleSearchResponse'] == null
      ? null
      : GoogleSearchResponse.fromJson(
          json['googleSearchResponse'] as Map<String, dynamic>,
        ),
  filterType: json['filterType'] as String? ?? "LOCATION",
  weightage: (json['weightage'] as num?)?.toInt() ?? 0,
  showInCompactView: json['showInCompactView'] as bool? ?? false,
);

Map<String, dynamic> _$$PickUpImplToJson(_$PickUpImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'location': instance.location?.toJson(),
      'locationResponse': instance.locationResponse?.toJson(),
      'iconUrl': instance.iconUrl,
      'googleSearchResponse': instance.googleSearchResponse?.toJson(),
      'filterType': instance.filterType,
      'weightage': instance.weightage,
      'showInCompactView': instance.showInCompactView,
    };

_$MemberCountImpl _$$MemberCountImplFromJson(Map<String, dynamic> json) =>
    _$MemberCountImpl(
      value: (json['value'] as num?)?.toInt() ?? 0,
      title: json['title'] as String,
      iconUrl: json['iconUrl'] as String?,
      filterType: json['filterType'] as String? ?? "INPUT",
      weightage: (json['weightage'] as num?)?.toInt() ?? 0,
      showInCompactView: json['showInCompactView'] as bool? ?? false,
    );

Map<String, dynamic> _$$MemberCountImplToJson(_$MemberCountImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'title': instance.title,
      'iconUrl': instance.iconUrl,
      'filterType': instance.filterType,
      'weightage': instance.weightage,
      'showInCompactView': instance.showInCompactView,
    };

_$CurrentCountImpl _$$CurrentCountImplFromJson(Map<String, dynamic> json) =>
    _$CurrentCountImpl(
      value: (json['value'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? 'Current count',
      iconUrl: json['iconUrl'] as String?,
      filterType: json['filterType'] as String? ?? "INPUT",
      weightage: (json['weightage'] as num?)?.toInt() ?? 0,
      showInCompactView: json['showInCompactView'] as bool? ?? false,
    );

Map<String, dynamic> _$$CurrentCountImplToJson(_$CurrentCountImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'title': instance.title,
      'iconUrl': instance.iconUrl,
      'filterType': instance.filterType,
      'weightage': instance.weightage,
      'showInCompactView': instance.showInCompactView,
    };

_$RangeImpl _$$RangeImplFromJson(Map<String, dynamic> json) => _$RangeImpl(
  min: (json['min'] as num?)?.toInt() ?? 0,
  max: (json['max'] as num?)?.toInt() ?? 0,
  title: json['title'] as String,
  iconUrl: json['iconUrl'] as String?,
  filterType: json['filterType'] as String? ?? "SLIDER",
  weightage: (json['weightage'] as num?)?.toInt() ?? 0,
  showInCompactView: json['showInCompactView'] as bool? ?? false,
);

Map<String, dynamic> _$$RangeImplToJson(_$RangeImpl instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'title': instance.title,
      'iconUrl': instance.iconUrl,
      'filterType': instance.filterType,
      'weightage': instance.weightage,
      'showInCompactView': instance.showInCompactView,
    };

_$InfoImpl _$$InfoImplFromJson(Map<String, dynamic> json) => _$InfoImpl(
  value: (json['value'] as num?)?.toDouble() ?? 0,
  iconUrl: json['iconUrl'] as String?,
  title: json['title'] as String,
  filterType: json['filterType'] as String? ?? "INPUT",
  weightage: (json['weightage'] as num?)?.toInt() ?? 0,
  showInCompactView: json['showInCompactView'] as bool? ?? false,
);

Map<String, dynamic> _$$InfoImplToJson(_$InfoImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'iconUrl': instance.iconUrl,
      'title': instance.title,
      'filterType': instance.filterType,
      'weightage': instance.weightage,
      'showInCompactView': instance.showInCompactView,
    };

_$LocationInfoImpl _$$LocationInfoImplFromJson(Map<String, dynamic> json) =>
    _$LocationInfoImpl(
      title: json['title'] as String?,
      locationResponses:
          (json['locationResponses'] as List<dynamic>?)
              ?.map((e) => LocationResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      weightage: (json['weightage'] as num?)?.toInt() ?? 0,
      iconUrl: json['iconUrl'] as String?,
      filterType: json['filterType'] as String? ?? "LOCATION",
      showInCompactView: json['showInCompactView'] as bool? ?? true,
      hideLocation: json['hideLocation'] as bool? ?? false,
      googleSearchResponses:
          (json['googleSearchResponses'] as List<dynamic>?)
              ?.map(
                (e) => GoogleSearchResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LocationInfoImplToJson(_$LocationInfoImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'locationResponses': instance.locationResponses
          .map((e) => e.toJson())
          .toList(),
      'weightage': instance.weightage,
      'iconUrl': instance.iconUrl,
      'filterType': instance.filterType,
      'showInCompactView': instance.showInCompactView,
      'hideLocation': instance.hideLocation,
      'googleSearchResponses': instance.googleSearchResponses
          .map((e) => e.toJson())
          .toList(),
    };

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{'lat': instance.lat, 'lon': instance.lon};

_$LocationResponseImpl _$$LocationResponseImplFromJson(
  Map<String, dynamic> json,
) => _$LocationResponseImpl(
  exactLocation: json['exactLocation'] == null
      ? const Location()
      : Location.fromJson(json['exactLocation'] as Map<String, dynamic>),
  approxLocation: json['approxLocation'] == null
      ? const Location()
      : Location.fromJson(json['approxLocation'] as Map<String, dynamic>),
  areaName: json['areaName'] as String? ?? '',
  fuzzyAddress: json['fuzzyAddress'] as String? ?? '',
);

Map<String, dynamic> _$$LocationResponseImplToJson(
  _$LocationResponseImpl instance,
) => <String, dynamic>{
  'exactLocation': instance.exactLocation.toJson(),
  'approxLocation': instance.approxLocation.toJson(),
  'areaName': instance.areaName,
  'fuzzyAddress': instance.fuzzyAddress,
};

_$PositionImpl _$$PositionImplFromJson(Map<String, dynamic> json) =>
    _$PositionImpl(
      row: (json['row'] as num).toInt(),
      column: (json['column'] as num).toInt(),
    );

Map<String, dynamic> _$$PositionImplToJson(_$PositionImpl instance) =>
    <String, dynamic>{'row': instance.row, 'column': instance.column};

_$GoogleSearchResponseImpl _$$GoogleSearchResponseImplFromJson(
  Map<String, dynamic> json,
) => _$GoogleSearchResponseImpl(
  description: json['description'] as String?,
  placeId: json['place_id'] as String?,
  structuredFormatting: json['structured_formatting'] == null
      ? null
      : StructuredFormatting.fromJson(
          json['structured_formatting'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$GoogleSearchResponseImplToJson(
  _$GoogleSearchResponseImpl instance,
) => <String, dynamic>{
  'description': instance.description,
  'place_id': instance.placeId,
  'structured_formatting': instance.structuredFormatting?.toJson(),
};

_$StructuredFormattingImpl _$$StructuredFormattingImplFromJson(
  Map<String, dynamic> json,
) => _$StructuredFormattingImpl(
  mainText: json['main_text'] as String?,
  secondaryText: json['secondary_text'] as String?,
);

Map<String, dynamic> _$$StructuredFormattingImplToJson(
  _$StructuredFormattingImpl instance,
) => <String, dynamic>{
  'main_text': instance.mainText,
  'secondary_text': instance.secondaryText,
};
