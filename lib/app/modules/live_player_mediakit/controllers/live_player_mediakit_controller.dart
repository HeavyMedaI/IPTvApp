import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/channel.dart';
import 'package:guek_iptv/app/modules/live_category/controllers/live_category_controller.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';

class LivePlayerMediakitController extends GetxController {
  double videoHeight = 220;
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");
  LiveCategoryController categoryController =
  Get.find<LiveCategoryController>();

  late Player videoPlayer;
  late VideoController playerController;
  late final GlobalKey<VideoState> videoState = GlobalKey<VideoState>();

  Rx<ChannelModel?> channel = Rx<ChannelModel?>(null);

  RxInt currentCatId = 0.obs;
  RxString currentCatName = "".obs;
  RxInt currentChannel = 0.obs;

  RxBool videoLoaded = false.obs;
  RxBool playerReady = false.obs;

  Future<void> loadChannel(ChannelModel _channel) async {
    channel.value = _channel;
    videoLoaded.value = true;
    await loadPlayer();
  }

  void initPlayer() {
    videoPlayer = Player();
    videoPlayer.setPlaylistMode(PlaylistMode.none);
  }

  Future<void> loadPlayer() async {
    String liveUrlPath = auth.session.value!.serverInfo!.getApiUrl(rtmp: false) +
        "/${auth.session.value!.username!}/${auth.session.value!.password!}";

    log("stream url: ${liveUrlPath}/${channel.value!.streamId!}");

    Playlist playList = Playlist(List<Media>.from(categoryController.channels.map((ChannelModel channelModel) {
      return Media("${liveUrlPath}/${channelModel.streamId!}", extras: {
        "title": channelModel.name!
      });
    })), index: categoryController.selectedChannelIndex.value);
    await videoPlayer.open(playList, play: true).then((value) async {
      playerReady.value = true;
      videoPlayer.setSubtitleTrack(SubtitleTrack.no());
      videoPlayer.stream.playlist.listen((Playlist event) {
        log("event:p:videoChanged => " + event.index.toString());
        channel.value = categoryController.channels[event.index];
        categoryController.selectedChannelIndex.value = event.index;
      });
    });
  }

  void clear() async {
    channel.value = null;
    currentCatId.value = 0;
    currentCatName.value = "";
    currentChannel.value = 0;
    videoLoaded.value = false;
    categoryController.channels.asMap().forEach((key, value) {
      videoPlayer.remove(key);
      videoPlayer.remove(0);
    });
    //await disposePlayer();
  }

  Future<void> disposePlayer() async {
    await videoPlayer.dispose();
  }

  @override
  void onInit() {
    log("LivePlayerMediakitController:onInit");
    initPlayer();
    playerController = VideoController(videoPlayer, configuration: VideoControllerConfiguration(
      vo: "mediacodec_embed",
      hwdec: "mediacodec",
      enableHardwareAcceleration: true,
      androidAttachSurfaceAfterVideoParameters: false,
      width: Get.width.toInt(),
    ));
    super.onInit();
  }

  @override
  void onReady() {
    log("LivePlayerMediakitController:onReady");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    disposePlayer();
    super.dispose();
  }
}
