import 'dart:convert';
import 'dart:developer';

import 'package:guek_iptv/app/models/xtream/server_info.dart';
import 'package:guek_iptv/app/models/xtream/user_info.dart';

SessionModel sessionModelFromJson(dynamic json) {
  if (json is String) {
    return SessionModel.fromJson(jsonDecode(json));
  }
  return SessionModel.fromJson(json);
}
String sessionModelToJson(SessionModel session) => jsonEncode(session.toJson());

class SessionModel {
  UserInfoModel? userInfo;
  ServerInfoModel? serverInfo;
  String? username;
  String? password;
  String? message;
  int? auth;
  String? status;
  String? expDate;
  String? isTrial;
  dynamic activeCons;
  String? createdAt;
  String? maxConnections;
  List<String>? allowedOutputFormats;
  dynamic xui;
  dynamic version;
  dynamic revision;
  String? url;
  String? port;
  String? httpsPort;
  String? serverProtocol;
  String? rtmpPort;
  String? timezone;
  int? timestampNow;
  String? timeNow;
  int? process;

  SessionModel({
    this.username,
    this.password,
    this.userInfo,
    this.serverInfo,
    this.message,
    this.auth,
    this.status,
    this.expDate,
    this.isTrial,
    this.activeCons,
    this.createdAt,
    this.maxConnections,
    this.allowedOutputFormats,
    this.xui,
    this.version,
    this.revision,
    this.url,
    this.port,
    this.httpsPort,
    this.serverProtocol,
    this.rtmpPort,
    this.timezone,
    this.timestampNow,
    this.timeNow,
    this.process,
  });

  String getM3U({String type = "m3u_plus", String output = "mpegts"}) {
    String apiUrl = serverInfo!.getApiUrl(rtmp: false);
    return "${apiUrl}/get.php?username=${username}&password=${password}&type=${type}&output=${output}";
  }

  DateTime getExpDate() {
    return DateTime.fromMillisecondsSinceEpoch((int.parse(this.expDate!)*1000), isUtc: true);
  }

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    json["user_info"] = json["user_info"] is String
        ? jsonDecode(json["user_info"])
        : json["user_info"];
    json["server_info"] = json["server_info"] is String
        ? jsonDecode(json["server_info"])
        : json["server_info"];
    json["user_info"]["allowed_output_formats"] =
        json["user_info"]["allowed_output_formats"] is String
            ? jsonDecode(json["user_info"]["allowed_output_formats"])
            : json["user_info"]["allowed_output_formats"];

    return SessionModel(
      userInfo: userInfoModelFromJson(json["user_info"]),
      serverInfo: serverInfoModelModelFromJson(json["server_info"]),
      username: json["user_info"]["username"],
      password: json["user_info"]["password"],
      message: json["user_info"]["message"],
      auth: json["user_info"]["auth"],
      status: json["user_info"]["status"],
      expDate: json["user_info"]["exp_date"],
      isTrial: json["user_info"]["is_trial"],
      activeCons: json["user_info"]["active_cons"],
      createdAt: json["user_info"]["created_at"],
      maxConnections: json["user_info"]["max_connections"],
      allowedOutputFormats: List<String>.from(
          json["user_info"]["allowed_output_formats"].map((x) => x)),
      xui: json["server_info"]["xui"] != null ? 1 : null,
      version: json["server_info"]["version"],
      revision: json["server_info"]["revision"],
      url: json["server_info"]["url"],
      port: json["server_info"]["port"],
      httpsPort: json["server_info"]["https_port"],
      serverProtocol: json["server_info"]["server_protocol"],
      rtmpPort: json["server_info"]["rtmp_port"],
      timezone: json["server_info"]["timezone"],
      timestampNow: json["server_info"]["timestamp_now"],
      timeNow: json["server_info"]["time_now"],
      process: json["server_info"]["process"] != null ? 1 : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "user_info":
            userInfo == null ? jsonEncode([]) : jsonEncode(userInfo?.toJson()),
        "server_info": serverInfo == null
            ? jsonEncode([])
            : jsonEncode(serverInfo?.toJson()),
        "username": username,
        "password": password,
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
        "xui": xui,
        "version": version,
        "revision": revision,
        "url": url,
        "port": port,
        "https_port": httpsPort,
        "server_protocol": serverProtocol,
        "rtmp_port": rtmpPort,
        "timezone": timezone,
        "timestamp_now": timestampNow,
        "time_now": timeNow,
        "process": process,
      };
}


