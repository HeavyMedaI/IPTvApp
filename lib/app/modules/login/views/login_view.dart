import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/login/controllers/login_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/widgets/common.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';
import 'package:guek_iptv/constants/textstyle.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  //LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    if (Get.currentRoute == Routes.LOGIN && context.isLandscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    //controller.checkLoginForm();
    //this.checkLoginForm(context);

    log("loginView");
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: ColorPalette.butColor,
          body: Container(
            height: Get.height,
            padding: EdgeInsets.only(top: 20, left: 50, right: 50),
            decoration: BoxDecoration(
              color: ColorPalette.appColor,
              //border: Border.all(color: Colors.black, width: 10),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  height: 20,
                ),
                CommonTextField(
                  controller: controller.usernameController,
                  hintText: 'E-posta veya Telefon',
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
                  controller: controller.passwordController,
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
                  height: 35,
                ),
                controller.onSubmit.isFalse
                    ? CommonButton(
                  title: "Giriş Yap",
                  elevation: 1,
                  color: ColorPalette.grad3_b.withAlpha(230),
                  onPress: () async {
                    //Get.to(() => SignUpScreen());
                    //showToast(usernameController.text);
                    //this.onSubmit.value = true;
                    await controller.submit();
                  },
                )
                    : Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: ColorPalette.butColor, size: 50),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "Hesabınız yok mu?",
                    style: TextStyleClass.sourceSansProSemiBold(
                      size: 16.0,
                      color: ColorPalette.butColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CommonButton(
                  title: "Kayıt Ol",
                  elevation: 1,
                  color: ColorPalette.grad3_b.withAlpha(230),
                  onPress: () async {

                  },
                )
              ],
            ),
          ),
        ));

    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: ColorPalette.butColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Continue with phone",
                    style: TextStyleClass.sourceSansProSemiBold(
                      size: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  CommonTextFieldMo(hintText: 'Your mobile number'),
                  SizedBox(
                    height: 420,
                  ),
                  CommonButton(
                    title: 'Continue',
                    onPress: () {
                      //Get.to(() => OtpScreen());
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "By clicking continue, you agree to our ",
                            style: TextStyleClass.sourceSansProRegular(
                              color: ColorPalette.grey65,
                            ),
                          ),
                          TextSpan(
                            text: "Terms of Use",
                            style: TextStyleClass.sourceSansProRegular(
                              color: ColorPalette.butColor,
                            ),
                          ),
                          TextSpan(
                            text: " and acknowledge that you have read our ",
                            style: TextStyleClass.sourceSansProRegular(
                              color: ColorPalette.grey65,
                            ),
                          ),
                          TextSpan(
                            text: "Privacy Policy.",
                            style: TextStyleClass.sourceSansProRegular(
                              color: ColorPalette.butColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ));

    return PopScope(
        canPop: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorPalette.butColor,
          body: Container(
            child: Container(
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
          ),
        ));
  }

  void checkLoginForm(BuildContext context) {
    if (controller.auth.isLogged.isFalse) {
      Timer(
        Duration(seconds: 1),
            () {
              //controller.formOpened.value = true;
          _bottomLoginSheet(context);
        },
      );
    }
  }

  void _bottomLoginSheet(BuildContext context) {
    Get.bottomSheet(
        Obx(() => PopScope(
          child: Container(
            padding: EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
            child: Container(
              height: 500 + Get.mediaQuery.viewInsets.bottom,
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
                          height: 20,
                        ),
                        CommonTextField(
                          controller: controller.usernameController,
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
                          controller: controller.passwordController,
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
                          controller: controller.urlController,
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
                          controller: controller.m3uController,
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
                        controller.onSubmit.isFalse
                            ? CommonButton(
                          title: "Giriş Yap",
                          elevation: 1,
                          color: ColorPalette.grad3_b.withAlpha(230),
                          onPress: () async {
                            //Get.to(() => SignUpScreen());
                            //showToast(usernameController.text);
                            //this.onSubmit.value = true;
                            await controller.submit();
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
        persistent: true,
        isScrollControlled: true,
      ignoreSafeArea: false
    );
  }
}
