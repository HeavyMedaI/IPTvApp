//import 'dart:ffi';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/movie.dart';
import 'package:guek_iptv/app/models/xtream/movie_details.dart';
import 'package:guek_iptv/app/modules/vod_category/controllers/vod_category_controller.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/constants/images.dart';

class VodDetailController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");
  VodCategoryController categoryController =
  Get.find<VodCategoryController>();

  Size relatedMovieCoverSize = Size(120, 160);

  RxBool movieLoaded = false.obs;
  Rx<MovieDetailsModel?> movie = Rx<MovieDetailsModel?>(null);
  RxList<Map<String, dynamic>> relatedMovies = RxList<Map<String, dynamic>>();

  //RxBool videoPlayer = false.obs;

  Future<void> loadMovie(dynamic stream_id) async {
    movie.value = await apiService.movieDetails(
        auth.session.value!.serverInfo!.getApiUrl(),
        auth.session.value!.username!,
        auth.session.value!.password!,
        stream_id);
    debugPrint("loadedMovie: " + movie.value!.info!.name!);
    movieLoaded.value = true;
  }

  Future<void> loadRelatedMovies(dynamic stream_id, {int count = 10}) async {
    this.relatedMovies.clear();
    int totalRelated = Get.find<VodCategoryController>().movies.length;
    List<int> ignore = <int>[int.parse(stream_id)];
    for (var i = 1; i <= count; i++) {
      int randomIndex = Random().nextInt(totalRelated);
      MovieModel randMovie = Get.find<VodCategoryController>().movies[randomIndex];
      //print("rand movie: " + randMovie.streamId!.toString());
      if(ignore.contains(randMovie.streamId!)) {
        continue;
      }
      relatedMovies.value.add({"index": randomIndex, "movie": randMovie});
      //print("movişe: " + Get.find<VodCategoryController>().movies[rand].runtimeType.toString());
    }
  }

  void clear() {
    movie.value = null;
    movieLoaded.value = false;
    //videoPlayer.value = false;
    //relatedMovies.clear();
  }

  @override
  void onInit() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.onInit();
  }

  @override
  void onReady() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
