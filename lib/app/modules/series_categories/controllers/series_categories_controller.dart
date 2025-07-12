import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/series_category.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';

class SeriesCategoriesController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");

  RxList<SeriesCategoryModel> seriesCategories = RxList<SeriesCategoryModel>();

  Future<void> loadCategories() async {
    seriesCategories.value = await apiService.seriesCategories(
        auth.session.value!.serverInfo!.getApiUrl(),
        auth.session.value!.username!,
        auth.session.value!.password!);
  }

  void clear() {
    seriesCategories.clear();
  }

  Future<void> reload() async {
    this.clear();
    await this.loadCategories();
  }

  @override
  void onInit() async {
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
