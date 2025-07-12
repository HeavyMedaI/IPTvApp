import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/modules/live_categories/controllers/live_categories_controller.dart';
import 'package:guek_iptv/app/modules/login/controllers/login_controller.dart';
import 'package:guek_iptv/app/modules/main/controllers/main_controller.dart';
import 'package:guek_iptv/app/modules/series_categories/controllers/series_categories_controller.dart';
import 'package:guek_iptv/app/modules/splash/controllers/splash_controller.dart';
import 'package:guek_iptv/app/modules/vod_categories/controllers/vod_categories_controller.dart';
import 'package:guek_iptv/app/services/api_service.dart';
import 'package:guek_iptv/app/services/authentication_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/app/services/onesignal_service.dart';
import 'package:guek_iptv/app/services/remote_config_service.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/widgets/common.dart';
import 'package:guek_iptv/firebase_options.dart';
import 'package:media_kit/media_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    //Get.lazyPut<XtreamApiService>(() => XtreamApiService(), tag: "xtream_api");
    //Get.lazyPut<AuthenticationService>(() => AuthenticationService(), tag: "auth");
    Get.put(ApiService(), tag: "api");
    Get.put(XtreamApiService(), tag: "xtream_api");
    Get.put(RemoteConfigService(), tag: "remote_config");
    Get.put(AuthenticationService(), tag: "auth");
    Get.put(XtreamAuthenticationService(), tag: "xtream_auth");
    Get.put(OneSignalService(), tag: "onesignal");

    await GetStorage.init();
    await Get.find<ApiService>(tag: "api").init();
    await Get.find<XtreamApiService>(tag: "xtream_api").init();
    await Get.find<RemoteConfigService>(tag: "remote_config").init();
    await Get.find<RemoteConfigService>(tag: "remote_config").loadConfig();

    //testing
    Get.find<RemoteConfigService>(tag: "remote_config").config.value!.onesignal_app_id = "b82ab9c7-6957-40c8-9f5f-6cb8b4623744";

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    /*OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("b82ab9c7-6957-40c8-9f5f-6cb8b4623744");
    await OneSignal.Notifications.requestPermission(true);*/

    await Get.find<OneSignalService>(tag: "onesignal").init(askConsent: false);
    await Get.find<OneSignalService>(tag: "onesignal").start(
        Get.find<RemoteConfigService>(tag: "remote_config").config.value!.onesignal_app_id!,
        askPermission: true,
        inAppMessages: false);
    await Get.find<OneSignalService>(tag: "onesignal").consent(true);

    MediaKit.ensureInitialized();

    /*Get.lazyPut<HomeController>(
          () => HomeController(),
    );*/

    Get.put(SplashController());
    Get.put(LoginController());

    Get.lazyPut<VodCategoriesController>(
      () => VodCategoriesController(),
    );
    Get.lazyPut<SeriesCategoriesController>(
      () => SeriesCategoriesController(),
    );
    Get.lazyPut<LiveCategoriesController>(
      () => LiveCategoriesController(),
    );
    Get.lazyPut<MainController>(() => MainController(), tag: "main");
  }
}
