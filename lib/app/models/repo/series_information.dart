// To parse this JSON data, do
//
//     final seriesInfoModel = seriesInfoModelFromJson(jsonString);

import 'dart:convert';

SeriesInfoModelSuper seriesInfoModelFromJson(String str) =>
    SeriesInfoModelSuper.fromJson(json.decode(str));

String seriesInfoModelToJson(SeriesInfoModelSuper data) =>
    json.encode(data.toJson());

class SeriesInfoModelSuper {
  List<Season>? seasons;
  SeriesInfoModelInfo? info;
  Map<String, List<Episode>>? episodes;

  SeriesInfoModelSuper({
    this.seasons,
    this.info,
    this.episodes,
  });

  factory SeriesInfoModelSuper.fromJson(Map<String, dynamic> json) =>
      SeriesInfoModelSuper(
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        info: SeriesInfoModelInfo.fromJson(json["info"]),
        episodes: Map.from(json["episodes"]).map((k, v) =>
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
  String? id;
  String? episodeNum;
  String? title;
  String? containerExtension;
  dynamic info;
  List<dynamic>? subtitles;
  String? customSid;
  String? added;
  int? season;
  String? directSource;

  Episode({
    this.id,
    this.episodeNum,
    this.title,
    this.containerExtension,
    this.info,
    this.subtitles,
    this.customSid,
    this.added,
    this.season,
    this.directSource,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"],
        episodeNum: json["episode_num"],
        title: json["title"],
        containerExtension: json["container_extension"],
        info: json["info"],
        subtitles: List<dynamic>.from(json["subtitles"].map((x) => x)),
        customSid: json["custom_sid"],
        added: json["added"],
        season: json["season"],
        directSource: json["direct_source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "episode_num": episodeNum,
        "title": title,
        "container_extension": containerExtension,
        "info": info,
        "subtitles": List<dynamic>.from(subtitles?.map((x) => x) ?? []),
        "custom_sid": customSid,
        "added": added,
        "season": season,
        "direct_source": directSource,
      };
}

class InfoInfo {
  int? tmdbId;
  String? releaseDate;
  String? plot;
  int? durationSecs;
  String? duration;
  String? movieImage;
  int? bitrate;
  double? rating;
  int? season;
  String? coverBig;

  InfoInfo({
    this.tmdbId,
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

  factory InfoInfo.fromJson(Map<String, dynamic> json) => InfoInfo(
        tmdbId: json["tmdb_id"],
        releaseDate: json["release_date"],
        plot: json["plot"],
        durationSecs: json["duration_secs"],
        duration: json["duration"],
        movieImage: json["movie_image"],
        bitrate: json["bitrate"],
        rating: json["rating"].toDouble(),
        season: json["season"],
        coverBig: json["cover_big"],
      );

  Map<String, dynamic> toJson() => {
        "tmdb_id": tmdbId,
        "release_date": releaseDate,
        "plot": plot,
        "duration_secs": durationSecs,
        "duration": duration,
        "movie_image": movieImage,
        "bitrate": bitrate,
        "rating": rating,
        "season": season,
        "cover_big": coverBig,
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
        backdropPath: List<String>.from(json["backdrop_path"].map((x) => x)),
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
  String? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  int? seasonNumber;
  double? voteAverage;
  String? cover;
  String? coverBig;

  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
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
        name: json["name"],
        overview: json["overview"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"].toDouble(),
        cover: json["cover"],
        coverBig: json["cover_big"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
        "cover": cover,
        "cover_big": coverBig,
      };
}
