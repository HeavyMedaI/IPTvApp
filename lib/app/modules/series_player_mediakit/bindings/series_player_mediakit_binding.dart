import 'package:get/get.dart';

import '../controllers/series_player_mediakit_controller.dart';

class SeriesPlayerMediakitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeriesPlayerMediakitController>(
      () => SeriesPlayerMediakitController(),
    );
  }
}
