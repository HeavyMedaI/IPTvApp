import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/series_details.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';

class SeriesDetailController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");

  //RxInt onSeason = 0.obs;
  late TabController tabController;

  RxBool seriesLoaded = false.obs;
  Rx<SeriesDetailsModel?> series = Rx<SeriesDetailsModel?>(null);

  RxInt selectedSeasonIndex = 0.obs;
  RxInt selectedSeasonNumber = 0.obs;
  RxInt selectedEpisodeIndex = 0.obs;

  //RxBool seriesPlayer = false.obs;

  Future<void> loadSeries(dynamic series_id) async {
    series.value = await apiService.seriesDetails(
        auth.session.value!.serverInfo!.getApiUrl(),
        auth.session.value!.username!,
        auth.session.value!.password!,
        series_id);
    seriesLoaded.value = true;
    //log("seasons: " + series.value!.seasons!.toString());
  }

  void clear() {
    series.value = null;
    //seriesPlayer.value = false;
    seriesLoaded.value = false;
    //onSeason.value = 0;
    selectedSeasonIndex.value = 0;
    selectedEpisodeIndex.value = 0;
  }

  @override
  void onInit() {
    super.onInit();
    //tabController = TabController(length: 5, vsync: TickerProvider);
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
