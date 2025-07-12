import 'dart:core';
import 'dart:convert';

List<Epg> epgModelListFromJson(dynamic json) {
  if (json is String) {
    return List<Epg>.from(
        jsonDecode(json).map((epg) => epgModelFromJson(epg)));
  }
  return List.from(json.map((epg) => epgModelFromJson(epg)));
}

String epgModelListToJson(List<Epg> channelList) =>
    jsonEncode(List<String>.from(
        channelList.map((epg) => epgModelToJson(epg))));

Epg epgModelFromJson(dynamic json) {
  if (json is String) {
    return Epg.fromJson(jsonDecode(json));
  }
  return Epg.fromJson(json);
}

String epgModelToJson(Epg epg) => jsonEncode(epg.toJson());

class Epg {
  int? id;
  String? epgId;
  String? channelId;
  String? title;
  String? description;
  String? lang;
  DateTime? start;
  DateTime? end;
  int? startTimestamp;
  int? stopTimestamp;
  bool? nowPlaying;
  bool? hasArchive;

  Epg({
    this.id,
    this.epgId,
    this.channelId,
    this.title,
    this.description,
    this.lang,
    this.start,
    this.end,
    this.startTimestamp,
    this.stopTimestamp,
    this.nowPlaying,
    this.hasArchive,
  });

  factory Epg.fromJson(Map<String, dynamic> json) => Epg(
    id: int.parse(json["id"]),
    epgId: json["epg_id"],
    channelId: json["channel_id"],
    title: utf8.decode(base64Decode(json["title"])),
    description: utf8.decode(base64Decode(json["description"])),
    lang: json["lang"],
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
    startTimestamp: int.parse(json["start_timestamp"]),
    stopTimestamp: int.parse(json["stop_timestamp"]),
    nowPlaying: json["now_playing"] == 1 ?true :false,
    hasArchive: json["has_archive"] == 1 ?true :false,
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "epg_id": epgId,
    "channel_id": channelId,
    "title": title,
    "description": description,
    "lang": lang,
    "start": start!.toLocal().toString(),
    "end": end!.toLocal().toString(),
    "start_timestamp": startTimestamp.toString(),
    "stop_timestamp": stopTimestamp.toString(),
    "now_playing": nowPlaying,
    "has_archive": hasArchive,
  };
}
