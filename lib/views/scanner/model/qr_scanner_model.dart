import 'dart:convert';

class QrScannerModel {
  final String? qrId;
  final dynamic qrImageBase64;
  final ApprovedBy? approvedBy;
  final PaymentDetails? paymentDetails;
  final LobbyDetail? lobbyDetail;
  final ApprovedBy? userSummary;
  final bool? isScanned;
  final String? status;
  final String? message;
  final dynamic createdAt;
  final DateTime? scannedAt;
  final DateTime? validUntil;
  final int? slots;
  String? qrImageUrl;

  QrScannerModel({
    this.qrId,
    this.qrImageBase64,
    this.approvedBy,
    this.paymentDetails,
    this.lobbyDetail,
    this.userSummary,
    this.isScanned,
    this.status,
    this.message,
    this.createdAt,
    this.scannedAt,
    this.validUntil,
    this.slots,
    this.qrImageUrl,
  });

  QrScannerModel copyWith({
    String? qrId,
    dynamic qrImageBase64,
    ApprovedBy? approvedBy,
    dynamic paymentDetails,
    LobbyDetail? lobbyDetail,
    ApprovedBy? userSummary,
    bool? isScanned,
    String? status,
    String? message,
    dynamic createdAt,
    DateTime? scannedAt,
    DateTime? validUntil,
    int? slots,
    String? qrImageUrl,
  }) => QrScannerModel(
    qrId: qrId ?? this.qrId,
    qrImageBase64: qrImageBase64 ?? this.qrImageBase64,
    approvedBy: approvedBy ?? this.approvedBy,
    paymentDetails: paymentDetails ?? this.paymentDetails,
    lobbyDetail: lobbyDetail ?? this.lobbyDetail,
    userSummary: userSummary ?? this.userSummary,
    isScanned: isScanned ?? this.isScanned,
    status: status ?? this.status,
    message: message ?? this.message,
    createdAt: createdAt ?? this.createdAt,
    scannedAt: scannedAt ?? this.scannedAt,
    validUntil: validUntil ?? this.validUntil,
    slots: slots ?? this.slots,
    qrImageUrl: qrImageUrl ?? this.qrImageUrl,
  );

  factory QrScannerModel.fromRawJson(String str) => QrScannerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QrScannerModel.fromJson(Map<String, dynamic> json) => QrScannerModel(
    qrId: json["qrId"],
    qrImageBase64: json["qrImageBase64"],
    approvedBy: json["approvedBy"] == null ? null : ApprovedBy.fromJson(json["approvedBy"]),
    paymentDetails: (json["paymentDetails"] != null) ? PaymentDetails.fromJson(json["paymentDetails"]) : null,
    lobbyDetail: json["lobbyDetail"] == null ? null : LobbyDetail.fromJson(json["lobbyDetail"]),
    userSummary: json["userSummary"] == null ? null : ApprovedBy.fromJson(json["userSummary"]),
    isScanned: json["isScanned"],
    status: json["status"],
    message: json["message"],
    createdAt: json["createdAt"],
    scannedAt: json["scannedAt"] == null ? null : DateTime.parse(json["scannedAt"]),
    validUntil: json["validUntil"] == null ? null : DateTime.parse(json["validUntil"]),
    slots: json['slots'] ?? 1,
    qrImageUrl: json['qrImageUrl'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "qrId": qrId,
    "qrImageBase64": qrImageBase64,
    "approvedBy": approvedBy?.toJson(),
    "paymentDetails": paymentDetails?.toJson(),
    "lobbyDetail": lobbyDetail?.toJson(),
    "userSummary": userSummary?.toJson(),
    "isScanned": isScanned,
    "status": status,
    "message": message,
    "createdAt": createdAt,
    "scannedAt": scannedAt?.toIso8601String(),
    "validUntil": validUntil?.toIso8601String(),
    "slots": slots,
    "qrImageUrl": qrImageUrl,
  };
}

class ApprovedBy {
  final String? userId;
  final String? userName;
  final String? name;
  final String? gender;
  final String? profilePictureUrl;
  final bool? isFriend;
  final bool? requestSent;
  final bool? requestReceived;
  final Location? location;
  final bool? active;
  final double? rating;

  ApprovedBy({
    this.userId,
    this.userName,
    this.name,
    this.gender,
    this.profilePictureUrl,
    this.isFriend,
    this.requestSent,
    this.requestReceived,
    this.location,
    this.active,
    this.rating,
  });

  ApprovedBy copyWith({
    String? userId,
    String? userName,
    String? name,
    String? gender,
    String? profilePictureUrl,
    bool? isFriend,
    bool? requestSent,
    bool? requestReceived,
    Location? location,
    bool? active,
    double? rating,
  }) => ApprovedBy(
    userId: userId ?? this.userId,
    userName: userName ?? this.userName,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    isFriend: isFriend ?? this.isFriend,
    requestSent: requestSent ?? this.requestSent,
    requestReceived: requestReceived ?? this.requestReceived,
    location: location ?? this.location,
    active: active ?? this.active,
    rating: rating ?? this.rating,
  );

  factory ApprovedBy.fromRawJson(String str) => ApprovedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApprovedBy.fromJson(Map<String, dynamic> json) => ApprovedBy(
    userId: json["userId"],
    userName: json["userName"],
    name: json["name"],
    gender: json["gender"],
    profilePictureUrl: json["profilePictureUrl"],
    isFriend: json["isFriend"],
    requestSent: json["requestSent"],
    requestReceived: json["requestReceived"],
    location: json["Location"] == null ? null : Location.fromJson(json["Location"]),
    active: json["active"],
    rating: (json['rating'] != null) ? double.parse(json['rating'].toString() ?? "0.0") : 0.0,
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "name": name,
    "gender": gender,
    "profilePictureUrl": profilePictureUrl,
    "isFriend": isFriend,
    "requestSent": requestSent,
    "requestReceived": requestReceived,
    "Location": location?.toJson(),
    "active": active,
  };
}

class PaymentDetails {
  final String? paymentMode;
  final double? paidAmount;
  final String? paymentDate;
  final String? transactionId;
  final EntityDetails? entityDetails;
  final String? status;

  PaymentDetails({
    this.paymentMode,
    this.paidAmount,
    this.paymentDate,
    this.transactionId,
    this.entityDetails,
    this.status,
  });

  PaymentDetails copyWith({
    String? paymentMode,
    double? paidAmount,
    String? paymentDate,
    String? transactionId,
    EntityDetails? entityDetails,
    String? status,
  }) => PaymentDetails(
    paymentMode: paymentMode ?? this.paymentMode,
    paidAmount: paidAmount ?? this.paidAmount,
    paymentDate: paymentDate ?? this.paymentDate,
    transactionId: transactionId ?? this.transactionId,
    entityDetails: entityDetails ?? this.entityDetails,
    status: status ?? this.status,
  );

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
    paymentMode: json["paymentMode"],
    paidAmount: json["paidAmount"]?.toDouble(),
    paymentDate: json["paymentDate"],
    transactionId: json["transactionId"],
    entityDetails: json["entityDetails"] == null ? null : EntityDetails.fromJson(json["entityDetails"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "paymentMode": paymentMode,
    "paidAmount": paidAmount,
    "paymentDate": paymentDate,
    "transactionId": transactionId,
    "entityDetails": entityDetails?.toJson(),
    "status": status,
  };
}

class EntityDetails {
  final String? entityId;
  final String? entityType;

  EntityDetails({this.entityId, this.entityType});

  EntityDetails copyWith({String? entityId, String? entityType}) =>
      EntityDetails(entityId: entityId ?? this.entityId, entityType: entityType ?? this.entityType);

  factory EntityDetails.fromJson(Map<String, dynamic> json) =>
      EntityDetails(entityId: json["entityId"], entityType: json["entityType"]);

  Map<String, dynamic> toJson() => {"entityId": entityId, "entityType": entityType};
}

class Location {
  final double? lat;
  final double? lon;

  Location({this.lat, this.lon});

  Location copyWith({double? lat, double? lon}) => Location(lat: lat ?? this.lat, lon: lon ?? this.lon);

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(lat: json["lat"]?.toDouble(), lon: json["lon"]?.toDouble());

  Map<String, dynamic> toJson() => {"lat": lat, "lon": lon};
}

class LobbyDetail {
  final ApprovedBy? createdBy;
  final String? lobbyStatus;
  final String? description;
  final String? title;
  final List<String>? mediaUrls;
  final int? totalMembers;
  final int? currentMembers;
  final int? membersRequired;
  final String? joinedOn;
  final String? joinedDate;
  final String? joinedTime;
  final bool? firstTimeAttendee;
  final String? lobbyType;
  final String? formattedDate;
  final Map<String, dynamic>? locationDetail;

  LobbyDetail({
    this.createdBy,
    this.lobbyStatus,
    this.description,
    this.title,
    this.mediaUrls,
    this.totalMembers,
    this.currentMembers,
    this.membersRequired,
    this.joinedOn,
    this.joinedDate,
    this.joinedTime,
    this.firstTimeAttendee,
    this.lobbyType,
    this.formattedDate,
    this.locationDetail,
  });

  LobbyDetail copyWith({
    ApprovedBy? createdBy,
    String? lobbyStatus,
    String? description,
    String? title,
    List<String>? mediaUrls,
    int? totalMembers,
    int? currentMembers,
    int? membersRequired,
    String? joinedOn,
    String? joinedDate,
    String? joinedTime,
    bool? firstTimeAttendee,
    String? lobbyType,
    String? formattedDate,
    Map<String, dynamic>? locationDetail,
  }) => LobbyDetail(
    createdBy: createdBy ?? this.createdBy,
    lobbyStatus: lobbyStatus ?? this.lobbyStatus,
    description: description ?? this.description,
    title: title ?? this.title,
    mediaUrls: mediaUrls ?? this.mediaUrls,
    totalMembers: totalMembers ?? this.totalMembers,
    currentMembers: currentMembers ?? this.currentMembers,
    membersRequired: membersRequired ?? this.membersRequired,
    joinedOn: joinedOn ?? this.joinedOn,
    joinedDate: joinedDate ?? this.joinedDate,
    joinedTime: joinedTime ?? this.joinedTime,
    firstTimeAttendee: firstTimeAttendee ?? this.firstTimeAttendee,
    lobbyType: lobbyType ?? this.lobbyType,
    formattedDate : formattedDate ?? this.formattedDate,
    locationDetail : locationDetail ?? this.locationDetail,
  );

  factory LobbyDetail.fromRawJson(String str) => LobbyDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LobbyDetail.fromJson(Map<String, dynamic> json) => LobbyDetail(
    createdBy: json["createdBy"] == null ? null : ApprovedBy.fromJson(json["createdBy"]),
    lobbyStatus: json["lobbyStatus"],
    description: json["description"],
    title: json["title"],
    mediaUrls: json["mediaUrls"] == null ? [] : List<String>.from(json["mediaUrls"]!.map((x) => x)),
    totalMembers: json["totalMembers"],
    currentMembers: json["currentMembers"],
    membersRequired: json["membersRequired"],
    joinedOn: json["joinedOn"],
    joinedDate: json["joinedDate"],
    joinedTime: json["joinedTime"],
    firstTimeAttendee: json["firstTimeAttendee"],
    lobbyType: json["lobbyType"],
    formattedDate: json["formattedDate"],
    locationDetail: json["locationDetail"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy?.toJson(),
    "lobbyStatus": lobbyStatus,
    "description": description,
    "title": title,
    "mediaUrls": mediaUrls == null ? [] : List<dynamic>.from(mediaUrls!.map((x) => x)),
    "totalMembers": totalMembers,
    "currentMembers": currentMembers,
    "membersRequired": membersRequired,
    "joinedOn": joinedOn,
    "joinedDate": joinedDate,
    "joinedTime": joinedTime,
    "firstTimeAttendee": firstTimeAttendee,
    "lobbyType": lobbyType,
    "formattedDate": formattedDate,
    "locationDetail": locationDetail,
  };
  static List<QrScannerModel> decodeJson(String str) {
    final List<dynamic> jsonList = json.decode(str);
    return jsonList.map((json) => QrScannerModel.fromJson(json)).toList();
  }
}
