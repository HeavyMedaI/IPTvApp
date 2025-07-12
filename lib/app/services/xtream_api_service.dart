import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diolib;
//import 'package:http/http.dart' as http;
import 'package:guek_iptv/app/models/xtream/channel.dart';
import 'package:guek_iptv/app/models/xtream/epg.dart';
import 'package:guek_iptv/app/models/xtream/live_category.dart';
import 'package:guek_iptv/app/models/xtream/movie_details.dart';
import 'package:guek_iptv/app/models/xtream/movies_category.dart';
import 'package:guek_iptv/app/models/xtream/movie.dart';
import 'package:guek_iptv/app/models/xtream/series.dart';
import 'package:guek_iptv/app/models/xtream/series_details.dart';
import 'package:guek_iptv/app/models/xtream/session.dart';
import 'package:guek_iptv/app/models/xtream/series_category.dart';
import 'package:guek_iptv/app/widgets/common.dart';

class XtreamApiService extends GetxService {
  late diolib.Dio dio;
  //late http.Client client;

  Future<XtreamApiService> init() async {
    dio = diolib.Dio();
    //client = http.Client();
    // diolib.interceptors.add(
    //   PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     compact: false,
    //   ),
    // );
    return this;
  }

  diolib.Options optHeaders = diolib.Options(headers: <String, dynamic>{
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    "Access-Control-Allow-Credentials":
        true, // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  });

  Future<SessionModel?> loginAsync(
      String url, String username, String password) async {
    SessionModel? sessionModel;
    String getSession =
        '$url/player_api.php?username=$username&password=$password';
    log("session url: " + getSession);

    diolib.Response response = await dio.get(
      getSession,
      options: optHeaders,
    );

    try {
      if (response.statusCode == 200) {
        debugPrint("Login apiservice:===>${response.data}");
        return SessionModel.fromJson(response.data);
      } else if (response.statusCode == 404) {
        //showToast("Lütfen bilgilerinizi kontrol ediniz");
        throw Exception('Oturum açılamadı, giriş bilgileri yanlış');
      }
    } on Exception catch (e) {
      throw e;
    }

    debugPrint("${response.data}");
    return sessionModel;
  }

  Future<List<MovieCategoryModel>> movieCategories(
      String url, String username, String password) async {
    String getCategory =
        "$url/player_api.php?password=$password&username=$username&action=get_vod_categories";
    diolib.Response<String> response = await dio.get(
      getCategory,
      options: optHeaders,
    );

    if (response.statusCode == 200) {
      return moviesCategoryModelListFromJson(response.data ?? []);
    } else {
      showToast("Please Login Your Account");
      //  Navigator.push(context, route)
      return [];
    }
  }

  Future<List<MovieModel>> moviesList(
      String url, String username, String password, String categoryId) async {
    debugPrint("Yor categoryId is ===>> $categoryId");
    String getMoviesUrl =
        "$url/player_api.php?username=$username&password=$password&action=get_vod_streams&category_id=$categoryId";
    debugPrint("getMoviesUrl is ===>> $getMoviesUrl");
    diolib.Response<String> response = await dio.get(
      getMoviesUrl,
      options: optHeaders,
    );
    if (response.statusCode == 200) {
      return moviesListModelFromJson(response.data ?? []);
    } else {
      return [];
    }
  }

  Future<MovieDetailsModel> movieDetails(
      String url, String username, String password, streamID) async {
    String getMoviesDetailsUrl =
        "$url/player_api.php?username=$username&password=$password&action=get_vod_info&vod_id=$streamID";

    diolib.Response response = await dio.get(
      getMoviesDetailsUrl,
      options: optHeaders,
    );

    log("movie details url: " + getMoviesDetailsUrl);

    return movieDetailsModelFromJson(response.data);
  }

  Future<List<SeriesCategoryModel>> seriesCategories(
      String url, String username, String password) async {
    String getCategory =
        "$url/player_api.php?password=$password&username=$username&action=get_series_categories";

    log("series url: " + getCategory);
    diolib.Response<String> response = await dio.get(
      getCategory,
      options: optHeaders,
    );
    log("series category link == $getCategory");

    if (response.statusCode == 200) {
      return seriesCategoryModelListFromJson(response.data ?? []);
    } else {
      return [];
    }
  }

  Future<List<SeriesModel>> serieslist(
      String url, String username, String password, String categoryId) async {
    String getSeriesUrl =
        "$url/player_api.php?username=$username&password=$password&action=get_series&category_id=$categoryId";

    diolib.Response<String> response = await dio.get(
      getSeriesUrl,
      options: optHeaders,
    );
    debugPrint("getMoviesUrl $getSeriesUrl");

    if (response.statusCode == 200) {
      return seriesListModelFromJson(response.data ?? []);
    } else {
      return [];
    }
  }

  Future<SeriesModel> seriesInfo(
      String url, String password, String username, seriesid) async {
    String getSeries =
        '$url/player_api.php?&password=$password&username=$username&action=get_series_info&series_id=$seriesid';
    diolib.Response response = await dio.get(
      getSeries,
      options: optHeaders,
    );
    log("SeriesInfoUrl  $getSeries");
    debugPrint("${response.data}");
    return seriesModelFromJson(response.data);
  }

  Future<SeriesDetailsModel> seriesDetails(
      String url, String username, String password, seriesid) async {
    SeriesDetailsModel seriesDetails;
    String getSeriesDetails =
        '$url/player_api.php?&password=$password&username=$username&action=get_series_info&series_id=$seriesid';
    log("getSeriesDetails url:  $getSeriesDetails");
    diolib.Response response = await dio.get(
      getSeriesDetails,
      options: optHeaders,
    );
    debugPrint("seriesDetails: ${response.data}");
    return seriesDetailsModelFromJson(response.data);
  }

  Future<List<LiveCategoryModel>> liveCategories(
      String url, String username, String password) async {
    String getCategory =
        "$url/player_api.php?&password=$password&username=$username&action=get_live_categories";
    diolib.Response<String> response = await dio.get(
      getCategory,
      options: optHeaders,
    );

    log("live category link == $getCategory");

    if (response.statusCode == 200) {
      return liveCategoryModelListFromJson(response.data ?? []);
    } else {
      return [];
    }
  }

  Future<List<ChannelModel>> liveChannels(
      String url, String username, String password, String categoryId) async {
    String getLiveUrl =
        "$url/player_api.php?password=$password&username=$username&action=get_live_streams&category_id=$categoryId";
    debugPrint("getLiveUrl $getLiveUrl");

    diolib.Response<String> response = await dio.get(
      getLiveUrl,
      options: optHeaders,
    );

    if (response.statusCode == 200) {
      return channelModelListFromJson(response.data ?? []);
    } else {
      return [];
    }
  }

  Future<List<Epg?>> epgDataTable(
      String url, String username, String password, streamID) async {
    String getEpgDataTableUrl =
        "$url/player_api_v2.php?username=$username&password=$password&action=get_simple_data_table&stream_id=$streamID";
    log("epg get_epg_simple_table url: " + getEpgDataTableUrl);

    diolib.Response response = await dio.get(
      getEpgDataTableUrl,
      options: optHeaders,
    );

    if (response.statusCode == 200) {
      if (response.data["epg_listings"] == null ||
          response.data["epg_listings"].length == 0) {
        return [];
      }
      return epgModelListFromJson(response.data["epg_listings"]);
    } else {
      return [];
    }
  }
}
