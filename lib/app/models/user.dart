import 'dart:core';
import 'dart:convert';
import 'dart:developer';

import 'package:guek_iptv/app/models/token.dart';

UserModel userModelFromJson(dynamic json) {
  if (json is String) {
    return UserModel.fromJsonString(json);
  }
  return UserModel.fromJson(json);
}

String userModelToJson(UserModel user) => jsonEncode(user.toJson());

class UserModel {
  int id;
  String uuid;
  String name;
  String phone;
  String email;
  DateTime? emailVerifiedAt;
  String country;
  String locale;
  String role;
  bool isBanned;
  List<String>? tags;
  DateTime createdAt;
  DateTime? updatedAt;
  List<TokenModel> tokens;

  UserModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.phone,
    required this.email,
    this.emailVerifiedAt,
    required this.country,
    required this.locale,
    required this.role,
    required this.isBanned,
    this.tags,
    required this.createdAt,
    this.updatedAt,
    required this.tokens,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: int.parse(json["id"].toString()),
    uuid: json["uuid"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    emailVerifiedAt: DateTime.tryParse(json["email_verified_at"]),
    country: json["country"],
    locale: json["locale"],
    role: json["role"],
    isBanned: json["is_banned"] == 1 ? true :false,
    tags: List<String>.from(jsonDecode(json["tags"]).map((x) => x.toString())),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.tryParse(json["updated_at"]),
    tokens: List<TokenModel>.from(json["tokens"].map((x) => tokenModelModelFromJson(x))),
  );

  factory UserModel.fromJsonString(String str) {
    Map<String, dynamic> json = jsonDecode(str);
    return UserModel(
      id: int.parse(json["id"]),
      uuid: json["uuid"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      emailVerifiedAt: DateTime.tryParse(json["email_verified_at"]),
      country: json["country"],
      locale: json["locale"],
      role: json["role"],
      isBanned: json["is_banned"] == 1 ? true :false,
      tags: List<String>.from(jsonDecode(json["tags"].toString()).map((x) => x.toString())),
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.tryParse(json["updated_at"]),
      tokens: List<TokenModel>.from(json["tokens"].map((x) => tokenModelModelFromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
    "phone": phone,
    "email": email,
    "emailVerifiedAt": emailVerifiedAt?.toIso8601String(),
    "country": country,
    "locale": locale,
    "role": role,
    "isBanned": isBanned,
    "tags": jsonEncode(tags),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "tokens": jsonEncode(tokens),
  };
}