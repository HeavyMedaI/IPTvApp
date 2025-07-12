import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/movie.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/constants/images.dart';

class VodCategoryController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");

  Size movieCoverSize = Size(175, 250);

  RxList<MovieModel> movies = RxList<MovieModel>();

  RxInt selectedMovieIndex = 0.obs;

  Future<void> loadMovies(dynamic categoryId) async {
    movies.value = await apiService.moviesList(
        auth.session.value!.serverInfo!.getApiUrl(),
        auth.session.value!.username!,
        auth.session.value!.password!,
        categoryId);
  }

  void clear() {
    movies.clear();
    selectedMovieIndex.value = 0;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
