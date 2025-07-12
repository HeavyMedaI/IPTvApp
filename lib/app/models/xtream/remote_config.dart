import 'dart:convert';
import 'dart:ffi';

RemoteConfigModel remoteConfigModelFromJson(dynamic json) {
  if (json is String) {
    return RemoteConfigModel.fromJson(jsonDecode(json));
  }
  return RemoteConfigModel.fromJson(json);
}

String remoteConfigModelToJson(RemoteConfigModel remoteConfig) =>
    jsonEncode(remoteConfig.toJson());

class RemoteConfigModel {
  String? onesignal_app_id;
  String? latest_version;
  String? latest_apk_url;
  String? contact_url;
  String? support_url;
  String? portal_url;
  String? marquee;
  String? alert;

  RemoteConfigModel({
    this.onesignal_app_id,
    this.latest_version,
    this.latest_apk_url,
    this.contact_url,
    this.support_url,
    this.portal_url,
    this.marquee,
    this.alert,
  });

  factory RemoteConfigModel.fromJson(Map<String, dynamic> json) => RemoteConfigModel(
    onesignal_app_id: json["onesignal_app_id"].toString(),
    latest_version: json["latest_version"].toString(),
    latest_apk_url: json["latest_apk_url"],
    contact_url: json["contact_url"],
    support_url: json["support_url"],
    portal_url: json["portal_url"],
    marquee: json["marquee"],
    alert: json["alert"],
  );

  Map<String, dynamic> toJson() => {
    "onesignal_app_id": onesignal_app_id,
    "latest_apk_url": latest_apk_url,
    "contact_url": contact_url,
    "support_url": support_url,
    "portal_url": portal_url,
    "marquee": marquee,
    "alert": alert,
  };
}