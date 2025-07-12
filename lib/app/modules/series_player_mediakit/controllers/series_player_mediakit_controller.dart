import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/series_details.dart';
import 'package:guek_iptv/app/modules/series_category/controllers/series_category_controller.dart';
import 'package:guek_iptv/app/modules/series_detail/controllers/series_detail_controller.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class SeriesPlayerMediakitController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");
  SeriesCategoryController categoryController =
  Get.find<SeriesCategoryController>();
  SeriesDetailController seriesController =
  Get.find<SeriesDetailController>();

  late Player videoPlayer;
  late VideoController playerController;
  late final GlobalKey<VideoState> videoState = GlobalKey<VideoState>();

  Rx<EpisodeModel?> episode = Rx<EpisodeModel?>(null);

  RxInt currentEpisodeId = 0.obs;
  RxString currentsSeriesTitle = "".obs;
  RxString currentEpispdeName = "".obs;
  RxInt currentEpisode = 0.obs;

  RxBool videoLoaded = false.obs;
  RxBool playerReady = false.obs;

  Future<void> loadMovie(EpisodeModel _episode) async {
    episode.value = _episode;
    videoLoaded.value = true;
    await loadPlayer();
  }

  Future<void> loadPlayer() async {
    String liveUrlPath = auth.session.value!.serverInfo!.getApiUrl(rtmp: false) +
        "/series/${auth.session.value!.username!}/${auth.session.value!.password!}";

    log("episode url: ${liveUrlPath}/${episode.value!.id!}");

    log("series: " + seriesController.series.value!.info!.toJson().toString());
    log("selectedSeason: " + seriesController.selectedSeasonNumber.value.toString());
    log("selectedEpisode: " + seriesController.selectedEpisodeIndex.value.toString());
    log("selectedEpisodes: " + seriesController.series.value!.episodes!.toString()); //[seriesController.selectedSeasonNumber.value.toString()]!

    String seasonTitle = seriesController.series.value!.info!.name! + " - " + seriesController.series.value!.seasons![seriesController.selectedSeasonIndex.value]!.name!;
    currentsSeriesTitle.value = seasonTitle;
    currentEpispdeName.value = seriesController.series.value!.episodes![seriesController.selectedSeasonNumber.value.toString()]![seriesController.selectedEpisodeIndex.value].title!;

    Playlist playList = Playlist(List<Media>.from(seriesController.series.value!.episodes![seriesController.selectedSeasonNumber.value.toString()]!.map((EpisodeModel _episode) {
      return Media("${liveUrlPath}/${_episode.id!}.${_episode.containerExtension!}", extras: {
        "title": seasonTitle + "/" + _episode.title!
      });
    })), index: seriesController.selectedEpisodeIndex.value);
    log("playlist.len: " + playList.medias.length.toString());
    await videoPlayer.open(playList, play: true).then((value) async {
      playerReady.value = true;
      videoPlayer.setSubtitleTrack(SubtitleTrack.no());
      videoPlayer.stream.playlist.listen((Playlist event) {
        //videoPlayer.stream.playlist.length.then((len) => log("playlist.length: " + len.toString()));
        log("e.index: " + event.index.toString());
        log("selected.seasonNumber: " + seriesController.selectedSeasonNumber.value.toString());
        log("selected.ep: " + seriesController.series.value!.episodes!.toString());
        episode.value = seriesController.series.value!.episodes![seriesController.selectedSeasonNumber.value.toString()]![event.index];
        seriesController.selectedEpisodeIndex.value = event.index;
        currentEpispdeName.value = seriesController.series.value!.episodes![seriesController.selectedSeasonNumber.value.toString()]![event.index].title!;
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
    episode.value = null;
    currentEpisodeId.value = 0;
    currentsSeriesTitle.value = "";
    currentEpispdeName.value = "";
    currentEpisode.value = 0;
    videoLoaded.value = false;
    seriesController.series.value?.episodes![seriesController.selectedSeasonNumber.value.toString()]!.asMap().forEach((key, value) {
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
}
