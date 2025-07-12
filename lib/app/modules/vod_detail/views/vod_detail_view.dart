import 'dart:developer';
//import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:external_video_player_launcher/external_video_player_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
//import 'package:launch_review/launch_review.dart';

//import 'package:guek_iptv/app/routes/app_pages.dart';
//import 'package:guek_iptv/constants/images.dart';
import 'package:guek_iptv/app/models/xtream/movie.dart';
import 'package:guek_iptv/app/models/xtream/movie_details.dart';
import 'package:guek_iptv/app/modules/movie_player_mediakit/controllers/movie_player_mediakit_controller.dart';
import 'package:guek_iptv/app/modules/vod_category/controllers/vod_category_controller.dart';
//import 'package:guek_iptv/app/modules/movie_player/views/movie_player_view.dart';

import 'package:guek_iptv/app/modules/vod_detail/controllers/vod_detail_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/app/widgets/custom_text.dart';
import 'package:guek_iptv/app/widgets/common.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';
import 'package:guek_iptv/constants/textstyle.dart';
import 'package:guek_iptv/utiles/utiles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class VodDetailView extends GetView<VodDetailController> {
  const VodDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    controller.loadMovie(Get.arguments["stream_id"]!.toString());
    controller.loadRelatedMovies(Get.arguments["stream_id"]!.toString(),
        count: 10);

    if (Get.currentRoute == Routes.VOD_DETAIL && context.isLandscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    return PopScope(
        onPopInvoked: (pop) {
          /*Get.find<MoviePlayerController>().movie.value = null;
          Get.find<MoviePlayerController>().disposePlayer();*/

          //Get.find<MoviePlayerController>().clear();
          Get.find<MoviePlayerMediakitController>().clear();
          Get.find<VodCategoryController>().selectedMovieIndex.value = 0;
          controller.clear();
        },
        child: Scaffold(
          backgroundColor: ColorPalette.appColor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorPalette.butColor),
            backgroundColor: ColorPalette.appColor.withAlpha(100),
            elevation: 0,
            centerTitle: true,
            title: Obx(() {
              if (controller.movie.value == null) {
                return Center(
                  child: LoadingAnimationWidget.horizontalRotatingDots(
                      color: ColorPalette.butColor, size: 30),
                );
              }
              return Text(
                controller.movie.value!.info!.name!,
                style: TextStyleClass.sourceSansProSemiBold(
                  size: 18.0,
                  color: ColorPalette.butColor
                ),
              );
            }),
            actions: [],
          ),
          body: Obx(() {
            if (controller.movieLoaded.isFalse) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorPalette.butColor, size: 50),
              );
            }

            String duration = "";
            var _duration = controller.movie.value!.info!.duration!.split(":");
            duration = int.parse(_duration[0]).toString() +
                " saat " +
                int.parse(_duration[1]).toString() +
                " dakika";
            return Container(
              //height: Get.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        //this.play();
                      },
                      child: Container(
                        height: Get.height * .4,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ColorPalette.appColor,
                          image: DecorationImage(
                              image: NetworkImage(
                                  (controller.movie.value!.info!.backdropPath !=
                                      null &&
                                      controller.movie.value!.info!
                                          .backdropPath!.length >
                                          0)
                                      ? controller
                                      .movie.value!.info!.backdropPath![0]
                                      .toString()
                                      : controller.movie.value!.info!
                                      .coverBig!) as ImageProvider,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.time,
                                        color: ColorPalette.white,
                                        size: 20.0,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          /*Text(
                                            "Filmi İzle",
                                            style: TextStyleClass
                                                .sourceSansProSemiBold(
                                              size: 16.0,
                                            ),
                                          ),*/
                                          Text(
                                            duration,
                                            style: TextStyleClass
                                                .sourceSansProRegular(
                                              size: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(
                                    controller.movie.value!.info!.coverBig!)
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
                                controller.movie.value!.info!.name!,
                                style: TextStyleClass.sourceSansProSemiBold(
                                  size: 16.0,
                                  color: ColorPalette.butColor
                                ),
                              ),
                              Text(
                                controller.movie.value!.info!.genre!,
                                style: TextStyleClass.sourceSansProRegular(
                                  size: 12.0,
                                  color: ColorPalette.black
                                      .withAlpha(100), //grey83
                                ),
                              ),
                              Text(
                                "Yıl: " +
                                    controller.movie.value!.info!.releasedate!
                                        .split("-")[0],
                                style: TextStyleClass.sourceSansProRegular(
                                  size: 12.0,
                                  color: ColorPalette.black
                                      .withAlpha(100), //grey83
                                ),
                              ),
                              Text(
                                "Süre: " + duration,
                                style: TextStyleClass.sourceSansProRegular(
                                  size: 12.0,
                                  color: ColorPalette.black
                                      .withAlpha(100), //grey83
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 13),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        controller.movie.value!.info!.description!,
                        textAlign: TextAlign.left,
                        style: TextStyleClass.sourceSansProRegular(
                          size: 12.0,
                          color: ColorPalette.butColor.withAlpha(190)
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Aktörler: " + controller.movie.value!.info!.actors!,
                        textAlign: TextAlign.left,
                        style: TextStyleClass.sourceSansProRegular(
                          size: 12.0,
                          color: ColorPalette.black.withAlpha(100), //grey83
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: Get.width,
                        height: 40,
                        child: ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 0),
                          children: [
                            (controller.movie.value!.info!.tmdbId != null &&
                                controller.movie.value!.info!.tmdbId != 0)
                                ? Container(
                              width: Get.size.shortestSide < 600
                                  ? Get.width * .2
                                  : Get.width * .29,
                              child: InkWell(
                                onTap: () async {
                                  Uri tmbd = Uri.parse(
                                      "https://www.themoviedb.org/movie/" +
                                          controller
                                              .movie.value!.info!.tmdbId!
                                              .toString());
                                  if (await canLaunchUrl(tmbd)) {
                                    await launchUrl(tmbd,
                                        mode:
                                        LaunchMode.inAppBrowserView);
                                  } else {
                                    showToast(
                                        "Bu işlemi şu an gerçekleştiremiyoruz.");
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    //color: ColorPalette.grey50,
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          ColorPalette.grad3_a
                                              .withAlpha(230),
                                          ColorPalette.grad3_b
                                              .withAlpha(230),
                                        ]),
                                    borderRadius:
                                    BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.info,
                                          color: ColorPalette.white,
                                          size: 12,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "TMDB",
                                          style: TextStyleClass
                                              .sourceSansProSemiBold(
                                            size: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                                : Spacer(),
                            SizedBox(width: 12),
                            Container(
                              width: Get.size.shortestSide < 600
                                  ? Get.width * .3
                                  : Get.width * .3,
                              child: InkWell(
                                onTap: () async {
                                  this.play();
                                },
                                child: Container(
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    //color: ColorPalette.grey50,
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          ColorPalette.grad3_b.withAlpha(230),
                                          ColorPalette.grad3_a.withAlpha(230),
                                        ]),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.play_circle,
                                          color: ColorPalette.white,
                                          size: 14,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "Filmi Oynat",
                                          style: TextStyleClass
                                              .sourceSansProSemiBold(
                                            size: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Container(
                              width: Get.size.shortestSide < 600
                                  ? Get.width * .40 //.47 both players
                                  : Get.width * .3,
                              child: InkWell(
                                onTap: () async {
                                  this.playExternal();
                                },
                                child: Container(
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    //color: ColorPalette.grey50,
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          ColorPalette.grad3_b.withAlpha(230),
                                          ColorPalette.grad3_a.withAlpha(230),
                                        ]),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        /*Icon(
                                        CupertinoIcons.play_circle,
                                        color: ColorPalette.white,
                                        size: 14,
                                      ),*/
                                        /*Container(
                                          width: 13,
                                          height: 20,
                                          padding: EdgeInsets.zero,
                                          //color: ColorPalette.white,
                                          decoration: BoxDecoration(
                                            color: ColorPalette.white,
                                            shape: BoxShape.circle,
                                            //border: Border.all(width: 0, color: Colors.transparent)
                                          ),
                                          child: Icon(
                                            CupertinoIcons.play_circle_fill,
                                            color: Colors.blue,
                                            size: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3.0,
                                        ),
                                        VerticalDivider(
                                          thickness: 1,
                                          color: ColorPalette.white,
                                          indent: 10,
                                          endIndent: 10,
                                          width: 8,
                                        ),*/
                                        SvgPicture.asset(
                                          Images.vlcIcon,
                                          width: 15,
                                          height: 15,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "VLC Player'da Oynat",
                                          style: TextStyleClass
                                              .sourceSansProSemiBold(
                                            size: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    commonRow(title: "Benzer Filmler"),
                    SizedBox(
                      height: 10,
                    ),
                    controller.relatedMovies.length > 0
                        ? this.buildRelatedMovies()
                        : Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: ColorPalette.butColor, size: 50),
                    ),
                    SizedBox(height: 0),
                  ],
                ),
              ),
            );
          }),
        ));
  }

  Future<void> play() async {
    //Get.find<LivePlayerController>().loadChannel(channel);
    MovieModel _movie = controller.categoryController.movies[controller.categoryController.selectedMovieIndex.value];
    Get.find<MoviePlayerMediakitController>().loadMovie(_movie);
    dynamic args = Get.arguments;
    log("args: " + args.toString());
    args.addAll({
      "stream_id": _movie.streamId!.toString(),
    });
    log("args: " + args.toString());
    Get.toNamed(Routes.MOVIE_PLAYER_MEDIAKIT, arguments: args);
  }

  Future<void> playExternal() async {
    String videoUrl = controller.auth.session.value!.serverInfo!.getApiUrl() +
        "/movie/${controller.auth.session.value!.username!}/${controller.auth.session.value!.password!}/${controller.movie.value!.movieData!.streamId!}.${controller.movie.value!.movieData!.containerExtension!}";

    //await Share.shareXFiles([XFile(videoUrl, name: controller.movie.value!.movieData!.name!, mimeType: controller.movie.value!.movieData!.containerExtension!)], subject: controller.movie.value!.movieData!.name!, text: "Oynatıcı seçin");
    //await Share.shareUri(Uri.parse(videoUrl));

    await openVlcPlayer(controller.movie.value!.movieData!.name!, videoUrl,
        controller.movie.value!.movieData!.containerExtension);

    String mimeType = MIME.applicationMp4; // MIME.applicationXMpegURL
    if (controller.movie.value!.movieData!.containerExtension! == "mp4") {
      mimeType = MIME.applicationMp4;
    }

    /*if (Platform.isAndroid) {
      await AppCheck.checkAvailability("com.alptech.iptv").then((app) async {
        debugPrint("check iptv: " + app!.packageName);
        bool isIpTvEnabled = await AppCheck.isAppEnabled(app!.packageName);
        debugPrint("check iptv enabled: " + isIpTvEnabled.toString());
        if (!isIpTvEnabled) {
          showWarning(Get.context!, "Uyarı", "IPTv uygulaması etkisizleştirilmiş, lütfen ayarlardan etkinleştirin.");
        }
      });

      try {
        //showWarning(Get.context!, "Uyarı", "MX Player uygulaması etkisizleştirilmiş, lütfen ayarlardan etkinleştirin.");

        await AppCheck.checkAvailability("com.mxtech.videoplayer.ad").then((app) async {
          debugPrint("check mx: " + app.toString());
          bool isMxEnabled = await AppCheck.isAppEnabled(app!.packageName);
          debugPrint("check mx enabled: " + isMxEnabled.toString());
          if (!isMxEnabled) {
            showWarning(Get.context!, "Uyarı", "MX Player uygulaması etkisizleştirilmiş, lütfen ayarlardan etkinleştirin.");
          }else{
            ExternalVideoPlayerLauncher.launchMxPlayer(videoUrl, mimeType, {
              "title": controller.movie.value!.movieData!.name!.toString(),
              "name": controller.movie.value!.movieData!.name!.toString()
            });
          }
        });
      }on PlatformException catch(mxErr) {
        debugPrint("mxCheckError: " + mxErr.toString());
        try {
          await AppCheck.checkAvailability("org.videolan.vlc").then((app) async {
            debugPrint("check vlc: " + app.toString());
            bool isVlcEnabled = await AppCheck.isAppEnabled(app!.packageName);
            debugPrint("check vlc enabled: " + isVlcEnabled.toString());
            if (!isVlcEnabled) {
              showWarning(Get.context!, "Uyarı", "VLC Player uygulaması etkisizleştirilmiş, lütfen ayarlardan etkinleştirin.");
            }else{
              ExternalVideoPlayerLauncher.launchVlcPlayer(videoUrl, mimeType, {
                "title": controller.movie.value!.movieData!.name!.toString(),
                "name": controller.movie.value!.movieData!.name!.toString()
              });
            }
          });
        } on PlatformException catch(vlcErr) {
          debugPrint("vlcCheckError: " + vlcErr.toString());
          await LaunchReview.launch(androidAppId: "com.mxtech.videoplayer.ad", writeReview: false);
        }
      }
    }else if(Platform.isIOS) {}*/

    /*try {
      ExternalVideoPlayerLauncher.launchMxPlayer(videoUrl, mimeType, {
        "title": controller.movie.value!.movieData!.name!.toString(),
        "name": controller.movie.value!.movieData!.name!.toString()
      });
    } on Error catch(e) {
      debugPrint("launchExternalPlayer: " + e.toString());
    }*/
  }

  Widget buildRelatedMovies() {
    return SizedBox(
      height: controller.relatedMovieCoverSize.height + 60,
      child: ListView.builder(
        itemCount: controller.relatedMovies.length,
        padding: EdgeInsets.only(left: 20),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          MovieModel relatedMovie =
              controller.relatedMovies.value[index]["movie"];
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () async {
                Get.find<VodCategoryController>().selectedMovieIndex.value = controller.relatedMovies.value[index]["index"];
                controller.clear();
                await controller.loadMovie(relatedMovie.streamId!);
                Get.arguments["movie_name"] =
                    controller.movie.value!.info!.name!;
              },
              child: Column(
                verticalDirection: VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: controller.relatedMovieCoverSize.width,
                    height: controller.relatedMovieCoverSize.height,
                    // margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(relatedMovie.streamIcon!)
                            as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 5),
                    width: controller.relatedMovieCoverSize.width,
                    child: CustomText(
                      color: ColorPalette.butColor,
                      text: relatedMovie.name!,
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
    );
  }
}
