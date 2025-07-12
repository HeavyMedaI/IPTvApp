import 'dart:developer';
//import 'dart:io';

//import 'package:appcheck/appcheck.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';

//import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
//import 'package:external_video_player_launcher/external_video_player_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

//import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/models/xtream/series_details.dart';
import 'package:guek_iptv/app/modules/series_player_mediakit/controllers/series_player_mediakit_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/widgets/custom_text.dart';
import 'package:guek_iptv/app/widgets/common.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';
import 'package:guek_iptv/constants/textstyle.dart';
import 'package:guek_iptv/utiles/utiles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
//import 'package:url_launcher/url_launcher.dart';

import '../controllers/series_detail_controller.dart';

class SeriesDetailView extends GetView<SeriesDetailController> {
  const SeriesDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    double headerHeight = 70.0;

    if (Get.arguments != null) {
      controller.loadSeries(Get.arguments["series_id"]!.toString());
    }

    if (Get.currentRoute == Routes.SERIES_DETAIL && context.isLandscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    return PopScope(
        onPopInvoked: (pop) {
          controller.clear();
          Get.find<SeriesPlayerMediakitController>().clear();
        },
        child: Scaffold(
          backgroundColor: ColorPalette.appColor,
          /*appBar: AppBar(
              iconTheme: IconThemeData(color: ColorPalette.white),
              backgroundColor: ColorPalette.appColor,
              elevation: 0,
              centerTitle: true,
              title: Text(
                Get.arguments["series_name"],
                style: TextStyleClass.sourceSansProSemiBold(
                  size: 18.0,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    //Get.to(() => Search());
                    await FlutterShare.share(
                        title: Get.arguments["series_name"]!,
                        text: 'Example share text',
                        linkUrl: 'https://flutter.dev/',
                        chooserTitle: 'Example Chooser Title');
                  },
                  icon: Icon(
                    Icons.share,
                    color: ColorPalette.white,
                  ),
                ),
              ],
            ),*/
          body: Obx(() {
            if (controller.seriesLoaded.isFalse) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorPalette.butColor, size: 50),
              );
            }

            return Container(
              height: Get.height,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: Get.height * .3,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ColorPalette.grey48,
                          image: DecorationImage(
                              image: NetworkImage(controller.series.value!.info!
                                              .backdropPath!.length >
                                          0
                                      ? controller
                                          .series.value!.info!.backdropPath![0]
                                          .toString()
                                      : controller.series.value!.info!.cover!)
                                  as ImageProvider,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            /*Image(
                              image: AssetImage(
                                Images.shado,
                              ),
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),*/
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 58,
                            height: 80,
                            // margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(
                                        controller.series.value!.info!.cover!)
                                    as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.series.value!.info!.name!,
                                style: TextStyleClass.sourceSansProSemiBold(
                                    size: 16.0, color: ColorPalette.butColor),
                              ),
                              Text(
                                controller.series.value!.info!.genre!,
                                style: TextStyleClass.sourceSansProRegular(
                                  size: 12.0,
                                  color: ColorPalette.black.withAlpha(100),
                                ),
                              ),
                              Text(
                                "Yıl: " +
                                    controller.series.value!.info!.releaseDate!
                                        .split("-")[0],
                                style: TextStyleClass.sourceSansProRegular(
                                  size: 12.0,
                                  color: ColorPalette.black.withAlpha(100),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 13),
                    Container(
                      height: Get.height * .1,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            controller.series.value!.info!.plot!,
                            textAlign: TextAlign.left,
                            style: TextStyleClass.sourceSansProRegular(
                                size: 12.0,
                                color: ColorPalette.butColor.withAlpha(190)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Aktörler: " + controller.series.value!.info!.cast!,
                        textAlign: TextAlign.left,
                        style: TextStyleClass.sourceSansProRegular(
                          size: 12.0,
                          color: ColorPalette.black.withAlpha(100),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    (controller.series.value!.seasons!.length <= 0 &&
                            controller.series.value!.episodes!.length <= 0)
                        ? Center(
                            child: CustomText(
                              text: "İçerik mevcut değil",
                              color: ColorPalette.butColor.withAlpha(475),
                            ),
                          )
                        : Container(
                            height: Get.height * .42,
                            //padding: EdgeInsets.only(bottom: 40),
                            child: this.buildTabBar(),
                          ),
                    //commonListView(list: controller.relatedMovies),
                  ],
                ),
              ),
            );
          }),
        ));
  }

  Future<void> play(EpisodeModel episode) async {
    //Get.find<SeriesPlayerController>().loadVideo(episode);
    await Get.find<SeriesPlayerMediakitController>().loadMovie(episode);
    dynamic args = Get.arguments;
    args.addAll({
      "episode_id": episode.id!.toString(),
    });
    await Get.toNamed(Routes.SERIES_PLAYER_MEDIAKIT, arguments: args);
  }

  Future<void> playExternal(EpisodeModel episode) async {
    String videoUrl = controller.auth.session.value!.serverInfo!.getApiUrl() +
        "/series/${controller.auth.session.value!.username!}/${controller.auth.session.value!.password!}/${episode.id!}.${episode.containerExtension!}";

    await openVlcPlayer(episode.title!, videoUrl, episode.containerExtension);

    /*String mimeType = MIME.applicationMp4; // MIME.applicationXMpegURL
    if (episode.containerExtension! == "mp4") {
      mimeType = MIME.applicationMp4;
    }*/

    /*ExternalVideoPlayerLauncher.launchVlcPlayer(videoUrl, mimeType, {
      "title": episode.title!.toString(),
      "name": episode.title!.toString()
    });*/
  }

  Widget buildTabBar() {
    if (controller.series.value!.seasons!.length <= 0) {
      controller.series.value!.episodes!.forEach((index, season) {
        controller.series.value!.seasons!.add(SeasonModel(
          name: "Sezon ${index}",
          seriesId: season[0].seriesId,
          seasonNumber: int.tryParse(index),
          episodeCount: season.length
        ));
      });
    }
    return DynamicTabBarWidget(
      physics: ClampingScrollPhysics(),
      physicsTabBarView: ClampingScrollPhysics(),
      isScrollable: true,
      showBackIcon: controller.series.value!.seasons != null &&
          controller.series.value!.seasons!.length > 4,
      showNextIcon: controller.series.value!.seasons != null &&
          controller.series.value!.seasons!.length > 4,
      dividerHeight: .2,
      tabAlignment: TabAlignment.start,
      dividerColor: ColorPalette.white,
      labelColor: ColorPalette.butColor,
      backIcon: Icon(
        Icons.chevron_left,
        color: ColorPalette.butColor.withAlpha(500),
      ),
      nextIcon: Icon(
        Icons.chevron_right,
        color: ColorPalette.butColor.withAlpha(500),
      ),
      indicatorWeight: .1,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: ColorPalette.butColor,
      labelStyle: TextStyle(fontSize: 15, color: ColorPalette.butColor),
      dynamicTabs: List<TabData>.from(controller.series.value!.seasons!
          .asMap()
          .entries
          .map((MapEntry<int, SeasonModel> seasonEntry) {
        SeasonModel season = seasonEntry.value;
        return TabData(
            index: season!.seasonNumber!,
            title: Tab(
              child: Text(
                season!.name!,
                style: TextStyleClass.sourceSansProBold(
                  size: 15.0,
                  color: ColorPalette.butColor.withAlpha(500),
                ),
              ),
            ),
            content: Container(
              //padding: EdgeInsets.symmetric(horizontal: 20),
              child: (controller.series.value!.episodes!
                          .containsKey(season!.seasonNumber!.toString()) &&
                      controller
                              .series
                              .value!
                              .episodes![season!.seasonNumber!.toString()]!
                              .length >
                          0)
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: controller
                              .series
                              .value!
                              .episodes![season!.seasonNumber!.toString()]!
                              .length +
                          0,
                      itemBuilder: (context, episodeIndex) {
                        if (controller.series.value!
                                .episodes![season!.seasonNumber!.toString()]!
                                .asMap()
                                .containsKey(episodeIndex) ==
                            false) {
                          return ListTile(
                            title: Text(""),
                          );
                        }
                        EpisodeModel episode = controller
                                .series.value!.episodes![
                            season!.seasonNumber!.toString()]![episodeIndex];
                        return ListTile(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          selectedColor: Colors.transparent,
                          selectedTileColor: Colors.transparent,
                          splashColor: ColorPalette.butColor.withAlpha(100),
                          title: Text(
                            "Bölüm ${episode!.episodeNum!}",
                            style: TextStyleClass.sourceSansProBold(
                              size: 15.0,
                              color: ColorPalette.butColor.withAlpha(500),
                            ),
                          ),
                          subtitle: Text(
                            episode!.title!,
                            style: TextStyleClass.sourceSansProRegular(
                              size: 12.0,
                              color: ColorPalette.black.withAlpha(150),
                            ),
                          ),
                          onTap: () {
                            //play(episode!);
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                alignment: Alignment.center,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ColorPalette.butColor.withAlpha(50),
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(32.0, 32.0),
                                  maximumSize: Size(32.0, 32.0),
                                ),
                                icon: Stack(
                                  alignment: Alignment.center,
                                  textDirection: TextDirection.ltr,
                                  fit: StackFit.loose,
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      alignment: Alignment.center,
                                      transformAlignment: Alignment.center,
                                      padding: EdgeInsets.zero,
                                      margin: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                        //color: ColorPalette.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        Images.vlcIcon,
                                        width: 14,
                                        height: 14,
                                      ),
                                    ),
                                    /*Icon(
                                      CupertinoIcons.play_circle_fill,
                                      color: Colors.blue,
                                      size: 22.0,
                                    ),*/
                                  ],
                                ),
                                onPressed: () {
                                  playExternal(episode!);
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.selectedSeasonIndex.value =
                                      seasonEntry.key;
                                  controller.selectedSeasonNumber.value =
                                      season.seasonNumber!;
                                  controller.selectedEpisodeIndex.value =
                                      episodeIndex;
                                  play(episode!);
                                },
                                icon: Icon(
                                  CupertinoIcons.play_circle_fill,
                                  color: ColorPalette.grad3_b.withAlpha(500),
                                  size: 35.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                  : Center(
                      child: CustomText(
                        text: "Bölüm mevcut değil",
                        color: ColorPalette.butColor.withAlpha(475),
                      ),
                    ),
            ));
      })),
      onTabChanged: (int? index) {},
      onTabControllerUpdated: (tabController) {},
    );
  }
}
