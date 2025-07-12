import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/splash/controllers/splash_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';


class SplashView extends GetView<SplashController> {
  SplashView({Key? key}) : super(key: key);

  //SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    if (Get.currentRoute == Routes.SPLASH && context.isLandscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorPalette.butColor,
      body: Container(
        margin: EdgeInsets.only(bottom: 200),
        child: Center(
          child: SizedBox(
            height: 131,
            width: 135,
            child: Image(
              image: AssetImage(
                Images.splashBg,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
