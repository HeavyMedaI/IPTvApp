import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/session.dart';
import 'package:guek_iptv/app/modules/live_categories/controllers/live_categories_controller.dart';
import 'package:guek_iptv/app/modules/live_category/controllers/live_category_controller.dart';
import 'package:guek_iptv/app/modules/login/controllers/login_controller.dart';
import 'package:guek_iptv/app/modules/series_categories/controllers/series_categories_controller.dart';
import 'package:guek_iptv/app/modules/series_category/controllers/series_category_controller.dart';
import 'package:guek_iptv/app/modules/vod_categories/controllers/vod_categories_controller.dart';
import 'package:guek_iptv/app/modules/vod_category/controllers/vod_category_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/app/services/onesignal_service.dart';
import 'package:guek_iptv/app/services/remote_config_service.dart';
import 'package:guek_iptv/app/widgets/common.dart';

class AccountController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  RemoteConfigService remoteConfig = Get.find(tag: "remote_config");

  RxBool dialogOpened = false.obs;

  void checkAlert() {
    if (auth.isLogged.isTrue && dialogOpened.isFalse && remoteConfig.versionValid.isTrue && remoteConfig.config.value!.alert != null) {
      dialogOpened.value = true;
      Timer(Duration(seconds: 1), () {
        showWarning(Get.context!, "Uyarı",
            remoteConfig.config.value!.alert!, okCallback: () {
              Get.back();
              dialogOpened.value = false;
            }, canPop: true);
      });
    }
  }

  void logout() async {
    Get.find<LiveCategoriesController>().clear();
    Get.find<LiveCategoryController>().clear();
    Get.find<VodCategoriesController>().clear();
    Get.find<VodCategoryController>().clear();
    Get.find<SeriesCategoriesController>().clear();
    Get.find<SeriesCategoryController>().clear();
    await Get.find<OneSignalService>(tag: "onesignal").logout();
    //this.storage.erase();
    //this.auth.session.value = SessionModel();
    this.storage.write("auth.is_logged", false);
    this.auth.isLogged.value = false;
    //Get.until((route) => Get.currentRoute == Routes.LOGIN);
    await Get.offAllNamed(Routes.LOGIN);
    Timer(
      Duration(seconds: 1),
          () {
        Get.find<LoginController>().onReady();
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    checkAlert();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
