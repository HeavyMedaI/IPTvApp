import 'dart:convert';
import 'dart:developer';

TokenModel tokenModelModelFromJson(dynamic json) {
  if (json is String) {
    return TokenModel.fromJsonString(json);
  }
  return TokenModel.fromJson(json);
}

String tokenModelModelToJson(TokenModel TokenModel) => jsonEncode(TokenModel.toJson());

class TokenModel {
  int id;
  String name;
  String tokenableType;
  int tokenableId;
  List<String> abilities;
  DateTime? lastUsedAt;
  DateTime? expiresAt;
  DateTime createdAt;
  DateTime? updatedAt;

  TokenModel({
    required this.id,
    required this.name,
    required this.tokenableType,
    required this.tokenableId,
    required this.abilities,
    this.lastUsedAt,
    this.expiresAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    id: int.parse(json["id"].toString()),
    name: json["name"],
    tokenableType: json["tokenable_type"],
    tokenableId: int.parse(json["tokenable_id"].toString()),
    abilities: json["abilities"],
    lastUsedAt: DateTime.tryParse(json["last_used_at"]),
    expiresAt: DateTime.tryParse(json["expires_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.tryParse(json["updated_at"]),
  );

  factory TokenModel.fromJsonString(String str) {
    Map<String, dynamic> json = jsonDecode(str);
    return TokenModel(
      id: int.parse(json["id"].toString()),
      name: json["name"],
      tokenableType: json["tokenable_type"],
      tokenableId: int.parse(json["tokenable_id"].toString()),
      abilities: json["abilities"],
      lastUsedAt: DateTime.tryParse(json["last_used_at"]),
      expiresAt: DateTime.tryParse(json["expires_at"]),
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.tryParse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tokenable_type": tokenableType,
    "tokenable_id": tokenableId,
    "abilities": abilities,
    "last_used_at": lastUsedAt,
    "expires_at": expiresAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}