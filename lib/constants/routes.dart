import "package:get/get.dart";
//import "package:guek_iptv/screen/auth/login/login.bindings.dart";
//import "package:guek_iptv/screen/auth/login/login.view.dart";
//import "package:guek_iptv/screen/splash/splash.bindings.dart";
//import "package:guek_iptv/screen/splash/splash.view.dart";

class Routes {
  static String ROOT = "/";
  static String LOGIN = "/login";
}

const INITIAL_ROUTE = "/";

final appRoutes = [
  /*GetPage(
    name: Routes.ROOT,
    page: () => LSplashView(),
    transition: Transition.zoom,
    transitionDuration: Duration(milliseconds: 500),
    binding: SplashBindings()
  ),
  GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBindings()
  ),*/
];

class AppMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print("Page Called: $page?.name");
    return super.onPageCalled(page);
  }
}
