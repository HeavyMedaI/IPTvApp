import 'package:get/get.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/services/authentication_service.dart';

class SplashController extends GetxController {
  AuthenticationService auth = Get.find(tag: "auth");

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    if(auth.isLogged.isTrue) {
      Get.toNamed(Routes.MAIN);
    }else{
      Get.toNamed(Routes.LOGIN);
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
