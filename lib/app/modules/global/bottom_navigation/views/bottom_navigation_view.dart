import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:guek_iptv/app/modules/global/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';
//import 'package:guek_iptv/screen/bottom/home/subscreen/search/search_screen.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  BottomNavigationView({Key? key}) : super(key: key);

  BottomNavigationController navigationController = Get.find<BottomNavigationController>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //drawer: DrawerDesign(),
      appBar: AppBar(
        backgroundColor: ColorPalette.appColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            //scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              Images.menu,
            ),
          ),
        ),
        title: SvgPicture.asset(Images.appLogo),
        actions: [
          InkWell(
            onTap: () {
              //Get.to(() => SearchScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(CupertinoIcons.search),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 72,
        width: 72,
        margin: EdgeInsets.only(bottom: 30),
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
              navigationController.pageIndex.value = 2;

              Get.off(() => BottomNavigationView());

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(
            () => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            controller.pages[controller.pageIndex.value],
            buildMyNavBar(context),
          ],
        ),
      ),
    );
  }

  buildMyNavBar(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(
                () => IconButton(
              enableFeedback: false,
              onPressed: () {
                navigationController.pageIndex.value = 0;
              },
              icon: navigationController.pageIndex.value == 0
                  ? SvgPicture.asset(Images.homeFill)
                  : SvgPicture.asset(Images.home),
            ),
          ),
          Obx(
                () => IconButton(
              enableFeedback: false,
              onPressed: () {
                navigationController.pageIndex.value = 1;
              },
              icon: navigationController.pageIndex.value == 1
                  ? SvgPicture.asset(Images.filmSlateFill)
                  : SvgPicture.asset(Images.filmSlate),
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              navigationController.pageIndex.value = 2;
            },
            icon: Text(""),
          ),
          Obx(
                () => IconButton(
              enableFeedback: false,
              onPressed: () {
                navigationController.pageIndex.value = 3;
              },
              icon: navigationController.pageIndex.value == 3
                  ? SvgPicture.asset(Images.tvFill)
                  : SvgPicture.asset(Images.tvIcon),
            ),
          ),
          Obx(
                () => IconButton(
                enableFeedback: false,
                onPressed: () {
                  navigationController.pageIndex.value = 4;
                },
                icon: navigationController.pageIndex.value == 4
                    ? SvgPicture.asset(Images.liveFill)
                    : SvgPicture.asset(Images.live)),
          ),
        ],
      ),
    );
  }
}
