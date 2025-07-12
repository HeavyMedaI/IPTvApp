import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/movie.dart';
import 'package:guek_iptv/app/models/xtream/movie_details.dart';
import 'package:guek_iptv/app/modules/vod_category/controllers/vod_category_controller.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MoviePlayerMediakitController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");
  VodCategoryController categoryController =
  Get.find<VodCategoryController>();

  late Player videoPlayer;
  late VideoController playerController;
  late final GlobalKey<VideoState> videoState = GlobalKey<VideoState>();

  Rx<MovieModel?> movie = Rx<MovieModel?>(null);

  RxInt currentVodId = 0.obs;
  RxString currentVodName = "".obs;
  RxInt currentMovie = 0.obs;

  RxBool videoLoaded = false.obs;
  RxBool playerReady = false.obs;

  Future<void> loadMovie(MovieModel _movie) async {
    movie.value = _movie;
    videoLoaded.value = true;
    await loadPlayer();
  }

  Future<void> loadPlayer() async {
    String liveUrlPath = auth.session.value!.serverInfo!.getApiUrl(rtmp: false) +
        "/movie/${auth.session.value!.username!}/${auth.session.value!.password!}";

    log("stream url: ${liveUrlPath}/${movie.value!.streamId!}");

    Playlist playList = Playlist(List<Media>.from(categoryController.movies.map((MovieModel _movie) {
      return Media("${liveUrlPath}/${_movie.streamId!}.${_movie.containerExtension!}", extras: {
        "title": _movie.name!
      });
    })), index: categoryController.selectedMovieIndex.value);
    log("playlist.len: " + playList.medias.length.toString());
    await videoPlayer.open(playList, play: true).then((value) async {
      playerReady.value = true;
      videoPlayer.setSubtitleTrack(SubtitleTrack.no());
      videoPlayer.stream.playlist.listen((Playlist event) {
        log("event:p:videoChanged => " + event.index.toString());
        log("movies.length: " + categoryController.movies.length.toString());
        //log("playlist.length: " + videoPlayer.stream.playlist.length.toString());
        videoPlayer.stream.playlist.length.then((len) => log("playlist.length: " + len.toString()));
        movie.value = categoryController.movies[event.index];
        categoryController.selectedMovieIndex.value = event.index;
      }, onError: (err) {
        log("event:p:error: " + err.toString());
      });
    });
  }

  void initPlayer() {
    videoPlayer = Player();
    videoPlayer.setPlaylistMode(PlaylistMode.none);
  }


  void clear() async {
    movie.value = null;
    currentVodId.value = 0;
    currentVodName.value = "";
    currentMovie.value = 0;
    videoLoaded.value = false;
    categoryController.movies.asMap().forEach((key, value) {
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
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
