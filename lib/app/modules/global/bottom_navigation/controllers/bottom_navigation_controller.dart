import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:guek_iptv/app/modules/account/views/account_view.dart';
//import 'package:guek_iptv/app/modules/home/views/home_view.dart';
import 'package:guek_iptv/app/modules/vod_categories/views/vod_categories_view.dart';
//import 'package:guek_iptv/screen/bottom/IPTvAppSpecial/light_star_special.dart';
//import 'package:guek_iptv/screen/bottom/movies/movies_screen.dart';
//import 'package:guek_iptv/screen/bottom/tv/tv_screen.dart';

class BottomNavigationController extends GetxController {

  RxInt pageIndex = 0.obs;

  final pages = [
    //HomeView(),
    VodCategoriesView(),
    //IPTvAppScreen(),
    //MoviesScreen(),
    //AccountView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
