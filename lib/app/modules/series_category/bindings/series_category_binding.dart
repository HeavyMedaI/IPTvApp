import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/series_detail/controllers/series_detail_controller.dart';
import 'package:guek_iptv/app/modules/series_player_mediakit/controllers/series_player_mediakit_controller.dart';

import '../controllers/series_category_controller.dart';

class SeriesCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeriesCategoryController>(
          () => SeriesCategoryController(),
    );
    Get.lazyPut<SeriesDetailController>(
          () => SeriesDetailController(),
    );
    Get.lazyPut<SeriesPlayerMediakitController>(
          () => SeriesPlayerMediakitController(),
    );
  }
}
