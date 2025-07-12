import 'dart:convert';
import 'dart:ffi';

Video videoModelFromJson(dynamic json) {
  if (json is String) {
    return Video.fromJson(jsonDecode(json));
  }
  return Video.fromJson(json);
}

String videoModelToJson(Video video) =>
    jsonEncode(video.toJson());

class Video {
  int? index;
  String? codecName;
  String? codecLongName;
  String? profile;
  String? codecType;
  String? codecTagString;
  String? codecTag;
  int? width;
  int? height;
  int? codedWidth;
  int? codedHeight;
  int? closedCaptions;
  int? filmGrain;
  int? hasBFrames;
  String? sampleAspectRatio;
  String? displayAspectRatio;
  String? pixFmt;
  int? level;
  String? chromaLocation;
  String? fieldOrder;
  int? refs;
  String? isAvc;
  String? nalLengthSize;
  String? id;
  String? rFrameRate;
  String? avgFrameRate;
  String? timeBase;
  int? startPts;
  String? startTime;
  int? durationTs;
  String? duration;
  String? bitRate;
  String? bitsPerRawSample;
  String? nbFrames;
  int? extradataSize;
  Map<String, int>? disposition;
  Tags? tags;

  Video({
    this.index,
    this.codecName,
    this.codecLongName,
    this.profile,
    this.codecType,
    this.codecTagString,
    this.codecTag,
    this.width,
    this.height,
    this.codedWidth,
    this.codedHeight,
    this.closedCaptions,
    this.filmGrain,
    this.hasBFrames,
    this.sampleAspectRatio,
    this.displayAspectRatio,
    this.pixFmt,
    this.level,
    this.chromaLocation,
    this.fieldOrder,
    this.refs,
    this.isAvc,
    this.nalLengthSize,
    this.id,
    this.rFrameRate,
    this.avgFrameRate,
    this.timeBase,
    this.startPts,
    this.startTime,
    this.durationTs,
    this.duration,
    this.bitRate,
    this.bitsPerRawSample,
    this.nbFrames,
    this.extradataSize,
    this.disposition,
    this.tags,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    index: json["index"],
    codecName: json["codec_name"],
    codecLongName: json["codec_long_name"],
    profile: json["profile"],
    codecType: json["codec_type"],
    codecTagString: json["codec_tag_string"],
    codecTag: json["codec_tag"],
    width: json["width"],
    height: json["height"],
    codedWidth: json["coded_width"],
    codedHeight: json["coded_height"],
    closedCaptions: json["closed_captions"],
    filmGrain: json["film_grain"],
    hasBFrames: json["has_b_frames"],
    sampleAspectRatio: json["sample_aspect_ratio"],
    displayAspectRatio: json["display_aspect_ratio"],
    pixFmt: json["pix_fmt"],
    level: json["level"],
    chromaLocation: json["chroma_location"],
    fieldOrder: json["field_order"],
    refs: json["refs"],
    isAvc: json["is_avc"],
    nalLengthSize: json["nal_length_size"],
    id: json["id"],
    rFrameRate: json["r_frame_rate"],
    avgFrameRate: json["avg_frame_rate"],
    timeBase: json["time_base"],
    startPts: json["start_pts"],
    startTime: json["start_time"],
    durationTs: json["duration_ts"],
    duration: json["duration"],
    bitRate: json["bit_rate"],
    bitsPerRawSample: json["bits_per_raw_sample"],
    nbFrames: json["nb_frames"],
    extradataSize: json["extradata_size"],
    disposition: Map.from(json["disposition"])
        .map((k, v) => MapEntry<String, int>(k, v)),
    tags: json["tags"] != null ? Tags.fromJson(json["tags"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "codec_name": codecName,
    "codec_long_name": codecLongName,
    "profile": profile,
    "codec_type": codecType,
    "codec_tag_string": codecTagString,
    "codec_tag": codecTag,
    "width": width,
    "height": height,
    "coded_width": codedWidth,
    "coded_height": codedHeight,
    "closed_captions": closedCaptions,
    "film_grain": filmGrain,
    "has_b_frames": hasBFrames,
    "sample_aspect_ratio": sampleAspectRatio,
    "display_aspect_ratio": displayAspectRatio,
    "pix_fmt": pixFmt,
    "level": level,
    "chroma_location": chromaLocation,
    "field_order": fieldOrder,
    "refs": refs,
    "is_avc": isAvc,
    "nal_length_size": nalLengthSize,
    "id": id,
    "r_frame_rate": rFrameRate,
    "avg_frame_rate": avgFrameRate,
    "time_base": timeBase,
    "start_pts": startPts,
    "start_time": startTime,
    "duration_ts": durationTs,
    "duration": duration,
    "bit_rate": bitRate,
    "bits_per_raw_sample": bitsPerRawSample,
    "nb_frames": nbFrames,
    "extradata_size": extradataSize,
    "disposition": Map.from(disposition ?? {})
        .map((k, v) => MapEntry<String, dynamic>(k, v)),
    "tags": tags?.toJson(),
  };
}

class Tags {
  String? language;
  String? handlerName;
  String? vendorId;

  Tags({
    this.language,
    this.handlerName,
    this.vendorId,
  });

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
    language: json["language"],
    handlerName: json["handler_name"],
    vendorId: json["vendor_id"],
  );

  Map<String, dynamic> toJson() => {
    "language": language,
    "handler_name": handlerName,
    "vendor_id": vendorId,
  };
}