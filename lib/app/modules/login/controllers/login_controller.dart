import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//import 'package:japx/japx.dart';
import 'package:guek_iptv/app/models/xtream/session.dart';
import 'package:guek_iptv/app/modules/live_categories/controllers/live_categories_controller.dart';
import 'package:guek_iptv/app/modules/main/controllers/main_controller.dart';
import 'package:guek_iptv/app/modules/series_categories/controllers/series_categories_controller.dart';
import 'package:guek_iptv/app/modules/vod_categories/controllers/vod_categories_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/app/widgets/common.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/textstyle.dart';
import 'package:guek_iptv/utiles/utiles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final urlController = TextEditingController();
  final m3uController = TextEditingController();

  //SharedPreferences store;
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "xtream_auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");

  RxBool formOpened = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    log(auth.session.toJson().toString());
    if (auth.session.value != null && auth.session.value!.username != null) {
      usernameController.text = auth.session.value!.username!;
      passwordController.text = auth.session.value!.password!;
      urlController.text = auth.session.value!.url!;
      m3uController.text = auth.session.value!.getM3U(type: "m3u_plus", output: "mpegts");
    }
    m3uController.text = "http://koguek.fun:8080/get.php?username=hOioMS0Y&password=TO3aTnOB&type=m3u_plus&output=ts";
    //await apiService.init();
    if (auth.isLogged.isFalse) {
      //_bottomLoginSheet();
    }
    super.onReady();
    //log("auth.isLogged: " + auth.isLogged.toString());
  }

  void checkLoginForm() {
    if (auth.isLogged.isFalse && formOpened.isFalse) {
      Timer(
        Duration(seconds: 1),
        () {
          formOpened.value = true;
          _bottomLoginSheet();
        },
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  RxBool onSubmit = false.obs;

  Future<void> submit() async {
    if (m3uController.text.length > 10) {
      Map<String, String> parsed = parseM3U(m3uController.text);
      usernameController.text = parsed["username"]!;
      passwordController.text = parsed["password"]!;
      urlController.text = parsed["host"]!;
    }

    if (usernameController.text.length < 5 ||
        passwordController.text.length < 5 ||
        urlController.text.length < 5) {
      showToast(
          "Lütfen form alanlarını veya M3U URL alanını eksiksiz doldurun!");
    } else {
      onSubmit.value = true;
      try {
        SessionModel? session = await apiService.loginAsync(urlController.text,
            usernameController.text, passwordController.text);

        storage.write("session", jsonEncode(session!.toJson()));
        storage.write("auth.is_logged", true);

        //store.setBool("isLogged", true);
        //store.setString("user", jsonEncode(user!.toJson()));

        auth.isLogged.value = true;
        auth.session.value = session;
        //Get.toNamed(Routes.ACCOUNT);
        //Get.toNamed(Routes.HOME);
        Get.find<MainController>(tag: "main").pageIndex.value = 0;
        Get.toNamed(Routes.MAIN);
        formOpened.value = false;
        //usernameController.clear();
        //passwordController.clear();
        //urlController.clear();
        //m3uController.clear();

        Get.find<LiveCategoriesController>().reload();
        Get.find<VodCategoriesController>().reload();
        Get.find<SeriesCategoriesController>().reload();
      } on Exception catch (e) {
        showToast('Oturum açılamadı, giriş bilgileri yanlış');
        onSubmit.value = false;
      }
      onSubmit.value = false;
      /*UserModel? user = await apiService.login(urlController.text, usernameController.text, passwordController.text);
      if (user != null) {
        log("logged user: " + user.toJson().toString());
      }*/
    }
  }

  void _bottomLoginSheet() {
    Get.bottomSheet(
      Obx(() => PopScope(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Container(
                height: Get.height*1,
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: ColorPalette.appColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Giriş Yapın",
                            style: TextStyleClass.sourceSansProSemiBold(
                              size: 18.0,
                              color: ColorPalette.butColor,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CommonTextField(
                            controller: usernameController,
                            hintText: 'Kullanıcı adı',
                            hintColor: ColorPalette.butColor.withAlpha(500),
                            style: TextStyle(color: ColorPalette.butColor),
                            icon: Icon(
                              Icons.person,
                              color: ColorPalette.butColor,
                              size: 15,
                            ),
                            onChange: (String value) {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CommonTextField(
                            controller: passwordController,
                            hintText: 'Şifre',
                            hintColor: ColorPalette.butColor.withAlpha(500),
                            style: TextStyle(color: ColorPalette.butColor),
                            icon: Icon(
                              Icons.password,
                              color: ColorPalette.butColor,
                              size: 15,
                            ),
                            onChange: (String value) {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CommonTextField(
                            controller: urlController,
                            hintText: 'URL',
                            hintColor: ColorPalette.butColor.withAlpha(500),
                            style: TextStyle(color: ColorPalette.butColor),
                            icon: Icon(
                              Icons.link,
                              color: ColorPalette.butColor,
                              size: 15,
                            ),
                            onChange: (String value) {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              "yada",
                              style: TextStyleClass.sourceSansProSemiBold(
                                size: 16.0,
                                color: ColorPalette.butColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CommonTextField(
                            controller: m3uController,
                            hintText: 'M3U',
                            hintColor: ColorPalette.butColor.withAlpha(500),
                            style: TextStyle(color: ColorPalette.butColor),
                            icon: Icon(
                              Icons.stream,
                              color: ColorPalette.butColor,
                              size: 15,
                            ),
                            onChange: (String value) {},
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          this.onSubmit.isFalse
                              ? CommonButton(
                            title: "Giriş Yap",
                            elevation: 1,
                            color: ColorPalette.grad3_b.withAlpha(230),
                            onPress: () async {
                              //Get.to(() => SignUpScreen());
                              //showToast(usernameController.text);
                              //this.onSubmit.value = true;
                              await submit();
                            },
                          )
                              : Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                                color: ColorPalette.butColor, size: 50),
                          ),
                          Spacer(),
                          Spacer(),
                          Spacer(),
                        ],
                      ),
                    )),
              ),
            ),
            canPop: false,
          )),
      enterBottomSheetDuration: Duration(milliseconds: 500),
      backgroundColor: ColorPalette.appColor,
      isDismissible: false,
      enableDrag: false,
      persistent: false,
      elevation: 0,
      isScrollControlled: true
    );
  }
}
