import 'package:get/get.dart';

import '../controllers/live_categories_controller.dart';

class LiveCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveCategoriesController>(
      () => LiveCategoriesController(),
    );
  }
}
