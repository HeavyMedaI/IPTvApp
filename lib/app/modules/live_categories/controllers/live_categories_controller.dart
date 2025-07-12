import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/live_category.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';

class LiveCategoriesController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");

  RxList<LiveCategoryModel> liveCategories = RxList<LiveCategoryModel>();

  Future<void> loadCategories() async {
    try {
      liveCategories.value = await apiService.liveCategories(
          auth.session.value!.serverInfo!.getApiUrl(),
          auth.session.value!.username!,
          auth.session.value!.password!);
    } on Exception catch (e) {
      log("e: " + e.toString());
    }
  }

  void clear() {
    liveCategories.clear();
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
    //await this.loadCategories();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
