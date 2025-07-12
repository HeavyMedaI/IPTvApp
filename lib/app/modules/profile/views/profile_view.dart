import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/widgets/common.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';
import 'package:guek_iptv/constants/textstyle.dart';
//import 'package:guek_iptv/screen/bottom/MyAccount/subScreen/account_setting_screen.dart';
//import 'package:guek_iptv/screen/bottom/MyAccount/subScreen/manage_device_screen.dart';
//import 'package:guek_iptv/screen/bottom/MyAccount/subScreen/subscription_screen.dart';

import 'package:guek_iptv/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (context.isLandscape) {
      //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    return Scaffold(
      backgroundColor: ColorPalette.appColor,
      /*appBar: AppBar(
        backgroundColor: ColorPalette.appColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Hesabım",
          style: TextStyleClass.sourceSansProSemiBold(
            size: 18.0,
          ),
        ),
      ),*/
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [ColorPalette.grad1_a, ColorPalette.grad1_a, ColorPalette.grad1_b, ColorPalette.grad1_b])),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                /*Center(
                  child: Image(
                    image: AssetImage(
                      Images.profilePic,
                    ),
                  ),
                ),*/
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      controller.auth.session!.value!.username!,
                      style: TextStyleClass.sourceSansProBold(
                        size: 16.0,
                      ),
                    ),
                  ),
                ),
                /*Center(
                  child: Text(
                    "+91 12345 67890",
                    style: TextStyleClass.sourceSansProRegular(
                      size: 12.0,
                      color: ColorPalette.grey8A,
                    ),
                  ),
                ),
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
                ),*/
                Text(
                  "Paket Bitiş Tarihi : 20 Feb 2023",
                  style: TextStyleClass.sourceSansProRegular(
                    size: 12.0,
                    color: ColorPalette.greyAE,
                  ),
                ),
                /*SizedBox(height: 20),
                CommonButton(
                  title: 'SÜRE UZAT',
                  onPress: () {
                    Get.to(() => SubscriptionScreen());
                  },
                ),*/
                SizedBox(height: 25),
                /*Text(
                  "Account And Security",
                  style: TextStyleClass.sourceSansProSemiBold(
                    size: 16.0,
                    color: ColorPalette.grey8E,
                  ),
                ),*/
                /*SizedBox(height: 20),
                commonButMyAc(
                  title: "Account Settings",
                  onTap: () {
                    Get.to(() => AccountSettingScreen());
                  },
                ),
                SizedBox(height: 12),
                commonButMyAc(
                  title: "Manage Devices",
                  onTap: () {
                    Get.to(() => ManageDeviceScreen());
                  },
                ),*/
                SizedBox(height: 12),
                accountPageButton(
                  title: "Çıkış Yap",
                  onTap: () {
                    showAlert(context);
                  },
                ),
                SizedBox(height: 12),
                accountPageButton(
                  title: "İletişim",
                  onTap: () {
                  },
                ),
                /*SizedBox(height: 12),
                commonButMyAc(
                  title: "Log Out All Devices",
                  onTap: () {},
                ),*/
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
