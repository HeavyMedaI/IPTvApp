import 'dart:async';
import 'dart:developer';
import 'dart:io';

//import 'package:awesome_gallery_saver/gallery_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_share/flutter_share.dart';
//import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:guek_iptv/app/models/xtream/channel.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/textstyle.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:media_kit/ffi/ffi.dart';
import 'package:media_kit/media_kit.dart';

import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../controllers/live_player_mediakit_controller.dart';

class LivePlayerMediakitView extends GetView<LivePlayerMediakitController> {
  LivePlayerMediakitView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    dynamic args = Get.arguments;
    /*if (Get.arguments["category_id"] != null) {
      controller.currentCatId.value = int.parse(Get.arguments["category_id"]);
      controller.currentCatName.value = Get.arguments["category_name"];
    }*/

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
        //Get.until((route) => Get.currentRoute == Routes.LIVE_CATEGORY);
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
            if (controller.channel.value == null) {
              return Center(
                child: LoadingAnimationWidget.horizontalRotatingDots(
                    color: ColorPalette.white, size: 30),
              );
            }
            return Text(
              controller.channel.value!.name!,
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
                      displaySeekBar: false,
                      brightnessGesture: true,
                      volumeGesture: true,
                      /*topButtonBar: [
                        Spacer(
                          flex: 2,
                        ),
                        MaterialCustomButton(
                            icon: Icon(Icons.image_outlined),
                            onPressed: () async {
                              //await captureScreenshot();
                              await controller.videoState.currentState!.enterFullscreen();
                            }),
                      ],*/
                      bottomButtonBar: [
                        Spacer(),
                        MaterialFullscreenButton()
                      ],
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
                    displaySeekBar: false,
                    brightnessGesture: true,
                    volumeGesture: true,
                    topButtonBar: [
                      MaterialCustomButton(
                          icon: Icon(Icons.arrow_back_ios_new_outlined),
                          onPressed: () async {
                            await controller.videoState.currentState?.exitFullscreen();
                            //await Get.offAndToNamed(Routes.LIVE_CATEGORY, arguments: args);
                            //Get.until((route) => Get.currentRoute == Routes.LIVE_CATEGORY);
                            Get.back();
                            controller.clear();
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
                    bottomButtonBar: [Spacer(), MaterialFullscreenButton()],
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
                        Get.until((route) => Get.currentRoute == Routes.LIVE_PLAYER_MEDIAKIT);
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
            
            return OrientationBuilder(builder: (context, orientation) {
              log("orientation: " + orientation.name);
              if (controller.videoState.currentState != null) {
                setOrientation(orientation);
              }else{
                controller.videoPlayer.stream.playing.listen((isPlaying) {
                  setOrientation(orientation);
                });
              }
              return Center(
                child: SizedBox(
                  width: Get.width,
                  height: Get.width * 9.0 / 16.0,
                  // Use [Video] widget to display video output.
                  child: MaterialVideoControlsTheme(
                    normal: MaterialVideoControlsThemeData(
                        displaySeekBar: false,
                        brightnessGesture: true,
                        volumeGesture: true,
                        /*topButtonBar: [
                        Spacer(
                          flex: 2,
                        ),
                        MaterialCustomButton(
                            icon: Icon(Icons.image_outlined),
                            onPressed: () async {
                              //await captureScreenshot();
                              await controller.videoState.currentState!.enterFullscreen();
                            }),
                      ],*/
                        bottomButtonBar: [
                          Spacer(),
                          MaterialFullscreenButton()
                        ],
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
                      displaySeekBar: false,
                      brightnessGesture: true,
                      volumeGesture: true,
                      topButtonBar: [
                        MaterialCustomButton(
                            icon: Icon(Icons.arrow_back_ios_new_outlined),
                            onPressed: () async {
                              await controller.videoState.currentState?.exitFullscreen();
                              //await Get.offAndToNamed(Routes.LIVE_CATEGORY, arguments: args);
                              Get.until((route) => Get.currentRoute == Routes.LIVE_CATEGORY);
                              //controller.clear();
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
                      bottomButtonBar: [Spacer(), MaterialFullscreenButton()],
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
            });
          }),
        ),
      ),
    );
  }

  void setOrientation(Orientation orientation) {
    if (orientation == Orientation.portrait && controller.videoState.currentState!.isFullscreen()) {
      controller.videoState.currentState!.exitFullscreen();
    } else if (orientation == Orientation.landscape && controller.videoState.currentState!.isFullscreen() == false) {
      controller.videoState.currentState!.toggleFullscreen();
    }
  }

  void setScreen(BuildContext context) {
    debugPrint("device portraint: " + context.orientation.name);
    debugPrint("context.isPortrait: " + context.isPortrait.toString());
    debugPrint("video.isFullscreen: " + controller.videoState.currentState!.isFullscreen().toString());

    if (context.isPortrait && controller.videoState.currentState!.isFullscreen()) {
      controller.videoState.currentState!.toggleFullscreen();
    } else if (context.isLandscape && !controller.videoState.currentState!.isFullscreen()) {
      controller.videoState.currentState!.toggleFullscreen();
    }
  }

  /*Future<void> captureScreenshot() async {
    Uint8List? ss = await controller.playerController.player.screenshot();
    dynamic saveSs = await GallerySaver.saveImage(ss!,
        quality: 100,
        name: controller.channel.value!.name! +
            DateTime.now().toLocal().toString() +
            ".jpeg");
    log("save to gallery: " + saveSs.toString());
  }*/
}
