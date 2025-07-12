import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/movies_category.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';

class VodCategoriesController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");

  RxList<MovieCategoryModel> movieCategories = RxList<MovieCategoryModel>();

  Future<void> loadCategories() async {
    try {
      movieCategories.value = await apiService.movieCategories(
          auth.session.value!.serverInfo!.getApiUrl(),
          auth.session.value!.username!,
          auth.session.value!.password!);
    } on Exception catch (e) {
      log("e: " + e.toString());
    }
  }

  void clear() {
    movieCategories.clear();
  }

  Future<void> reload() async {
    this.clear();
    await this.loadCategories();
  }

  @override
  Future<void> onInit() async {
    await this.loadCategories();
    super.onInit();
  }

  @override
  void onReady() async {
    //await loadCategories();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
