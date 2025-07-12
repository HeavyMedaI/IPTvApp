import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/models/xtream/movie.dart';
import 'package:guek_iptv/app/modules/movie_player_mediakit/controllers/movie_player_mediakit_controller.dart';

import 'package:guek_iptv/app/modules/vod_category/controllers/vod_category_controller.dart';
import 'package:guek_iptv/app/modules/vod_detail/controllers/vod_detail_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/widgets/custom_text.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';
import 'package:guek_iptv/constants/textstyle.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VodCategoryView extends GetView<VodCategoryController> {
  const VodCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.loadMovies(Get.arguments["category_id"]!);

    if (Get.currentRoute == Routes.VOD_CATEGORY && context.isLandscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    return PopScope(
        onPopInvoked: (pop) {
          controller.clear();
          Get.find<VodDetailController>().clear();
          Get.find<MoviePlayerMediakitController>().clear();
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
          ),
          body: Obx(() {
            if (controller.movies.isEmpty) {
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
                  itemCount: controller.movies.length,
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Get.size.shortestSide < 600 ? 2 : 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 3,
                    childAspectRatio: .6,
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    MovieModel currentMovie = controller.movies.value[index];

                    /*DecorationImage noImage = DecorationImage(
                      image: AssetImage(Images.noImagePng500),
                      fit: BoxFit.contain,
                    );
                    bool coverLoaded = true;*/

                    DecorationImage movieCover = DecorationImage(
                      image: AssetImage(Images.noImagePng500),
                      fit: BoxFit.contain,
                    );

                    if (currentMovie.name == "") {
                      return Container(
                        height: controller.movieCoverSize.height,
                        child: Column(
                          verticalDirection: VerticalDirection.down,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              width: controller.movieCoverSize.width,
                              height: controller.movieCoverSize.height,
                              decoration: BoxDecoration(
                                //border: Border.all(color: ColorPalette.black, width: 2),
                                borderRadius: BorderRadius.circular(7),
                                image: movieCover,
                              ),
                              constraints: BoxConstraints(
                                minWidth: controller.movieCoverSize.width,
                                minHeight: controller.movieCoverSize.height,
                              ),
                            ),
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(top: 2),
                              width: controller.movieCoverSize.width,
                              child: CustomText(
                                color: ColorPalette.red,
                                text: "NO DATA",
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
                      );
                    }

                    /*log("streamIcon.streamIcon." +
                        currentMovie.name! +
                        ": " +
                        currentMovie.streamIcon!);
                    log("streamIcon.streamIcon contains.jpg: " +
                        currentMovie.streamIcon!
                            .contains(RegExp("\.jpg|\.jpeg|\.png",
                                caseSensitive: false))
                            .toString());*/
                    if (currentMovie.streamIcon != null) {
                      //if (["png", "jpg", "jpeg"].contains(currentMovie.streamIcon!.split(".").last)) {
                      /*if (currentMovie.streamIcon!.contains(RegExp("\.jpg|\.jpeg|\.png", caseSensitive: false))) {
                        movieCover = DecorationImage(
                            image: NetworkImage(currentMovie.streamIcon!)
                            as ImageProvider,
                            fit: BoxFit.cover);
                      }*/
                      movieCover = DecorationImage(
                          image: NetworkImage(currentMovie.streamIcon!)
                          as ImageProvider,
                          fit: BoxFit.cover,
                          /*onError: (err, st) {
                            coverLoaded = false;
                          }*/
                      );
                    }

                    return InkWell(
                      onTap: () {
                        controller.selectedMovieIndex.value = index;
                        Get.find<VodDetailController>().clear();
                        dynamic args = Get.arguments;
                        args.addAll({
                          "stream_id": currentMovie.streamId!.toString(),
                          "movie_name": currentMovie.name!.toString()
                        });
                        Get.toNamed(Routes.VOD_DETAIL, arguments: args);
                      },
                      child: Container(
                        height: controller.movieCoverSize.height,
                        child: Column(
                          verticalDirection: VerticalDirection.down,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              width: controller.movieCoverSize.width,
                              height: controller.movieCoverSize.height,
                              decoration: BoxDecoration(
                                //border: Border.all(color: ColorPalette.black, width: 2),
                                borderRadius: BorderRadius.circular(7),
                                image: movieCover,
                              ),
                              constraints: BoxConstraints(
                                minWidth: controller.movieCoverSize.width,
                                minHeight: controller.movieCoverSize.height,
                              ),
                            ),
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(top: 2),
                              width: controller.movieCoverSize.width,
                              child: CustomText(
                                color: ColorPalette.butColor,
                                text: currentMovie.name!,
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
