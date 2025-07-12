import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/models/xtream/user_info.dart';
import 'package:guek_iptv/app/modules/login/controllers/login_controller.dart';
import 'package:guek_iptv/app/modules/main/controllers/main_controller.dart';
import 'package:guek_iptv/app/modules/splash/controllers/splash_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/app/widgets/common.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';
import 'package:guek_iptv/constants/textstyle.dart';

//import 'package:guek_iptv/screen/bottom/MyAccount/subScreen/account_setting_screen.dart';
//import 'package:guek_iptv/screen/bottom/MyAccount/subScreen/manage_device_screen.dart';
//import 'package:guek_iptv/screen/bottom/MyAccount/subScreen/subscription_screen.dart';

import 'package:guek_iptv/app/modules/account/controllers/account_controller.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountView extends GetView<AccountController> {
  AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserInfoModel userInfo = controller.auth.session.value!.userInfo!;

    if (Get.currentRoute == Routes.ACCOUNT && context.isLandscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    //controller.checkAlert();

    DateFormat dateFormat = DateFormat("dd-MM-yyyy hh:mm");

    return Container(
      height: Get.height - Get.find<MainController>().bottomHeight,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Image(
                  width: 76,
                  height: 76,
                  image: AssetImage(
                    Images.profileImg,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    userInfo.username!,
                    style: TextStyleClass.sourceSansProBold(
                        size: 16.0, color: ColorPalette.butColor),
                  ),
                ),
              ),
              userInfo.phone != null
                  ? Center(
                      child: Text(
                        userInfo.phone!,
                        style: TextStyleClass.sourceSansProRegular(
                          size: 12.0,
                          color: ColorPalette.grey8A,
                        ),
                      ),
                    )
                  : SizedBox(width: 0, height: 0),
              SizedBox(height: 20),
              /*Text(
                  "Hesap Üyeliği",
                  style: TextStyleClass.sourceSansProSemiBold(
                    size: 16.0,
                    color: ColorPalette.grey8E,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "IPTvApp Mobile",
                  style: TextStyleClass.sourceSansProSemiBold(
                    size: 16.0,
                  ),
                ),*/
              /*Text(
                "Paket Bitiş Tarihi: ${dateFormat.format(controller.auth.session.value!.getExpDate())}",
                style: TextStyleClass.sourceSansProRegular(
                  size: 12.0,
                  color: ColorPalette.butColor.withAlpha(100),
                ),
              ),*/
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    margin: EdgeInsets.only(right: 5.0),
                    decoration: BoxDecoration(
                      color: ColorPalette.butColor.withAlpha(400),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      "Paket Bitiş Tarihi:",
                      style: TextStyleClass.sourceSansProRegular(
                        size: 12.0,
                        color: ColorPalette.appColor.withAlpha(500),
                      ),
                    ),
                  ),
                  Text(
                    dateFormat.format(controller.auth.session.value!.getExpDate()),
                    style: TextStyleClass.sourceSansProRegular(
                      size: 12.0,
                      color: ColorPalette.butColor.withAlpha(150),
                    ),
                  ),
                ],
              ),
              /*SizedBox(height: 20),
                CommonButton(
                  title: 'SÜRE UZAT',
                  onPress: () {
                    Get.to(() => SubscriptionScreen());
                  },
                ),
                SizedBox(height: 25),
                Text(
                  "Account And Security",
                  style: TextStyleClass.sourceSansProSemiBold(
                    size: 16.0,
                    color: ColorPalette.grey8E,
                  ),
                ),*/
              /*SizedBox(height: 20),
                commonButMyAc(
                  title: "Hesap Ayarları",
                  onTap: () {
                    Get.to(() => AccountSettingScreen());
                  },
                ),
                SizedBox(height: 12),
                commonButMyAc(
                  title: "Kanal Ayarları",
                  onTap: () {
                    Get.to(() => ManageDeviceScreen());
                  },
                ),*/
              SizedBox(height: 15),
              accountPageButton(
                title: "Çıkış Yap",
                onTap: () {
                  /*controller.storage.erase();
                    Get.offAllNamed(Routes.LOGIN);
                    Timer(
                      Duration(microseconds: 5000),
                      () {
                        Get.find<LoginController>().onReady();
                      },
                    );*/
                  controller.logout();
                },
              ),
              SizedBox(height: 12),
              accountPageButton(
                title: "İletişim",
                onTap: () async {
                  String contactUrl = "https://guekportal.site/external_login";
                  if (controller.storage.hasData("contact_url")) {
                    contactUrl = controller.storage.read("contact_url");
                  }
                  Uri contact = Uri.parse(
                      controller.remoteConfig.config.value!.contact_url!);
                  if (await canLaunchUrl(contact)) {
                    await launchUrl(contact);
                  }
                },
              ),
              SizedBox(height: 12),
              accountPageButton(
                title: "Satış Destek",
                onTap: () async {
                  String supportUrl = "https://guekportal.site/external_login";
                  if (controller.storage.hasData("contact_url")) {
                    supportUrl = controller.storage.read("support_url");
                  }
                  Uri support = Uri.parse(
                      controller.remoteConfig.config.value!.support_url!);
                  if (await canLaunchUrl(support)) {
                    await launchUrl(support);
                  }
                },
              ),
              SizedBox(height: 30),
              accountPageButton(
                title: "Guek Portal Giriş",
                onTap: () async {
                  String portalUrl =
                      controller.remoteConfig.config.value!.portal_url! +
                          "/external_login";
                  if (controller.storage.hasData("portal_url")) {
                    portalUrl = controller.storage.read("portal_url");
                  }
                  Uri portal = Uri.parse(portalUrl +
                      "?username=" +
                      controller.auth.session.value!.username! +
                      "&password=" +
                      controller.auth.session.value!.password!);
                  if (await canLaunchUrl(portal)) {
                    await launchUrl(portal);
                  }
                },
              ),
              SizedBox(height: 30),
              Center(
                child: Container(
                  width: Get.width * .7,
                  child: Text(
                    "Uyarı: Telegram sayfası erişilemiyor ise, iletişim adresinin güncellenmesi için uygulamayı kapatıp tekrar açın.",
                    style: TextStyleClass.sourceSansProSemiBold(
                      size: 12.0,
                      color: ColorPalette.butColor.withAlpha(200),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ...controller.remoteConfig.config.value!.marquee != null
                  ? [
                      Center(
                        child: Container(
                          width: Get.width,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ColorPalette.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: Alignment.center,
                          child: Marquee(
                            text: "Uyarı: " +
                                controller.remoteConfig.config.value!.marquee!,
                            style: TextStyle(
                                color: ColorPalette.red.withAlpha(200)),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            velocity: 30.0,
                            blankSpace: 10.0,
                          ),
                        ),
                      )
                    ]
                  : [],
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: ColorPalette.appColor,
      body: Container(
        height: Get.height - Get.find<MainController>().bottomHeight,
        color: Colors.transparent,
        /*decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorPalette.grad1_a,
                  ColorPalette.grad1_a,
                  ColorPalette.white.withOpacity(.5),
                  ColorPalette.grad1_b.withAlpha(50),
                  ColorPalette.white.withOpacity(.5),
                  ColorPalette.grad1_a,
            ])),*/
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Image(
                    width: 76,
                    height: 76,
                    image: AssetImage(
                      Images.profileImg,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      userInfo.username!,
                      style: TextStyleClass.sourceSansProBold(
                        size: 16.0,
                      ),
                    ),
                  ),
                ),
                userInfo.phone != null
                    ? Center(
                        child: Text(
                          "+91 12345 67890",
                          style: TextStyleClass.sourceSansProRegular(
                            size: 12.0,
                            color: ColorPalette.grey8A,
                          ),
                        ),
                      )
                    : SizedBox(width: 0, height: 0),
                /*SizedBox(height: 20),
                Text(
                  "Hesap Üyeliği",
                  style: TextStyleClass.sourceSansProSemiBold(
                    size: 16.0,
                    color: ColorPalette.grey8E,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "IPTvApp Mobile",
                  style: TextStyleClass.sourceSansProSemiBold(
                    size: 16.0,
                  ),
                ),*/
                Text(
                  "Paket Bitiş Tarihi : 20 Feb 2023",
                  style: TextStyleClass.sourceSansProRegular(
                    size: 12.0,
                    color: ColorPalette.butColor.withAlpha(100),
                  ),
                ),
                /*SizedBox(height: 20),
                CommonButton(
                  title: 'SÜRE UZAT',
                  onPress: () {
                    Get.to(() => SubscriptionScreen());
                  },
                ),
                SizedBox(height: 25),
                Text(
                  "Account And Security",
                  style: TextStyleClass.sourceSansProSemiBold(
                    size: 16.0,
                    color: ColorPalette.grey8E,
                  ),
                ),*/
                /*SizedBox(height: 20),
                commonButMyAc(
                  title: "Hesap Ayarları",
                  onTap: () {
                    Get.to(() => AccountSettingScreen());
                  },
                ),
                SizedBox(height: 12),
                commonButMyAc(
                  title: "Kanal Ayarları",
                  onTap: () {
                    Get.to(() => ManageDeviceScreen());
                  },
                ),*/
                SizedBox(height: 12),
                accountPageButton(
                  title: "Çıkış Yap",
                  onTap: () {
                    /*controller.storage.erase();
                    Get.offAllNamed(Routes.LOGIN);
                    Timer(
                      Duration(microseconds: 5000),
                      () {
                        Get.find<LoginController>().onReady();
                      },
                    );*/
                    controller.logout();
                  },
                ),
                SizedBox(height: 12),
                accountPageButton(
                  title: "İletişim",
                  onTap: () {},
                ),
                SizedBox(height: 30),
                Center(
                  child: Container(
                    width: Get.width * .7,
                    child: Text(
                      "Uyarı: Telegram sayfası erişilemiyor ise, iletişim adresinin güncellenmesi için uygulamayı kapatıp tekrar açın.",
                      style: TextStyleClass.sourceSansProSemiBold(
                        size: 12.0,
                        color: ColorPalette.yellowFFCE,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );

    /*return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Image(
                image: AssetImage(
                  Images.profilePic,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  userInfo.username!,
                  style: TextStyleClass.sourceSansProBold(
                    size: 16.0,
                  ),
                ),
              ),
            ),
            userInfo.phone != null ? Center(
              child: Text(
                "+91 12345 67890",
                style: TextStyleClass.sourceSansProRegular(
                  size: 12.0,
                  color: ColorPalette.grey8A,
                ),
              ),
            ): SizedBox(width: 0, height: 0),
            SizedBox(height: 20),
            Text(
              "Hesap Üyeliği",
              style: TextStyleClass.sourceSansProSemiBold(
                size: 16.0,
                color: ColorPalette.grey8E,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "IPTvApp Mobile",
              style: TextStyleClass.sourceSansProSemiBold(
                size: 16.0,
              ),
            ),
            Text(
              "Paket Bitiş Tarihi : 20 Feb 2023",
              style: TextStyleClass.sourceSansProRegular(
                size: 12.0,
                color: ColorPalette.grey83,
              ),
            ),
            SizedBox(height: 20),
            CommonButton(
              title: 'SÜRE UZAT',
              onPress: () {
                Get.to(() => SubscriptionScreen());
              },
            ),
            SizedBox(height: 25),
            Text(
              "Account And Security",
              style: TextStyleClass.sourceSansProSemiBold(
                size: 16.0,
                color: ColorPalette.grey8E,
              ),
            ),
            SizedBox(height: 20),
            commonButMyAc(
              title: "Hesap Ayarları",
              onTap: () {
                Get.to(() => AccountSettingScreen());
              },
            ),
            SizedBox(height: 12),
            commonButMyAc(
              title: "Kanal Ayarları",
              onTap: () {
                Get.to(() => ManageDeviceScreen());
              },
            ),
            SizedBox(height: 12),
            commonButMyAc(
              title: "Çıkış Yap",
              onTap: () {
                controller.storage.erase();
                Get.offAllNamed(Routes.LOGIN);
                Timer(
                  Duration(microseconds: 5000),
                      () {
                    Get.find<LoginController>().onReady();
                  },
                );
              },
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                "İletişim için tıklayın",
                style: TextStyleClass.sourceSansProSemiBold(
                  size: 12.0,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );*/
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Container(
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorPalette.appColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Log Out",
                  style: TextStyleClass.sourceSansProSemiBold(
                    size: 16.0,
                  ),
                ),
                Text(
                  "Are you sure you want to log out?",
                  style: TextStyleClass.sourceSansProRegular(
                    size: 12.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Cancel",
                        style: TextStyleClass.sourceSansProSemiBold(
                          size: 12.0,
                          color: ColorPalette.greyB0,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Log Out",
                        style: TextStyleClass.sourceSansProSemiBold(
                          size: 12.0,
                          color: ColorPalette.butColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
