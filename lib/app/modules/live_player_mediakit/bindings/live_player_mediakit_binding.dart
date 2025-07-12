import 'package:get/get.dart';

import '../controllers/live_player_mediakit_controller.dart';

class LivePlayerMediakitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LivePlayerMediakitController>(
      () => LivePlayerMediakitController(),
    );
  }
}
