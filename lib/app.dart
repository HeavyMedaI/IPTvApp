import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:guek_iptv/app/AppBindings.dart';
//import 'package:guek_iptv/app/modules/splash/bindings/splash_binding.dart';
import 'package:guek_iptv/app/modules/splash/views/splash_view.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.onlyBuilder,
      getPages: AppPages.routes,
      home: SplashView(),
      initialRoute: AppPages.INITIAL_ROUTE,
      //initialBinding: AppBindings(),
      defaultTransition: Transition.rightToLeft,
    );
  }
}
