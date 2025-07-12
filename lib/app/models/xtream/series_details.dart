import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:guek_iptv/app/models/xtream/series.dart';
import 'package:guek_iptv/app/models/xtream/video.dart';

SeriesDetailsModel seriesDetailsModelFromJson(dynamic json) {
  if (json is String) {
    return SeriesDetailsModel.fromJson(jsonDecode(json));
  }
  return SeriesDetailsModel.fromJson(json);
}

String seriesDetailsModelToJson(SeriesDetailsModel seriesDetails) =>
    jsonEncode(seriesDetails.toJson());

class SeriesDetailsModel {
  SeriesModel? info;
  List<SeasonModel>? seasons;
  Map<String, List<EpisodeModel>>? episodes;

  SeriesDetailsModel({
    this.seasons,
    this.info,
    this.episodes,
  });

  factory SeriesDetailsModel.fromJson(Map<String, dynamic> json) =>
      SeriesDetailsModel(
        info: seriesModelFromJson(json["info"]),
        seasons: seasonModelListFromJson(json["seasons"]),
        episodes:
            (json["episodes"]) == null || (json["episodes"] is List<dynamic>)
                ? null
                : Map.from(json["episodes"]).map((k, v) =>
                    MapEntry<String, List<EpisodeModel>>(
                        k, episodeModelListFromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "info": seriesModelToJson(info!),
        "seasons": seasonModelListToJson(seasons!),
        "episodes": Map.from(episodes!).map(
            (k, v) => MapEntry<String, dynamic>(k, episodeModelListToJson(v))),
      };
}

List<EpisodeModel> episodeModelListFromJson(dynamic json) {
  if (json is String) {
    return List<EpisodeModel>.from(
        jsonDecode(json).map((episode) => episodeModelFromJson(episode)));
  }
  return List<EpisodeModel>.from(json.map((season) => episodeModelFromJson(season)));
}

String episodeModelListToJson(List<EpisodeModel> episodeList) =>
    jsonEncode(List<String>.from(
        episodeList.map((episode) => episodeModelToJson(episode))));

EpisodeModel episodeModelFromJson(dynamic json) {
  if (json is String) {
    return EpisodeModel.fromJson(jsonDecode(json));
  }
  return EpisodeModel.fromJson(json);
}

String episodeModelToJson(EpisodeModel episode) => jsonEncode(episode.toJson());

class EpisodeModel {
  String? id;
  int? episodeNum;
  String? title;
  int? seriesId;
  String? releaseDate;
  String? containerExtension;
  EpisodeInfoModel? info;
  int? durationSecs;
  String? duration;
  String? movieImage;
  double? rating;
  String? coverBig;
  List<dynamic>? subtitles;
  String? customSid;
  String? added;
  int? season;
  String? directSource;

  EpisodeModel(
      {this.id,
      this.episodeNum,
      this.title,
      this.seriesId,
      this.containerExtension,
      this.info,
      this.subtitles,
      this.customSid,
      this.added,
      this.season,
      this.directSource,
      this.coverBig,
      this.duration,
      this.durationSecs,
      this.movieImage,
      this.rating,
      this.releaseDate});

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        episodeNum: json["episode_num"],
        title: json["title"],
        seriesId: json['series_id']??null,
        containerExtension: json["container_extension"],
        info: (json["info"] == null || json["info"].runtimeType != Map<String, dynamic>)
            ? null
            : episodeInfoModelFromJson(json["info"]),
        subtitles: json["subtitles"] == null
            ? null
            : List<dynamic>.from(json["subtitles"].map((x) => x)),
        customSid: json["custom_sid"],
        added: json["added"],
        season: json["season"],
        directSource: json["direct_source"],
        releaseDate: json["release_date"],
        durationSecs: json["duration_secs"],
        duration: json["duration"],
        movieImage: json["movie_image"],
        rating: json["rating"],
        coverBig: json["cover_big"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "episode_num": episodeNum,
        "title": title,
        'series_id': seriesId,
        "container_extension": containerExtension,
        "info": info == null ? {} : episodeInfoModelToJson(info!),
        "subtitles": subtitles == null
            ? jsonEncode([])
            : jsonEncode(List<dynamic>.from(subtitles?.map((x) => x) ?? [])),
        "custom_sid": customSid,
        "added": added,
        "season": season,
        "direct_source": directSource,
        "release_date": releaseDate,
        "duration_secs": durationSecs,
        "duration": duration,
        "movie_image": movieImage,
        "rating": rating,
        "cover_big": coverBig,
      };
}

EpisodeInfoModel episodeInfoModelFromJson(dynamic json) {
  if (json is String) {
    return EpisodeInfoModel.fromJson(jsonDecode(json));
  }
  return EpisodeInfoModel.fromJson(json);
}

String episodeInfoModelToJson(EpisodeInfoModel episodeInfo) =>
    jsonEncode(episodeInfo.toJson());

class EpisodeInfoModel {
  int? tmdbId;
  String? releaseDate;
  String? overview;
  String? crew;
  String? plot;
  int? durationSecs;
  String? duration;
  String? movieImage;
  int? bitrate;
  Video? video;
  double? rating;
  String? season;
  String? coverBig;
  String? movieImageTmdb;

  EpisodeInfoModel({
    this.tmdbId,
    this.overview,
    this.movieImageTmdb,
    this.crew,
    this.releaseDate,
    this.plot,
    this.durationSecs,
    this.duration,
    this.movieImage,
    this.bitrate,
    this.video,
    this.rating,
    this.season,
    this.coverBig,
  });

  factory EpisodeInfoModel.fromJson(Map<String, dynamic> json) =>
      EpisodeInfoModel(
        tmdbId: int.tryParse(json["tmdb_id"].toString()),
        releaseDate: json["release_date"],
        overview: json["overview"],
        crew: json["crew"],
        plot: json["plot"],
        movieImageTmdb: json["movie_image_tmdb"],
        durationSecs: json["duration_secs"],
        duration: json["duration"],
        movieImage: json["movie_image"],
        bitrate: json["bitrate"],
        video: (json["video"] != null && !json["video"].isEmpty) ? videoModelFromJson(json["video"]) :null,
        rating: double.tryParse(json["rating"].toString()),
        season: json["season"].toString(),
        coverBig: json["cover_big"],
      );

  Map<String, dynamic> toJson() => {
        "tmdb_id": tmdbId,
        "release_date": releaseDate,
        "overview": overview,
        "crew": crew,
        "plot": plot,
        "duration_secs": durationSecs,
        "duration": duration,
        "movie_image": movieImage,
        "bitrate": bitrate,
        "bitrate": video == null ? {} : videoModelToJson(video!),
        "rating": rating,
        "season": season,
        "cover_big": coverBig,
        "movie_image_tmdb": movieImageTmdb,
      };
}

List<SeasonModel> seasonModelListFromJson(dynamic json) {
  if (json is String) {
    return List<SeasonModel>.from(
        jsonDecode(json).map((season) => seasonModelFromJson(season)));
  }
  return List<SeasonModel>.from(json.map((season) => seasonModelFromJson(season)));
}

String seasonModelListToJson(List<SeasonModel> seasonList) => jsonEncode(
    List<String>.from(seasonList.map((season) => seasonModelToJson(season))));

SeasonModel seasonModelFromJson(dynamic json) {
  if (json is String) {
    return SeasonModel.fromJson(jsonDecode(json));
  }
  return SeasonModel.fromJson(json);
}

String seasonModelToJson(SeasonModel season) => jsonEncode(season.toJson());

class SeasonModel {
  String? airDate;
  int? episodeCount;
  int? id;
  dynamic? seriesId;
  String? name;
  String? overview;
  int? seasonNumber;
  double? voteAverage;
  String? cover;
  String? coverBig;
  String? coverTmdb;
  String? duration;

  SeasonModel({
    this.airDate,
    this.duration,
    this.episodeCount,
    this.coverTmdb,
    this.id,
    this.name,
    this.seriesId,
    this.overview,
    this.seasonNumber,
    this.voteAverage,
    this.cover,
    this.coverBig,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        airDate: json["air_date"],
        episodeCount: json["episode_count"],
        id: json["id"],
        coverTmdb: json["cover_tmdb"],
        seriesId: json["series_id"],
        duration: json["duration"],
        name: json["name"],
        overview: json["overview"],
        seasonNumber: json["season_number"],
        voteAverage: double.parse(json["vote_average"].toString()),
        cover: json["cover"],
        coverBig: json["cover_big"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_count": episodeCount,
        'series_id': seriesId,
        "id": id,
        "cover_tmdb": coverTmdb,
        "name": name,
        "overview": overview,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
        "cover": cover,
        "cover_big": coverBig,
        "duration": duration,
      };
}
