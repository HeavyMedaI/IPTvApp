import 'dart:convert';
import 'dart:developer';

ServerInfoModel serverInfoModelModelFromJson(dynamic json) {
  if (json is String) {
    return ServerInfoModel.fromJsonString(json);
  }
  return ServerInfoModel.fromJson(json);
}

String serverInfoModelModelToJson(ServerInfoModel ServerInfoModel) => jsonEncode(ServerInfoModel.toJson());

class ServerInfoModel {
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

  ServerInfoModel({
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

  String getApiUrl({bool rtmp = false}) {
    if (rtmp) {
      return "rtmp://" + this.url! + ":" + this.port!;
    }
    return this.serverProtocol! + "://" + this.url! + ":" + this.port!;
  }

  factory ServerInfoModel.fromJson(Map<String, dynamic> json) => ServerInfoModel(
    xui: json["xui"],
    version: json["version"],
    revision: json["revision"],
    url: json["url"],
    port: json["port"],
    httpsPort: json["https_port"],
    serverProtocol: json["server_protocol"],
    rtmpPort: json["rtmp_port"],
    timezone: json["timezone"],
    timestampNow: json["timestamp_now"],
    timeNow: json["time_now"],
    process: json["process"] != null ? 1 : 0,
  );

  factory ServerInfoModel.fromJsonString(String str) {
    Map<String, dynamic> json = jsonDecode(str);
    return ServerInfoModel(
      xui: json["xui"],
      version: json["version"],
      revision: json["revision"],
      url: json["url"],
      port: json["port"],
      httpsPort: json["https_port"],
      serverProtocol: json["server_protocol"],
      rtmpPort: json["rtmp_port"],
      timezone: json["timezone"],
      timestampNow: json["timestamp_now"],
      timeNow: json["time_now"],
      process: json["process"] != null ? 1 : 0,
    );
  }

  Map<String, dynamic> toJson() => {
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