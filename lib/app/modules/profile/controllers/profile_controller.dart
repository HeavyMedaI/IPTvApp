import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';

class ProfileController extends GetxController {

  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");

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
