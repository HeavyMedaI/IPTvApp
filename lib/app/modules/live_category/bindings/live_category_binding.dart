import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/live_player_mediakit/controllers/live_player_mediakit_controller.dart';

import '../controllers/live_category_controller.dart';

class LiveCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveCategoryController>(
      () => LiveCategoryController(),
    );
    Get.lazyPut<LivePlayerMediakitController>(
          () => LivePlayerMediakitController(),
    );
  }
}
