import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/movie_player_mediakit/controllers/movie_player_mediakit_controller.dart';
import 'package:guek_iptv/app/modules/vod_detail/controllers/vod_detail_controller.dart';

import '../controllers/vod_category_controller.dart';

class VodCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VodCategoryController>(
      () => VodCategoryController(),
    );
    Get.lazyPut<VodDetailController>(
          () => VodDetailController(),
    );
    Get.lazyPut<MoviePlayerMediakitController>(
          () => MoviePlayerMediakitController(),
    );
  }
}
