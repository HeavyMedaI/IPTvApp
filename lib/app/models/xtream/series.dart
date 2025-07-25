import 'dart:convert';

List<SeriesModel> seriesListModelFromJson(dynamic json) {
  if (json is String) {
    return List<SeriesModel>.from(
        jsonDecode(json).map((series) => seriesModelFromJson(series)));
  }
  return json.map((series) => seriesModelFromJson(series));
}

String seriesListModelToJson(List<SeriesModel> seriesList) => jsonEncode(
    List<String>.from(seriesList.map((series) => seriesModelToJson(series))));

SeriesModel seriesModelFromJson(dynamic json) {
  if (json is String) {
    return SeriesModel.fromJson(jsonDecode(json));
  }
  return SeriesModel.fromJson(json);
}

String seriesModelToJson(SeriesModel series) => jsonEncode(series.toJson());

class SeriesModel {
  int? num;
  String? name;
  dynamic cId;
  String? title;
  dynamic seriesId;
  String? cover;
  String? year;
  String? streamType;
  String? plot;
  String? cast;
  String? director;
  String? genre;
  String? releaseDate;
  String? seriesListModelReleaseDate;
  String? lastModified;
  dynamic rating;
  dynamic rating5Based;
  List<dynamic>? backdropPath;
  String? youtubeTrailer;
  String? episodeRunTime;
  String? categoryId;
  List<dynamic>? categoryIds;

  SeriesModel({
    this.num,
    this.name,
    this.cId,
    this.title,
    this.year,
    this.streamType,
    this.seriesListModelReleaseDate,
    this.seriesId,
    this.cover,
    this.plot,
    this.cast,
    this.director,
    this.genre,
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

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
        num: json["num"],
        name: json["name"],
        cId: json["c_id"],
        title: json["title"],
        year: json["year"],
        seriesListModelReleaseDate: json["release_date"],
        streamType: json["stream_type"],
        seriesId: json["series_id"],
        cover: json["cover"],
        plot: json["plot"],
        cast: json["cast"],
        director: json["director"],
        genre: json["genre"],
        releaseDate: json["releaseDate"],
        lastModified: json["last_modified"],
        rating: json["rating"],
        rating5Based: json["rating_5based"],
        backdropPath: json['backdrop_path'] == null
            ? null
            : List<dynamic>.from(json["backdrop_path"]?.map((x) => x) ?? []),
        youtubeTrailer: json["youtube_trailer"],
        episodeRunTime: json["episode_run_time"],
        categoryId: json["category_id"],
        //categoryIds: List<int>.from(json["category_ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "num": num,
        "name": name,
        "title": title,
        "year": year,
        "c_id": cId,
        "stream_type": streamType,
        "series_id": seriesId,
        "cover": cover,
        "plot": plot,
        "cast": cast,
        "director": director,
        "genre": genre,
        "releaseDate": releaseDate,
        "last_modified": lastModified,
        "rating": rating,
        "release_date": seriesListModelReleaseDate,
        "rating_5based": rating5Based,
        "backdrop_path": backdropPath == null
            ? jsonEncode([])
            : jsonEncode(List<dynamic>.from(backdropPath?.map((x) => x) ?? [])),
        "youtube_trailer": youtubeTrailer,
        "episode_run_time": episodeRunTime,
        "category_id": categoryId,
        "category_ids": categoryIds == null
            ? jsonEncode([])
            : jsonEncode(List<dynamic>.from(categoryIds?.map((x) => x) ?? [])),
      };
}
