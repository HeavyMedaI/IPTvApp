import 'dart:convert';

import 'package:guek_iptv/app/models/xtream/video.dart';

MovieDetailsModel movieDetailsModelFromJson(dynamic json) {
  if (json is String) {
    return MovieDetailsModel.fromJson(jsonDecode(json));
  }
  return MovieDetailsModel.fromJson(json);
}

String movieDetailsModelToJson(MovieDetailsModel movieDetails) =>
    jsonEncode(movieDetails.toJson());

class MovieDetailsModel {
  Info? info;
  MovieData? movieData;

  MovieDetailsModel({
    this.info,
    this.movieData,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailsModel(
        info: Info.fromJson(json["info"]),
        movieData: MovieData.fromJson(json["movie_data"]),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "movie_data": movieData?.toJson(),
      };
}

class Info {
  String? tmdbId;
  String? name;
  int? streamId;
  String? containerExtension;
  String? oName;
  String? coverBig;
  String? movieImage;
  String? releasedate;
  String? youtubeTrailer;
  String? director;
  String? actors;
  String? cast;
  String? description;
  String? plot;
  String? age;
  String? country;
  String? genre;
  List<dynamic>? backdropPath;
  dynamic durationSecs;
  String? duration;
  Video? video;
  Audio? audio;
  int? bitrate;
  String? rating;
  String? status;
  String? runtime;

  Info({
    this.tmdbId,
    this.containerExtension,
    this.streamId,
    this.name,
    this.oName,
    this.coverBig,
    this.movieImage,
    this.releasedate,
    this.youtubeTrailer,
    this.director,
    this.actors,
    this.cast,
    this.description,
    this.plot,
    this.age,
    this.country,
    this.genre,
    this.backdropPath,
    this.durationSecs,
    this.duration,
    this.video,
    this.audio,
    this.bitrate,
    this.rating,
    this.status,
    this.runtime,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        tmdbId: json["tmdb_id"].toString(),
        name: json["name"],
        oName: json["o_name"],
        coverBig: json["cover_big"],
        movieImage: json["movie_image"],
        releasedate: json["releasedate"],
        youtubeTrailer: json["youtube_trailer"],
        director: json["director"],
        actors: json["actors"],
        cast: json["cast"],
        description: json["description"],
        plot: json["plot"],
        age: json["age"],
        country: json["country"],
        genre: json["genre"],
        backdropPath: json["backdrop_path"] == null
            ? null
            : List<dynamic>.from(json["backdrop_path"].map((x) => x)),
        durationSecs: json["duration_secs"],
        duration: json["duration"],
        video: json["video"] != null && json["video"] is Map
            ? videoModelFromJson(json["video"])
            : null,
        audio: json["audio"] != null
            ? (json["audio"] is Map ? Audio.fromJson(json["audio"]) : null)
            : null,
        bitrate: json["bitrate"],
        containerExtension: json["container_extension"],
        rating: json["rating"].toString(),
        status: json["status"],
        runtime: json["runtime"],
        streamId: json["stream_id"],
      );

  Map<String, dynamic> toJson() => {
        "tmdb_id": tmdbId,
        "name": name,
        "o_name": oName,
        "cover_big": coverBig,
        "movie_image": movieImage,
        "releasedate": releasedate,
        "youtube_trailer": youtubeTrailer,
        "director": director,
        "actors": actors,
        "cast": cast,
        "description": description,
        "plot": plot,
        "age": age,
        "country": country,
        "genre": genre,
        "backdrop_path": List<dynamic>.from(backdropPath?.map((x) => x) ?? []),
        "duration_secs": durationSecs,
        "duration": duration,
        "video": video?.toJson(),
        "audio": audio?.toJson(),
        "bitrate": bitrate,
        "rating": rating,
        "status": status,
        "runtime": runtime,
        "stream_id": streamId,
        "container_extension": containerExtension,
      };
}

class Audio {
  int? index;
  String? codecName;
  String? codecLongName;
  String? profile;
  String? codecType;
  String? codecTagString;
  String? codecTag;
  String? sampleFmt;
  String? sampleRate;
  int? channels;
  String? channelLayout;
  int? bitsPerSample;
  String? id;
  String? rFrameRate;
  String? avgFrameRate;
  String? timeBase;
  int? startPts;
  String? startTime;
  int? durationTs;
  String? duration;
  String? bitRate;
  String? nbFrames;
  int? extradataSize;
  Map<String, int>? disposition;
  Tags? tags;

  Audio({
    this.index,
    this.codecName,
    this.codecLongName,
    this.profile,
    this.codecType,
    this.codecTagString,
    this.codecTag,
    this.sampleFmt,
    this.sampleRate,
    this.channels,
    this.channelLayout,
    this.bitsPerSample,
    this.id,
    this.rFrameRate,
    this.avgFrameRate,
    this.timeBase,
    this.startPts,
    this.startTime,
    this.durationTs,
    this.duration,
    this.bitRate,
    this.nbFrames,
    this.extradataSize,
    this.disposition,
    this.tags,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        index: json["index"],
        codecName: json["codec_name"],
        codecLongName: json["codec_long_name"],
        profile: json["profile"],
        codecType: json["codec_type"],
        codecTagString: json["codec_tag_string"],
        codecTag: json["codec_tag"],
        sampleFmt: json["sample_fmt"],
        sampleRate: json["sample_rate"],
        channels: json["channels"],
        channelLayout: json["channel_layout"],
        bitsPerSample: json["bits_per_sample"],
        id: json["id"],
        rFrameRate: json["r_frame_rate"],
        avgFrameRate: json["avg_frame_rate"],
        timeBase: json["time_base"],
        startPts: json["start_pts"],
        startTime: json["start_time"],
        durationTs: json["duration_ts"],
        duration: json["duration"],
        bitRate: json["bit_rate"],
        nbFrames: json["nb_frames"],
        extradataSize: json["extradata_size"],
        disposition: json["disposition"] != null ? Map.from(json["disposition"]) :{}
            .map((k, v) => MapEntry<String, int>(k, v)),
        tags: json["tags"] != null ? Tags.fromJson(json["tags"]) :null,
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "codec_name": codecName,
        "codec_long_name": codecLongName,
        "profile": profile,
        "codec_type": codecType,
        "codec_tag_string": codecTagString,
        "codec_tag": codecTag,
        "sample_fmt": sampleFmt,
        "sample_rate": sampleRate,
        "channels": channels,
        "channel_layout": channelLayout,
        "bits_per_sample": bitsPerSample,
        "id": id,
        "r_frame_rate": rFrameRate,
        "avg_frame_rate": avgFrameRate,
        "time_base": timeBase,
        "start_pts": startPts,
        "start_time": startTime,
        "duration_ts": durationTs,
        "duration": duration,
        "bit_rate": bitRate,
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

class MovieData {
  int? streamId;
  String? name;
  String? added;
  String? categoryId;
  List<int>? categoryIds;
  String? containerExtension;
  dynamic customSid;
  String? directSource;

  MovieData({
    this.name,
    this.added,
    this.categoryId,
    this.categoryIds,
    this.containerExtension,
    this.streamId,
    this.customSid,
    this.directSource,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) => MovieData(
        streamId: json["stream_id"],
        name: json["name"],
        added: json["added"],
        categoryId: json["category_id"],
        categoryIds: json["category_ids"] != null
            ? List<int>.from(json["category_ids"].map((x) => x))
            : null,
        containerExtension: json["container_extension"],
        customSid: json["custom_sid"],
        directSource: json["direct_source"],
      );

  Map<String, dynamic> toJson() => {
        "stream_id": streamId,
        "name": name,
        "added": added,
        "category_id": categoryId,
        "category_ids": List<dynamic>.from(categoryIds?.map((x) => x) ?? []),
        "container_extension": containerExtension,
        "custom_sid": customSid,
        "direct_source": directSource,
      };
}
