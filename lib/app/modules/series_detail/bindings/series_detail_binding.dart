import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/series_player_mediakit/controllers/series_player_mediakit_controller.dart';

import '../controllers/series_detail_controller.dart';

class SeriesDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeriesDetailController>(
          () => SeriesDetailController(),
    );
    Get.lazyPut<SeriesPlayerMediakitController>(
          () => SeriesPlayerMediakitController(),
    );
  }
}
