import 'package:get/get.dart';

import '../controllers/movie_player_mediakit_controller.dart';

class MoviePlayerMediakitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoviePlayerMediakitController>(
      () => MoviePlayerMediakitController(),
    );
  }
}
