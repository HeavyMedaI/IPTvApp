import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/vod_category/controllers/vod_category_controller.dart';

import '../controllers/vod_categories_controller.dart';

class VodCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VodCategoriesController>(
      () => VodCategoriesController(),
    );
    Get.lazyPut<VodCategoryController>(
          () => VodCategoryController(),
    );
  }
}
