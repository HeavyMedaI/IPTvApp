import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/models/xtream/user_info.dart';
import 'package:guek_iptv/app/modules/global/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:guek_iptv/app/modules/global/custom_drawer/controllers/custom_drawer_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/textstyle.dart';
//import 'package:guek_iptv/screen/bottom/DrawerScreen/Help/help_screen.dart';
//import 'package:guek_iptv/screen/bottom/DrawerScreen/Prefrences/preferences_screen.dart';
//import 'package:guek_iptv/screen/bottom/DrawerScreen/Watchlist/watchlist_screen.dart';
//import 'package:guek_iptv/screen/bottom/DrawerScreen/download/download_screen.dart';

class CustomDrawerView extends GetView<CustomDrawerController> {
  CustomDrawerView({Key? key}) : super(key: key);

  //CustomDrawerController drawerController = Get.find<CustomDrawerController>();

  @override
  Widget build(BuildContext context) {

    UserInfoModel userInfo = controller.auth.session.value!.userInfo!;

    return Drawer(
      child: Container(
        color: ColorPalette.appColor, //<-- SEE HERe
        child: ListView(
          children: [
            ListTile(
              title: Text(
                userInfo.username!,
                style: TextStyleClass.sourceSansProBold(
                  size: 16.0,
                ),
              ),
              onTap: (){
                Get.back();
                Get.toNamed(Routes.ACCOUNT);
                //controller.bottomNav.pageIndex.value = 1;
                //Get.back();
              },
              subtitle: userInfo.phone != null ? Text(
                userInfo.phone!,
                style: TextStyleClass.sourceSansProRegular(
                  size: 12.0,
                  color: ColorPalette.grey8A,
                ),
              ) :null,
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: ColorPalette.white,
                size: 12.0,
              ),
            ),
            Container(
              color: ColorPalette.grey3A,
              child: ListTile(
                title: Text(
                  "ÇOCUK Koruması",
                  style: TextStyleClass.sourceSansProSemiBold(
                    size: 16.0,
                  ),
                ),
                trailing: Obx(
                      () => Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: controller.wifi.value,
                      trackColor: ColorPalette.greyB0,
                      activeColor: ColorPalette.butColor,
                      onChanged: (bool value) {
                        controller.wifi.value = value;
                      },
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                //Get.to(() => WatchlistScreen());
              },
              title: Text(
                "İzlenecekler Listem",
                style: TextStyleClass.sourceSansProBold(
                  size: 16.0,
                ),
              ),
              subtitle: Text(
                "Daha önce kaydettikleriniz",
                style: TextStyleClass.sourceSansProRegular(
                  size: 12.0,
                  color: ColorPalette.grey8A,
                ),
              ),
              minLeadingWidth: 20,
              leading: Icon(
                Icons.bookmark,
                color: ColorPalette.white,
              ),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                title: Text(
                  "Kategoriler",
                  style: TextStyleClass.sourceSansProBold(
                    size: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: ColorPalette.grey48,
            ),
            /*SizedBox(
              height: 40,
              child: ListTile(
                title: Text(
                  "Kanal Ayarları",
                  style: TextStyleClass.sourceSansProBold(
                    size: 16.0,
                  ),
                ),
                onTap: (){
                  Get.to(PreferencesScreen());
                },
              ),
            ),*/
            SizedBox(
              height: 40,
              child: ListTile(
                onTap: (){
                  //Get.to(HelpScreen());
                },
                title: Text(
                  "Yardım",
                  style: TextStyleClass.sourceSansProBold(
                    size: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: ColorPalette.grey48,
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                title: Text(
                  "Gizlilik Sözleşmesi \u2022 T&C",
                  style: TextStyleClass.sourceSansProRegular(
                    size: 12.0,
                    color: ColorPalette.grey83,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListTile(
                title: Text(
                  "V12.4.7.1168",
                  style: TextStyleClass.sourceSansProRegular(
                    size: 12.0,
                    color: ColorPalette.grey83,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
