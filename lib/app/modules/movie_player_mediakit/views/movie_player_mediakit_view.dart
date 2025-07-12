import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/textstyle.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../controllers/movie_player_mediakit_controller.dart';

class MoviePlayerMediakitView extends GetView<MoviePlayerMediakitController> {
  const MoviePlayerMediakitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    dynamic args = Get.arguments;

    if (context.mounted) {
      Timer(
        Duration(seconds: 1),
            () {
          if (controller.videoState.currentState != null) {
            setScreen(context);
          }else{
            controller.videoPlayer.stream.playing.listen((isPlaying) {
              setScreen(context);
            });
          }
        },
      );
    }

    return PopScope(
      onPopInvoked: (pop) async {
        /*controller.movie.value = null;
        controller.disposePlayer();*/
        controller.clear();
        //await Get.offAndToNamed(Routes.LIVE_CATEGORY, arguments: args);
        //Get.until((route) => Get.currentRoute == Routes.VOD_DETAIL);
        //controller.clear();
      },
      child: Scaffold(
        backgroundColor: ColorPalette.black2F,
        appBar: context.isPortrait ? AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: ColorPalette.white),
          backgroundColor: ColorPalette.black2F,
          elevation: 0,
          centerTitle: true,
          title: Obx(() {
            if (controller.movie.value == null) {
              return Center(
                child: LoadingAnimationWidget.horizontalRotatingDots(
                    color: ColorPalette.white, size: 30),
              );
            }
            return Text(
              controller.movie.value!.name!,
              style: TextStyleClass.sourceSansProSemiBold(
                size: 18.0,
              ),
            );
          }),
          /*leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back)
          ),*/
          actions: [],
        ) :null,
        body: SafeArea(
          child: Obx(() {
            if (controller.videoLoaded.isFalse ||
                controller.playerReady.isFalse) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorPalette.white, size: 50),
              );
            }

            log("video loaded: " + controller.videoLoaded.value.toString());
            log("player ready: " + controller.playerReady.value.toString());

            return Center(
              child: SizedBox(
                width: Get.width,
                height: Get.width * 9.0 / 16.0,
                // Use [Video] widget to display video output.
                child: MaterialVideoControlsTheme(
                  normal: MaterialVideoControlsThemeData(
                      displaySeekBar: true,
                      brightnessGesture: true,
                      volumeGesture: true,
                      primaryButtonBar: [
                        Spacer(flex: 2),
                        MaterialSkipPreviousButton(),
                        Spacer(),
                        MaterialPlayOrPauseButton(iconSize: 48.0),
                        Spacer(),
                        MaterialSkipNextButton(),
                        Spacer(flex: 2),
                      ]),
                  fullscreen: MaterialVideoControlsThemeData(
                    displaySeekBar: true,
                    brightnessGesture: true,
                    volumeGesture: true,
                    topButtonBar: [
                      MaterialCustomButton(
                          icon: Icon(Icons.arrow_back_ios_new_outlined),
                          onPressed: () async {
                            await controller.videoState.currentState?.exitFullscreen();
                            SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp],
                            );
                            //await Get.offAndToNamed(Routes.LIVE_CATEGORY, arguments: args);
                            //Get.until((route) => Get.currentRoute == Routes.VOD_DETAIL);
                            controller.clear();
                            Get.back();
                          }),
                      /*Spacer(
                        flex: 2,
                      ),
                      MaterialCustomButton(
                          icon: Icon(Icons.image_outlined),
                          onPressed: () async {
                            await captureScreenshot();
                          }),*/
                    ],
                  ),
                  child: Video(
                    key: controller.videoState,
                    controller: controller.playerController,
                    filterQuality: FilterQuality.medium,
                    pauseUponEnteringBackgroundMode: false,
                    wakelock: true,
                    onEnterFullscreen: () async {
                      try {
                        await Future.wait(
                          [
                            SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.immersiveSticky,
                              overlays: [],
                            ),
                            SystemChrome.setPreferredOrientations(
                              [
                                DeviceOrientation.landscapeLeft,
                                DeviceOrientation.landscapeRight,
                              ],
                            ),
                          ],
                        );
                      } catch (exception, stacktrace) {
                        debugPrint(exception.toString());
                        debugPrint(stacktrace.toString());
                      }
                    },
                    onExitFullscreen: () async {
                      try {
                        Get.until((route) => Get.currentRoute == Routes.MOVIE_PLAYER_MEDIAKIT);
                        await Future.wait(
                          [
                            SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.manual,
                              overlays: SystemUiOverlay.values,
                            ),
                            SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp],
                            ),
                          ],
                        );
                      } catch (exception, stacktrace) {
                        debugPrint(exception.toString());
                        debugPrint(stacktrace.toString());
                      }
                    },
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void setScreen(BuildContext context) {
    if (context.isPortrait && controller.videoState.currentState!.isFullscreen()) {
      controller.videoState.currentState!.toggleFullscreen();
    } else if (context.isLandscape && !controller.videoState.currentState!.isFullscreen()) {
      controller.videoState.currentState!.toggleFullscreen();
    }
  }
}
