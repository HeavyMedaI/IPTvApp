import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/modules/account/views/account_view.dart';
import 'package:guek_iptv/app/modules/live_categories/views/live_categories_view.dart';

//import 'package:guek_iptv/app/modules/global/bottom_navigation/controllers/bottom_navigation_controller.dart';
//import 'package:guek_iptv/app/modules/home/views/home_view.dart';
//import 'package:guek_iptv/app/modules/profile/views/profile_view.dart';
import 'package:guek_iptv/app/modules/series_categories/views/series_categories_view.dart';
import 'package:guek_iptv/app/modules/vod_categories/views/vod_categories_view.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/app/services/onesignal_service.dart';
import 'package:guek_iptv/app/services/remote_config_service.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/widgets/common.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:guek_iptv/screen/bottom/IPTvAppSpecial/light_star_special.dart';
//import 'package:guek_iptv/screen/bottom/movies/movies_screen.dart';

class MainController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");
  RemoteConfigService remoteConfig = Get.find(tag: "remote_config");

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double appBarHeight = 50.0;
  double bottomHeight = 75.0;

  //BottomNavigationController bottomNav = Get.find<BottomNavigationController>();

  RxString pageTitle = "Profilim".obs;
  RxInt pageIndex = 4.obs;

  final pages = [
    LiveCategoriesView(),
    VodCategoriesView(),
    SeriesCategoriesView(),
    AccountView(),
  ];

  @override
  void onInit() {
    pageIndex.value = 3;
    if (remoteConfig.versionValid.isFalse) {
      Timer(Duration(seconds: 1), () {
        showWarning(Get.context!, "Uyarı",
            "Yeni bir versiyon mevcut, lütfen uygulamayı güncelleyin.",
            okText: "GÜNCELLE", canPop: false, okCallback: () async {
          Uri downloadUri =
              Uri.parse(remoteConfig.config.value!.latest_apk_url!);
          if (await canLaunchUrl(downloadUri)) {
            await launchUrl(downloadUri, mode: LaunchMode.externalApplication);
          }
        });
      });
    }
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    pageIndex.value = 3;
    await Get.find<OneSignalService>(tag: "onesignal").login("524159f3-0afe-4b85-b2f3-05a08a113a58");
    super.onReady();
  }

  @override
  void onClose() {
    pageIndex.value = 3;
    super.onClose();
  }

  @override
  void dispose() {
    pageIndex.value = 3;
    super.dispose();
  }
}
