import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/models/xtream/series.dart';
import 'package:guek_iptv/app/modules/series_detail/controllers/series_detail_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/widgets/custom_text.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';
import 'package:guek_iptv/constants/textstyle.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:guek_iptv/app/modules/series_category/controllers/series_category_controller.dart';

class SeriesCategoryView extends GetView<SeriesCategoryController> {
  const SeriesCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.loadSeries(Get.arguments["category_id"]!);

    log("currentRoute: " + Get.currentRoute);
    if (Get.currentRoute == Routes.SERIES_CATEGORY && context.isLandscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    return PopScope(
        onPopInvoked: (pop) {
          //Get.find<SeriesPlayerController>().disposePlayer();
        },
        child: Scaffold(
          backgroundColor: ColorPalette.appColor,
          appBar: AppBar(
            backgroundColor: ColorPalette.appColor.withAlpha(100),
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: ColorPalette.butColor),
            title: Text(
              Get.arguments["category_name"]!,
              style: TextStyleClass.sourceSansProSemiBold(
                  size: 18.0, color: ColorPalette.butColor),
            ),
            /*actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SearchScreen());
            },
            icon: Icon(
              Icons.search,
              color: ColorPalette.white,
            ),
          ),
        ],*/
          ),
          body: Obx(() {
            if (controller.series.isEmpty) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorPalette.butColor, size: 50),
              );
            }

            List<Widget> movies = <Widget>[];

            return Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: controller.series.length,
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Get.size.shortestSide < 600 ? 2 : 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 3,
                    childAspectRatio: .6,
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    SeriesModel currentSeries = controller.series.value[index];

                    DecorationImage seriesCover = DecorationImage(
                      image: AssetImage(Images.noImagePng500),
                      fit: BoxFit.contain,
                    );
                    //log("currentSeries.cover."+currentSeries.name!+": " + currentSeries.cover!);
                    //log("currentSeries.cover contains.jpg: " + currentSeries.cover!.contains(RegExp("\.jpg|\.jpeg|\.png", caseSensitive: false)).toString());
                    if (currentSeries.cover != null) {
                      //if (["png", "jpg", "jpeg"].contains(currentSeries.cover!.split(".").last))
                      /*if (currentSeries.cover!.contains(RegExp("\.jpg|\.jpeg|\.png", caseSensitive: false))) {
                        seriesCover = DecorationImage(
                            image: NetworkImage(currentSeries.cover!)
                                as ImageProvider,
                            fit: BoxFit.cover);
                      }*/
                      seriesCover = DecorationImage(
                          image: NetworkImage(currentSeries.cover!)
                          as ImageProvider,
                          fit: BoxFit.cover);
                    }

                    return InkWell(
                      onTap: () {
                        Get.find<SeriesDetailController>().clear();
                        dynamic args = Get.arguments;
                        args.addAll({
                          "series_id": controller.series.value[index].seriesId!
                              .toString(),
                          "series_name":
                              controller.series.value[index].name!.toString()
                        });
                        Get.toNamed(Routes.SERIES_DETAIL, arguments: args);
                      },
                      child: Container(
                        height: controller.seriesCoverSize.height,
                        child: Column(
                          verticalDirection: VerticalDirection.down,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              width: controller.seriesCoverSize.width,
                              height: controller.seriesCoverSize.height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: seriesCover,
                              ),
                              constraints: BoxConstraints(
                                minWidth: controller.seriesCoverSize.width,
                                minHeight: controller.seriesCoverSize.height,
                              ),
                              /*child: Image(
                    image: NetworkImage(controller.movies.value[index].streamIcon!) as ImageProvider,
                    fit: BoxFit.fill,
                  ),*/
                            ),
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(top: 2),
                              width: controller.seriesCoverSize.width,
                              child: CustomText(
                                color: ColorPalette.butColor,
                                text: currentSeries.name!,
                                textAlign: TextAlign.center,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                maxline: 2,
                                softWrap: false,
                                overflow: TextOverflow.clip,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ));
  }
}
