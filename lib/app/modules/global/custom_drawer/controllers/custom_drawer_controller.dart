import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:guek_iptv/app/models/xtream/user_info.dart';
import 'package:guek_iptv/app/modules/global/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';

class CustomDrawerController extends GetxController {
  RxBool wifi = true.obs;

  XtreamAuthenticationService auth = Get.find(tag: "auth");
  BottomNavigationController bottomNav = Get.find<BottomNavigationController>();

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
