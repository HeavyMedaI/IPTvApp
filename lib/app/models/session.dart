import 'dart:convert';
import 'dart:developer';

import 'package:guek_iptv/app/models/user.dart';

SessionModel sessionModelFromJson(dynamic json) {
  if (json is String) {
    return SessionModel.fromJson(jsonDecode(json));
  }
  return SessionModel.fromJson(json);
}
String sessionModelToJson(SessionModel session) => jsonEncode(session.toJson());

class SessionModel {
  int? id;
  String? token;
  UserModel? user;

  SessionModel({
    this.id,
    this.token,
    this.user,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    json["user"] = json["user"] is String
        ? jsonDecode(json["user"])
        : json["user"];
    int id = int.parse(json["token"].toString().split("|")[0]);
    return SessionModel(
      id: id,
      token: json["token"],
      user: userModelFromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "user": user == null ? jsonEncode([]) : jsonEncode(user?.toJson()),
  };
}


