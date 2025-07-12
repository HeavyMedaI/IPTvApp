import 'dart:convert';

List<MovieModel> moviesListModelFromJson(dynamic json) {
  if (json is String) {
    return List<MovieModel>.from(
        jsonDecode(json).map((movie) => movieModelFromJson(movie)));
  }
  return json.map((movie) => movieModelFromJson(movie));
}

String moviesListModelToJson(List<MovieModel> movieList) => jsonEncode(
    List<String>.from(movieList.map((movie) => movieModelToJson(movie))));

MovieModel movieModelFromJson(dynamic json) {
  if (json is String) {
    return MovieModel.fromJson(jsonDecode(json));
  }
  return MovieModel.fromJson(json);
}

String movieModelToJson(MovieModel movie) => jsonEncode(movie.toJson());

class MovieModel {
  int? num;
  String? name;
  String? title;
  dynamic cId;
  dynamic year;
  String? streamType;
  int? streamId;
  String? streamIcon;
  double? rating5Based;
  dynamic tmdb;
  dynamic trailer;
  String? added;
  dynamic plot;
  dynamic cast;
  dynamic director;
  dynamic genre;
  dynamic releaseDate;
  dynamic youtubeTrailer;
  dynamic episodeRunTime;
  int? categoryId;
  List<dynamic>? categoryIds;
  dynamic isAdult;
  String? containerExtension;
  dynamic customSid;
  dynamic directSource;
  double? rating;

  MovieModel({
    this.num,
    this.name,
    this.cId,
    this.title,
    this.year,
    this.streamType,
    this.streamId,
    this.streamIcon,
    this.rating,
    this.rating5Based,
    this.tmdb,
    this.trailer,
    this.added,
    this.plot,
    this.cast,
    this.isAdult,
    this.director,
    this.genre,
    this.releaseDate,
    this.youtubeTrailer,
    this.episodeRunTime,
    this.categoryId,
    this.categoryIds,
    this.containerExtension,
    this.customSid,
    this.directSource,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        num: json["num"],
        cId: json["c_id"],
        name: json["name"],
        title: json["title"],
        year: json["year"],
        streamType: json["stream_type"],
        streamId: json["stream_id"],
        streamIcon: json["stream_icon"],
        rating: double.tryParse(json["rating"].toString()),
        rating5Based: double.tryParse(json["rating_5based"].toString()),
        tmdb: json["tmdb"],
        trailer: json["trailer"],
        added: json["added"],
        plot: json["plot"],
        cast: json["cast"],
        director: json["director"],
        isAdult: json["added"],
        genre: json["genre"],
        releaseDate: json["release_date"],
        youtubeTrailer: json["youtube_trailer"],
        episodeRunTime: json["episode_run_time"],
        categoryId: int.tryParse(json["category_id"].toString()),
        categoryIds: json["category_ids"] != null
            ? List<int>.from(json["category_ids"].map((x) => x))
            : null,
        containerExtension: json["container_extension"],
        customSid: json["custom_sid"],
        directSource: json["direct_source"],
      );

  Map<String, dynamic> toJson() => {
        "num": num,
        "c_id": cId,
        "name": name,
        "title": title,
        "year": year,
        "stream_type": streamType,
        "stream_id": streamId,
        "stream_icon": streamIcon,
        "rating": rating,
        "rating_5based": rating5Based,
        "tmdb": tmdb,
        "trailer": trailer,
        "added": added,
        "plot": plot,
        "is_adult": isAdult,
        "cast": cast,
        "director": director,
        "genre": genre,
        "release_date": releaseDate,
        "youtube_trailer": youtubeTrailer,
        "episode_run_time": episodeRunTime,
        "category_id": categoryId,
        "category_ids": categoryIds == null
            ? jsonEncode([])
            : jsonEncode(List<dynamic>.from(categoryIds?.map((x) => x) ?? [])),
        "container_extension": containerExtension,
        "custom_sid": customSid,
        "direct_source": directSource,
      };
}
