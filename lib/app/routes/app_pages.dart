import 'package:flutter/animation.dart';

import 'package:get/get.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
//import '../modules/home/bindings/home_binding.dart';
//import '../modules/home/views/home_view.dart';
import '../modules/live_categories/bindings/live_categories_binding.dart';
import '../modules/live_categories/views/live_categories_view.dart';
import '../modules/live_category/bindings/live_category_binding.dart';
import '../modules/live_category/views/live_category_view.dart';
import '../modules/live_player_mediakit/bindings/live_player_mediakit_binding.dart';
import '../modules/live_player_mediakit/views/live_player_mediakit_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/controllers/main_controller.dart';
import '../modules/main/views/main_view.dart';
import '../modules/movie_player_mediakit/bindings/movie_player_mediakit_binding.dart';
import '../modules/movie_player_mediakit/views/movie_player_mediakit_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/series_categories/bindings/series_categories_binding.dart';
import '../modules/series_categories/views/series_categories_view.dart';
import '../modules/series_category/bindings/series_category_binding.dart';
import '../modules/series_category/views/series_category_view.dart';
import '../modules/series_detail/bindings/series_detail_binding.dart';
import '../modules/series_detail/views/series_detail_view.dart';
import '../modules/series_player_mediakit/bindings/series_player_mediakit_binding.dart';
import '../modules/series_player_mediakit/views/series_player_mediakit_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/vod_categories/bindings/vod_categories_binding.dart';
import '../modules/vod_categories/views/vod_categories_view.dart';
import '../modules/vod_category/bindings/vod_category_binding.dart';
import '../modules/vod_category/views/vod_category_view.dart';
import '../modules/vod_detail/bindings/vod_detail_binding.dart';
import '../modules/vod_detail/views/vod_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL_ROUTE = Routes.ROOT;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
      middlewares: [AppMiddleware()],
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 450),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      middlewares: [AppMiddleware()],
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 450),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
      middlewares: [AppMiddleware()],
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 450),
    ),
    /*GetPage(
        name: _Paths.ACCOUNT,
        page: () => AccountView(),
        binding: AccountBinding(),
        middlewares: [AppMiddleware()],
        transition: Transition.rightToLeft,
        curve: Curves.easeInOut,
        transitionDuration: Duration(milliseconds: 450)),*/
    /*GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.VOD_CATEGORIES,
      page: () => const VodCategoriesView(),
      binding: VodCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.SERIES_CATEGORIES,
      page: () => const SeriesCategoriesView(),
      binding: SeriesCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_CATEGORIES,
      page: () => const LiveCategoriesView(),
      binding: LiveCategoriesBinding(),
    ),*/
    GetPage(
      name: _Paths.VOD_CATEGORY,
      page: () => const VodCategoryView(),
      binding: VodCategoryBinding(),
      middlewares: [AppMiddleware()],
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 450),
    ),
    GetPage(
      name: _Paths.VOD_DETAIL,
      page: () => const VodDetailView(),
      binding: VodDetailBinding(),
      middlewares: [AppMiddleware()],
      //transition: Transition.rightToLeft,
      transition: Transition.zoom,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 450),
    ),
    GetPage(
      name: _Paths.SERIES_CATEGORY,
      page: () => const SeriesCategoryView(),
      binding: SeriesCategoryBinding(),
      middlewares: [AppMiddleware()],
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 450),
    ),
    GetPage(
      name: _Paths.SERIES_DETAIL,
      page: () => const SeriesDetailView(),
      binding: SeriesDetailBinding(),
      middlewares: [AppMiddleware()],
      transition: Transition.zoom,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 450),
    ),
    GetPage(
      name: _Paths.LIVE_CATEGORY,
      page: () => const LiveCategoryView(),
      binding: LiveCategoryBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_PLAYER_MEDIAKIT,
      page: () => LivePlayerMediakitView(),
      binding: LivePlayerMediakitBinding(),
      middlewares: [AppMiddleware()],
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 450),
    ),
    GetPage(
      name: _Paths.MOVIE_PLAYER_MEDIAKIT,
      page: () => const MoviePlayerMediakitView(),
      binding: MoviePlayerMediakitBinding(),
      middlewares: [AppMiddleware()],
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 450),
    ),
    GetPage(
      name: _Paths.SERIES_PLAYER_MEDIAKIT,
      page: () => const SeriesPlayerMediakitView(),
      binding: SeriesPlayerMediakitBinding(),
      middlewares: [AppMiddleware()],
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 450),
    ),
  ];
}

class AppMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print("Current Page: " + Get.currentRoute);
    print("Page Called: $page?.name");

    return super.onPageCalled(page);
  }
}
