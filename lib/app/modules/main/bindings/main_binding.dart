import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/account/controllers/account_controller.dart';
import 'package:guek_iptv/app/modules/global/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:guek_iptv/app/modules/global/custom_drawer/controllers/custom_drawer_controller.dart';
//import 'package:guek_iptv/app/modules/home/controllers/home_controller.dart';
import 'package:guek_iptv/app/modules/live_categories/controllers/live_categories_controller.dart';
import 'package:guek_iptv/app/modules/live_category/controllers/live_category_controller.dart';
import 'package:guek_iptv/app/modules/profile/controllers/profile_controller.dart';
import 'package:guek_iptv/app/modules/series_categories/controllers/series_categories_controller.dart';
import 'package:guek_iptv/app/modules/series_category/controllers/series_category_controller.dart';
import 'package:guek_iptv/app/modules/vod_categories/controllers/vod_categories_controller.dart';
import 'package:guek_iptv/app/modules/vod_category/controllers/vod_category_controller.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.lazyPut<BottomNavigationController>(
      () => BottomNavigationController(),
    );
    /*Get.lazyPut<CustomDrawerController>(
          () => CustomDrawerController(),
    );*/
    Get.lazyPut<AccountController>(
      () => AccountController(),
    );
    /*Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );*/
    /*Get.lazyPut<HomeController>(
          () => HomeController(),
    );*/
    Get.lazyPut<VodCategoriesController>(
      () => VodCategoriesController(),
    );
    Get.lazyPut<SeriesCategoriesController>(
      () => SeriesCategoriesController(),
    );
    Get.lazyPut<VodCategoryController>(
      () => VodCategoryController(),
    );
    Get.lazyPut<SeriesCategoryController>(
      () => SeriesCategoryController(),
    );
    Get.lazyPut<LiveCategoriesController>(
      () => LiveCategoriesController(),
    );
    Get.lazyPut<LiveCategoryController>(
      () => LiveCategoryController(),
    );
  }
}
