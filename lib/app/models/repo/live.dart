// To parse this JSON data, do
//
//     final liveListModel = liveListModelFromJson(jsonString);

import 'dart:convert';

List<LiveModel> liveListModelFromJson(String str) =>
    List<LiveModel>.from(
        json.decode(str).map((x) => LiveModel.fromJson(x)));

String liveListModelToJson(List<LiveModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveModel {
  int? num;
  dynamic cId;
  String? name;
  String? streamType;
  int? streamId;
  String? streamIcon;
  String? epgChannelId;
  String? added;
  String? customSid;
  int? tvArchive;
  String? directSource;
  int? tvArchiveDuration;
  String? categoryId;
  List<dynamic>? categoryIds;
  String? thumbnail;
  int? isAdult;

  LiveModel({
    this.num,
    this.name,
    this.cId,
    this.streamType,
    this.streamId,
    this.streamIcon,
    this.epgChannelId,
    this.isAdult,
    this.added,
    this.customSid,
    this.tvArchive,
    this.directSource,
    this.tvArchiveDuration,
    this.categoryId,
    this.categoryIds,
    this.thumbnail,
  });

  factory LiveModel.fromJson(Map<String, dynamic> json) => LiveModel(
        num: json["num"],
        name: json["name"],
        cId: json["c_id"],
        streamType: json["stream_type"],
        streamId: json["stream_id"],
        streamIcon: json["stream_icon"],
        epgChannelId: json["epg_channel_id"],
        added: json["added"],
        isAdult: json["is_adult"],
        customSid: json["custom_sid"],
        tvArchive: json["tv_archive"],
        directSource: json["direct_source"],
        tvArchiveDuration: json["tv_archive_duration"],
        categoryId: json["category_id"],
        categoryIds: List<int>.from(json["category_ids"].map((x) => x)),
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "num": num,
        "name": name,
        "c_id": cId,
        "stream_type": streamType,
        "stream_id": streamId,
        "stream_icon": streamIcon,
        "epg_channel_id": epgChannelId,
        "added": added,
        "is_adult": isAdult,
        "custom_sid": customSid,
        "tv_archive": tvArchive,
        "direct_source": directSource,
        "tv_archive_duration": tvArchiveDuration,
        "category_id": categoryId,
        "category_ids": categoryIds == null
            ? jsonEncode([])
            : jsonEncode(List<dynamic>.from(categoryIds?.map((x) => x) ?? [])),
        "thumbnail": thumbnail,
      };
}
