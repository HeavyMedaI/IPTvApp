import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/splash/controllers/splash_controller.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(XtreamAuthenticationService(), tag: "auth");
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
