import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/series.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';

class SeriesCategoryController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");

  Size seriesCoverSize = Size(175, 250);

  RxList<SeriesModel> series = RxList<SeriesModel>();

  Future<void> loadSeries(dynamic categoryId) async {
    series.value = await apiService.serieslist(
        auth.session.value!.serverInfo!.getApiUrl(),
        auth.session.value!.username!,
        auth.session.value!.password!,
        categoryId);
  }

  void clear() {
    series.clear();
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
