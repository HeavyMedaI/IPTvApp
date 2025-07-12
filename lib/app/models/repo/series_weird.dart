// To parse this JSON data, do
//
//     final seriesInfoModel = seriesInfoModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

SeriesModel seriesInfoModelFromJson(String str) =>
    SeriesModel.fromJson(json.decode(str));

String seriesInfoModelToJson(SeriesModel data) =>
    json.encode(data.toJson());

class SeriesModel {
  List<Season>? seasons;
  SeriesInfoModelInfo? info;
  Map<String, List<Episode>>? episodes;

  SeriesModel({
    this.seasons,
    this.info,
    this.episodes,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) =>
      SeriesModel(
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        info: SeriesInfoModelInfo.fromJson(json["info"]),
        episodes: (json["episodes"]) == null ||
                (json["episodes"] is List<dynamic>)
            ? null
            : Map.from(json["episodes"]).map((k, v) =>
                MapEntry<String, List<Episode>>(
                    k, List<Episode>.from(v.map((x) => Episode.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "seasons": List<dynamic>.from(seasons?.map((x) => x.toJson()) ?? []),
        "info": info?.toJson(),
        "episodes": Map.from(episodes!).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class Episode {
  dynamic id;
  dynamic episodeNum;
  dynamic title;
  dynamic seriesid;
  dynamic releaseDate;
  dynamic containerExtension;
  EpisodeInfo? info;
  dynamic durationSecs;
  dynamic duration;
  dynamic movieImage;
  dynamic rating;
  dynamic coverBig;
  List<dynamic>? subtitles;
  dynamic customSid;
  dynamic added;
  dynamic season;
  dynamic directSource;

  Episode(
      {this.id,
      this.episodeNum,
      this.title,
      this.seriesid,
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

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"],
        episodeNum: json["episode_num"],
        title: json["title"],
        seriesid: json['series_id'],
        containerExtension: json["container_extension"],
        info:json["info"] == null ? null : (json["info"] is String)
            ? json["info"]
            : EpisodeInfo.fromJson(json["info"]),
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
        'series_id': seriesid,
        "container_extension": containerExtension,
        "info": ((info) is String) ? info : info?.toJson(),
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

class EpisodeInfo {
  Int? tmdbId;
  String? releaseDate;
  String? overview;
  String? crew;
  String? plot;
  Int? durationSecs;
  Int? duration;
  String? movieImage;
  Int? bitrate;
  double? rating;
  Int? season;
  String? coverBig;
  String? movieImageTmdb;

  EpisodeInfo({
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
    this.rating,
    this.season,
    this.coverBig,
  });

  factory EpisodeInfo.fromJson(Map<String, dynamic> json) => EpisodeInfo(
        tmdbId: json["tmdb_id"],
        releaseDate: json["release_date"],
        overview: json["overview"],
        crew: json["crew"],
        plot: json["plot"],
        movieImageTmdb: json["movie_image_tmdb"],
        durationSecs: json["duration_secs"],
        duration: json["duration"],
        movieImage: json["movie_image"],
        bitrate: json["bitrate"],
        rating: json["rating"],
        season: json["season"],
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
        "rating": rating,
        "season": season,
        "cover_big": coverBig,
        "movie_image_tmdb": movieImageTmdb,
      };
}

class SeriesInfoModelInfo {
  String? name;
  String? title;
  String? year;
  String? cover;
  String? plot;
  String? cast;
  String? director;
  String? genre;
  String? infoReleaseDate;
  String? releaseDate;
  String? lastModified;
  String? rating;
  dynamic rating5Based;
  List<String>? backdropPath;
  String? youtubeTrailer;
  String? episodeRunTime;
  String? categoryId;
  List<int>? categoryIds;

  SeriesInfoModelInfo({
    this.name,
    this.title,
    this.year,
    this.cover,
    this.plot,
    this.cast,
    this.director,
    this.genre,
    this.infoReleaseDate,
    this.releaseDate,
    this.lastModified,
    this.rating,
    this.rating5Based,
    this.backdropPath,
    this.youtubeTrailer,
    this.episodeRunTime,
    this.categoryId,
    this.categoryIds,
  });

  factory SeriesInfoModelInfo.fromJson(Map<String, dynamic> json) =>
      SeriesInfoModelInfo(
        name: json["name"],
        title: json["title"],
        year: json["year"],
        cover: json["cover"],
        plot: json["plot"],
        cast: json["cast"],
        director: json["director"],
        genre: json["genre"],
        infoReleaseDate: json["release_date"],
        releaseDate: json["releaseDate"],
        lastModified: json["last_modified"],
        rating: json["rating"],
        rating5Based: json["rating_5based"],
        backdropPath: json["backdrop_path"] == null
            ? null
            : List<String>.from(json["backdrop_path"].map((x) => x)),
        youtubeTrailer: json["youtube_trailer"],
        episodeRunTime: json["episode_run_time"],
        categoryId: json["category_id"],
        categoryIds: List<int>.from(json["category_ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "year": year,
        "cover": cover,
        "plot": plot,
        "cast": cast,
        "director": director,
        "genre": genre,
        "release_date": infoReleaseDate,
        "releaseDate": releaseDate,
        "last_modified": lastModified,
        "rating": rating,
        "rating_5based": rating5Based,
        "backdrop_path": List<dynamic>.from(backdropPath?.map((x) => x) ?? []),
        "youtube_trailer": youtubeTrailer,
        "episode_run_time": episodeRunTime,
        "category_id": categoryId,
        "category_ids": List<dynamic>.from(categoryIds?.map((x) => x) ?? []),
      };
}

class Season {
  dynamic airDate;
  dynamic episodeCount;
  dynamic id;
  dynamic seriesid;
  dynamic name;
  dynamic overview;
  dynamic seasonNumber;
  dynamic voteAverage;
  dynamic cover;
  dynamic coverBig;
  dynamic coverTmdb;
  dynamic duration;

  Season({
    this.airDate,
    this.duration,
    this.episodeCount,
    this.coverTmdb,
    this.id,
    this.name,
    this.seriesid,
    this.overview,
    this.seasonNumber,
    this.voteAverage,
    this.cover,
    this.coverBig,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate: json["air_date"],
        episodeCount: json["episode_count"],
        id: json["id"],
        coverTmdb: json["cover_tmdb"],
        seriesid: json["series_id"],
        duration: json["duration"],
        name: json["name"],
        overview: json["overview"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"],
        cover: json["cover"],
        coverBig: json["cover_big"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_count": episodeCount,
        'series_id': seriesid,
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
