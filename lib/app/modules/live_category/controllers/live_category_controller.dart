import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guek_iptv/app/models/xtream/channel.dart';
import 'package:guek_iptv/app/models/xtream/epg.dart';
import 'package:guek_iptv/app/services/xtream_api_service.dart';
import 'package:guek_iptv/app/services/xtream_authentication_service.dart';

class LiveCategoryController extends GetxController {
  GetStorage storage = GetStorage();
  XtreamAuthenticationService auth = Get.find(tag: "auth");
  XtreamApiService apiService = Get.find(tag: "xtream_api");

  double coverWidth = 50.0;
  double coverHeight = 50.0;

  RxList<ChannelModel> channels = RxList<ChannelModel>();

  RxInt selectedChannelIndex = 0.obs;

  //RxList<Epg> epgList = RxList<Epg>();
  RxMap<int, String> epgList = RxMap<int, String>({});
  RxBool epgsLoaded = false.obs;

  Future<void> loadChannels(dynamic categoryId) async {
    channels.value = await apiService.liveChannels(
        auth.session.value!.serverInfo!.getApiUrl(),
        auth.session.value!.username!,
        auth.session.value!.password!,
        categoryId);
    //log("channels: " + channels.toString());
    //loadEpgs();
  }

  Future<void> loadEpgs() async {
    epgsLoaded.value = true;
    try {
      for (ChannelModel channel in channels.value) {
        //String currentEpg = await this.getCurrentEpg(channel.streamId!);
        if (epgList.containsKey(channel.streamId!) == false) {
          String currentEpg = await this.getCurrentEpg(channel.streamId!);
          //epgList.value[channel.streamId!] = Rx(currentEpg);
          /*if (channel.streamId!.toString() == "109") {
            log( "epg.109: " + currentEpg);
          }*/
          epgList.addAll({channel.streamId!: currentEpg});
        } else if (epgList.value[channel.streamId!] == null
            /*|| epgList.value[channel.streamId!]?.value == null*/) {
          String currentEpg = await this.getCurrentEpg(channel.streamId!);
          epgList.value[channel.streamId!] = currentEpg;
        }
        //await Future.delayed(Duration(seconds: 1));
      }
    } on Exception catch (err) {
      log("epgError: " + err.toString());
      /*Timer(
        Duration(seconds: 5),
        () {
          //loadEpgs();
        },
      );*/
    }
  }

  Future<void> loadEpgsPersistently() async {
    /*for(Rx<String?> epg in epgList.values) {
      log("epgList.in: " + epg.value!);
    }*/
  }

  Future<String> getCurrentEpg(int streamId) async {
    String currentEpg = "# Yayın akışı bilgileri mevcut değil #";
    List<Epg?> epgList = await apiService.epgDataTable(
        auth.session.value!.serverInfo!.getApiUrl(),
        auth.session.value!.username!,
        auth.session.value!.password!,
        streamId);
    epgList.forEach((Epg? epg) {
      //log("epgList.i: " + epg!.description!);
      if (epg!.nowPlaying!) {
        currentEpg = "# " + epg!.title! + " #"; // + ": " + epg!.description!
      }
    });
    log("stream epg: " + streamId.toString() + " > " + currentEpg);
    return currentEpg;
  }

  void clear() {
    channels.clear();
    epgList.clear();
    epgsLoaded.value = false;
    selectedChannelIndex.value = 0;
  }

  @override
  void onInit() {
    log("LiveCategoryController:onInit");
    super.onInit();
  }

  @override
  void onReady() {
    log("LiveCategoryController:onReady");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
