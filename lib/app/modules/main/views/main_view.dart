import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/modules/global/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:guek_iptv/app/modules/global/custom_drawer/views/custom_drawer_view.dart';
import 'package:guek_iptv/app/modules/login/controllers/login_controller.dart';

import 'package:guek_iptv/app/modules/main/controllers/main_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/widgets/common.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';
import 'package:guek_iptv/constants/textstyle.dart';
//import 'package:guek_iptv/screen/bottom/home/subscreen/search/search_screen.dart';

class MainView extends GetView<MainController> {
  MainView({Key? key}) : super(key: key);

  //MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    if (Get.currentRoute == Routes.MAIN && context.isLandscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    return PopScope(
        canPop: false,
        child: Obx(() => Scaffold(
              key: controller.scaffoldKey,
              //drawer: CustomDrawerView(),
              appBar: PreferredSize(
                  preferredSize: Size(Get.width, controller.appBarHeight),
                  child: AppBar(
                    backgroundColor: ColorPalette.appColor.withAlpha(100),
                    elevation: 0,
                    /*leading: InkWell(
          onTap: () {
            controller.scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              Images.menu,
            ),
          ),
        ),*/
                    //title: SvgPicture.asset(Images.appLogo),
                    /*title: Center(
                  child: Image(
                    //width: 100,
                    height: controller.appBarHeight * .75,
                    alignment: Alignment.center,
                    image: AssetImage(Images.splashBg),
                    fit: BoxFit.contain,
                  ),
                ),*/
                    title: Center(
                      child: Text(
                        controller.pageTitle.value,
                        style: TextStyleClass.sourceSansProSemiBold(
                            size: 18.0, color: ColorPalette.butColor),
                      ),
                    ),
                    automaticallyImplyLeading: false,
                  )),
              /*floatingActionButton: Container(
        height: 72,
        width: 72,
        margin: EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorPalette.black2F,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              spreadRadius: 0,
              offset: Offset(0, -8),
              color: ColorPalette.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            onPressed: () {
              controller.pageIndex.value = 2;

              Get.off(() => MainView());

              /* Navigator.of(context, rootNavigator: true)
                  .pushReplacement(MaterialPageRoute(
                builder: (context) => NavigationBarBottom(),
              )); */
            },
            child: SvgPicture.asset(Images.shop),
            elevation: 0,
            backgroundColor: ColorPalette.butColor,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
              resizeToAvoidBottomInset: false,
              backgroundColor: ColorPalette.appColor,
              body: Container(
                height: Get.height - (controller.appBarHeight),
                decoration: BoxDecoration(
                  color: ColorPalette.appColor,
                  //border: Border.all(width: 10, color: Colors.red),
                ),
                child: Column(
                  //alignment: Alignment.bottomCenter,
                  verticalDirection: VerticalDirection.down,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: Get.height -
                          (controller.bottomHeight +
                              controller.appBarHeight +
                              45),
                      child: controller.pages[controller.pageIndex.value],
                    ),
                    //SizedBox(width: Get.width, height: controller.bottomHeight,),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: this.buildNavBar(Get.context!),
                    )
                  ],
                ),
              ),
              //bottomNavigationBar: buildMyNavBar(context),
            )));
  }

  buildNavBar(BuildContext context) {
    return Container(
      height: controller.bottomHeight,
      decoration: BoxDecoration(
        //color: ColorPalette.grad1_b,
        color: Colors.transparent,
        /*gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorPalette.grad1_a,
              ColorPalette.grad1_a,
              ColorPalette.white.withOpacity(.5),
              ColorPalette.grad1_b.withAlpha(50),
              ColorPalette.white.withOpacity(.5),
              ColorPalette.grad1_a,
            ]),*/
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            spreadRadius: 0,
            offset: Offset(0, -8),
            color: ColorPalette.appColor.withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /*Obx(
                () => IconButton(
              enableFeedback: false,
              onPressed: () {
                controller.pageIndex.value = 0;
              },
              icon: controller.pageIndex.value == 0
                  ? SvgPicture.asset(Images.proV1)
                  : SvgPicture.asset(Images.home),
            ),
          ),*/
          Obx(
            () => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(33)),
                color: controller.pageIndex.value == 0 ? ColorPalette.butColor.withAlpha(475) :Colors.transparent,
              ),
              child: IconButton(
                enableFeedback: false,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: ColorPalette.butColor.withAlpha(100),
                onPressed: () {
                  controller.pageIndex.value = 0;
                  controller.pageTitle.value = "Canlı Kanal Kategorileri";
                },
                icon: Icon(
                  controller.pageIndex.value == 0
                      ? Icons.cast_connected_outlined
                      : Icons.cast_connected_outlined,
                  size: 27,
                  color: controller.pageIndex.value == 0
                      ? ColorPalette.appColor
                      : ColorPalette.butColor.withAlpha(475), //black2F
                ),
              ),
            ),
          ),
          Obx(
            () => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(33)),
                color: controller.pageIndex.value == 1 ? ColorPalette.butColor.withAlpha(475) :Colors.transparent,
              ),
              child: IconButton(
                enableFeedback: false,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: ColorPalette.butColor.withAlpha(100),
                onPressed: () {
                  controller.pageIndex.value = 1;
                  controller.pageTitle.value = "Film Kategorileri";
                },
                icon: Icon(
                  controller.pageIndex.value == 1
                      ? Icons.movie_creation_outlined
                      : Icons.movie_creation_outlined,
                  size: 27,
                  color: controller.pageIndex.value == 1
                      ? ColorPalette.appColor
                      : ColorPalette.butColor.withAlpha(475), //black2F
                ),
              ),
            ),
          ),
          /*IconButton(
            enableFeedback: false,
            onPressed: () {
              controller.pageIndex.value = 2;
            },
            icon: Text(""),
          ),*/
          Obx(
            () => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(33)),
                color: controller.pageIndex.value == 2 ? ColorPalette.butColor.withAlpha(475) :Colors.transparent,
              ),
              child: IconButton(
                enableFeedback: false,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: ColorPalette.butColor.withAlpha(100),
                onPressed: () {
                  controller.pageIndex.value = 2;
                  controller.pageTitle.value = "Dizi Kategorileri";
                },
                icon: Icon(
                  controller.pageIndex.value == 2 ? Icons.live_tv : Icons.live_tv,
                  size: 27,
                  color: controller.pageIndex.value == 2
                      ? ColorPalette.appColor
                      : ColorPalette.butColor.withAlpha(475), //black2F
                ),
              ),
            ),
          ),
          Obx(
            () => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(33)),
                color: controller.pageIndex.value == 3 ? ColorPalette.butColor.withAlpha(475) :Colors.transparent,
              ),
              child: IconButton(
                enableFeedback: false,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: ColorPalette.butColor.withAlpha(100),
                onPressed: () {
                  controller.pageIndex.value = 3;
                  controller.pageTitle.value = "Profilim";
                },
                icon: Icon(
                  controller.pageIndex.value == 3 ? Icons.person_outline : Icons.person_outline,
                  size: 27,
                  color: controller.pageIndex.value == 3
                      ? ColorPalette.appColor
                      : ColorPalette.butColor.withAlpha(475), //black2F
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
