import 'dart:developer';

import 'package:external_video_player_launcher/external_video_player_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:guek_iptv/app/models/xtream/channel.dart';
import 'package:guek_iptv/app/modules/live_player_mediakit/controllers/live_player_mediakit_controller.dart';
import 'package:guek_iptv/app/routes/app_pages.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/images.dart';
import 'package:guek_iptv/constants/textstyle.dart';
import 'package:guek_iptv/utiles/utiles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marquee/marquee.dart';

import '../controllers/live_category_controller.dart';

class LiveCategoryView extends GetView<LiveCategoryController> {
  const LiveCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    controller.loadChannels(Get.arguments["category_id"]!);

    if (Get.currentRoute == Routes.LIVE_CATEGORY && context.isLandscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    log("live category view");

    return PopScope(
      onPopInvoked: (pop) {
        //Get.find<LivePlayerController>().clear();
        Get.find<LivePlayerMediakitController>().clear();
        controller.clear();
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
          if (controller.channels.isEmpty) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: ColorPalette.butColor, size: 50),
            );
          }

          List<ListTile> channels = <ListTile>[];
          if (controller.channels.isNotEmpty) {
            controller.channels
                .asMap()
                .entries
                .forEach((MapEntry<int, ChannelModel> channelEntry) {
              //String currentEpg = await controller.getCurrentEpg(channel.streamId!);
              //log("current epg: " + currentEpg);

              //log(controller.epgList.toJson().toString());

              ChannelModel channel = channelEntry.value;

              DecorationImage channelCover = DecorationImage(
                image: AssetImage(Images.noImagePng500),
                fit: BoxFit.contain,
              );
              if (channel.streamIcon != null) {
                //if (["png", "jpg", "jpeg"].contains(channel.streamIcon!.split(".").last)) {
                /*if (channel.streamIcon!.contains(RegExp("\.jpg|\.jpeg|\.png", caseSensitive: false))) {
                  channelCover = DecorationImage(
                      image: NetworkImage(channel.streamIcon!) as ImageProvider,
                      fit: BoxFit.contain);
                }*/
                channelCover = DecorationImage(
                    image: NetworkImage(channel.streamIcon!) as ImageProvider,
                    fit: BoxFit.contain,
                    alignment: Alignment.center);
              }
              /*Text(
                controller.epgList[channel.streamId]!,
                style: TextStyleClass.sourceSansProRegular(
                  size: 12.0,
                  color: ColorPalette.black.withAlpha(150),
                ),
              )*/

              /*if (controller.epgList.containsKey(channel.streamId!) == false) {
                controller.epgList.addAll({channel.streamId!: Rx(null)});
              }*/

              channels.add(ListTile(
                contentPadding: EdgeInsets.zero,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                selectedColor: Colors.transparent,
                selectedTileColor: Colors.transparent,
                splashColor: ColorPalette.butColor.withAlpha(100),
                onTap: () {
                  //play(channel);
                },
                titleAlignment: ListTileTitleAlignment.threeLine,
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    channel.name!,
                    style: TextStyleClass.sourceSansProSemiBold(
                        size: 16.0, color: ColorPalette.butColor),
                  ),
                ),
                subtitle: controller.epgList.value.isEmpty ||
                        controller.epgList.value
                                .containsKey(channel.streamId!) ==
                            false ||
                        controller.epgList.value[channel.streamId!]! == null
                    /*|| controller.epgList.value[channel.streamId!]!.value == null*/
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 25,
                            height: 20,
                            child: LoadingAnimationWidget.prograssiveDots(
                                color: ColorPalette.black2F, size: 15),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            width: Get.width,
                            height: 30,
                            child: Marquee(
                              text:
                                  controller.epgList.value[channel.streamId!]!,
                              style: TextStyle(
                                  color: ColorPalette.black2F.withAlpha(200)),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              velocity: 30.0,
                              blankSpace: 10.0,
                            ),
                            /*child: Text(
                              controller.epgList.value[channel.streamId!]!,
                              style: TextStyleClass.sourceSansProRegular(
                                size: 12.0,
                                color: ColorPalette.black.withAlpha(150),
                              ),
                            ),*/
                          ),
                        ],
                      ),
                /*subtitle: Column(
                  children: [
                    Container(
                      width: Get.width * .5,
                      height: 40,
                      child: Marquee(
                        text: currentEpg,
                        style: TextStyle(color: ColorPalette.white.withAlpha(200)),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        velocity: 30.0,
                        blankSpace: 10.0,
                      ),
                    ),
                  ],
                ),*/
                minLeadingWidth: controller.coverWidth,
                leading: Padding(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: SizedBox(
                    height: controller.coverHeight,
                    width: controller.coverWidth,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ColorPalette.butColor.withAlpha(15),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Container(
                        height: controller.coverHeight,
                        width: controller.coverWidth,
                        decoration: BoxDecoration(
                          image: channelCover,
                        ),
                      ),
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        IconButton(
                          alignment: Alignment.center,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ColorPalette.butColor.withAlpha(50),
                            padding: EdgeInsets.zero,
                            minimumSize: Size(39.0, 39.0),
                            maximumSize: Size(39.0, 39.0),
                          ),
                          /*icon: Container(
                            width: 20,
                            height: 15,
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                            //color: ColorPalette.white,
                            decoration: BoxDecoration(
                                color: ColorPalette.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ColorPalette.butColor, width: 0)
                              //border: Border.all(width: 0, color: Colors.transparent)
                            ),
                            child: Icon(
                              CupertinoIcons.play_circle_fill,
                              color: Colors.blue,
                              size: 22,
                            ),
                          ),*/
                          icon: Stack(
                            alignment: Alignment.center,
                            textDirection: TextDirection.ltr,
                            fit: StackFit.loose,
                            children: [
                              Container(
                                width: 14,
                                height: 14,
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
                                  width: 15,
                                  height: 15,
                                ),
                              ),
                              /*Icon(
                                CupertinoIcons.play_circle_fill,
                                color: Colors.blue,
                                size: 28.0,
                              ),*/
                            ],
                          ),
                          onPressed: () {
                            playExternal(channel!);
                          },
                        ),
                        IconButton(
                          alignment: Alignment.center,
                          icon: Icon(
                            CupertinoIcons.play_circle_fill,
                            //color: ColorPalette.grad3_b.withAlpha(500),
                            color: ColorPalette.butColor.withAlpha(500),
                            size: 44.0,
                          ),
                          onPressed: () {
                            controller.selectedChannelIndex.value =
                                channelEntry.key;
                            play(channel!);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ));
            });

            if (controller.epgsLoaded.isFalse) {
              controller.loadEpgs();
              //controller.loadEpgsPersistently();
            }

            //log("epg List: " + controller.epgList.toString());
          }

          return Container(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    ...channels,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> play(ChannelModel channel) async {
    Get.find<LivePlayerMediakitController>().loadChannel(channel);
    dynamic args = Get.arguments;
    log("args: " + args.toString());
    args.addAll({
      "channel_id": channel.cId.toString(),
      "stream_id": channel.streamId!.toString(),
    });
    log("args: " + args.toString());
    Get.toNamed(Routes.LIVE_PLAYER_MEDIAKIT, arguments: args);
  }

  Future<void> playExternal(ChannelModel channel) async {
    String streamUrl = controller.auth.session.value!.serverInfo!.getApiUrl() +
        "/${controller.auth.session.value!.username!}/${controller.auth.session.value!.password!}/${channel.streamId!}";

    log("live.playExternal.streamUrl: " + streamUrl);

    await openVlcPlayer(channel.name!, streamUrl, null);
  }
}
