import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/series_category/controllers/series_category_controller.dart';

import '../controllers/series_categories_controller.dart';

class SeriesCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeriesCategoriesController>(
          () => SeriesCategoriesController(),
    );
    Get.lazyPut<SeriesCategoryController>(
          () => SeriesCategoryController(),
    );
  }
}
