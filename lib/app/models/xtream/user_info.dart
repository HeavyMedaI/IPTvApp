import 'dart:convert';
import 'dart:developer';

UserInfoModel userInfoModelFromJson(dynamic json) {
  if (json is String) {
    return UserInfoModel.fromJsonString(json);
  }
  return UserInfoModel.fromJson(json);
}

String userInfoModelToJson(UserInfoModel user) => jsonEncode(user.toJson());

class UserInfoModel {
  String? username;
  String? password;
  String? phone;
  String? message;
  int? auth;
  String? status;
  String? expDate;
  String? isTrial;
  dynamic activeCons;
  String? createdAt;
  String? maxConnections;
  List<String>? allowedOutputFormats;

  UserInfoModel({
    this.username,
    this.password,
    this.phone,
    this.message,
    this.auth,
    this.status,
    this.expDate,
    this.isTrial,
    this.activeCons,
    this.createdAt,
    this.maxConnections,
    this.allowedOutputFormats,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    username: json["username"],
    password: json["password"],
    phone: json["phone"],
    message: json["message"],
    auth: json["auth"],
    status: json["status"],
    expDate: json["exp_date"],
    isTrial: json["is_trial"],
    activeCons: json["active_cons"],
    createdAt: json["created_at"],
    maxConnections: json["max_connections"],
    allowedOutputFormats:
    List<String>.from(json["allowed_output_formats"].map((x) => x)),
  );

  factory UserInfoModel.fromJsonString(String str) {
    Map<String, dynamic> json = jsonDecode(str);
    json["allowed_output_formats"] = json["allowed_output_formats"] is String
        ? jsonDecode(json["allowed_output_formats"])
        : json["allowed_output_formats"];
    return UserInfoModel(
      username: json["username"],
      password: json["password"],
      phone: json["phone"],
      message: json["message"],
      auth: json["auth"],
      status: json["status"],
      expDate: json["exp_date"],
      isTrial: json["is_trial"],
      activeCons: json["active_cons"],
      createdAt: json["created_at"],
      maxConnections: json["max_connections"],
      allowedOutputFormats:
      List<String>.from(json["allowed_output_formats"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "phone": phone,
    "message": message,
    "auth": auth,
    "status": status,
    "exp_date": expDate,
    "is_trial": isTrial,
    "active_cons": activeCons,
    "created_at": createdAt,
    "max_connections": maxConnections,
    "allowed_output_formats": allowedOutputFormats == null
        ? jsonEncode([])
        : jsonEncode(
        List<dynamic>.from(allowedOutputFormats?.map((x) => x) ?? [])),
  };
}