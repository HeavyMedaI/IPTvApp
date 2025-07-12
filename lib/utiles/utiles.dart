import 'dart:developer';
import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:external_video_player_launcher/external_video_player_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:guek_iptv/app/widgets/common.dart';
import 'package:guek_iptv/constants/color_palette.dart';
import 'package:guek_iptv/constants/textstyle.dart';
//import 'package:guek_iptv/screen/bottom/IPTvAppSpecial/Allmovies/all_movies_screen.dart';
//import 'package:guek_iptv/screen/bottom/home/home_utiles.dart';

Map<String, String> parseM3U(String m3u) {
  var uri = Uri.parse(m3u);
  //log("m3u: " + uri.queryParameters.toString() + " -> " + uri.scheme + "://" + uri.host + "::" + uri.port.toString());
  Map<String, String> ret = {"host": uri.scheme + "://" + uri.host + ":" + uri.port.toString()};
  ret.addAll(uri.queryParameters);
  return ret;
}

Future<void> openVlcPlayer(String title, String videoUrl, String? extension) async {
  log("videoUrl: " + videoUrl);
  String mimeType = MIME.applicationMp4; // MIME.applicationXMpegURL
  if (extension == "mp4") {
    mimeType = MIME.applicationMp4;
  }

  if (Platform.isAndroid) {
    try {
      await AppCheck.checkAvailability("org.videolan.vlc").then((app) async {
        debugPrint("check vlc: " + app.toString());
        bool isVlcEnabled = await AppCheck.isAppEnabled(app!.packageName);
        debugPrint("check vlc enabled: " + isVlcEnabled.toString());
        if (!isVlcEnabled) {
          showWarning(Get.context!, "Uyarı", "VLC Player uygulaması etkisizleştirilmiş, lütfen ayarlardan etkinleştirin.");
        }else{
          ExternalVideoPlayerLauncher.launchVlcPlayer(videoUrl, mimeType, {
            "title": title,
            "name": title
          });
        }
      });
    }on PlatformException catch(vlcErr) {
      debugPrint("vlcCheckError: " + vlcErr.toString());
      await LaunchReview.launch(androidAppId: "org.videolan.vlc", writeReview: false);
    }
  }else if(Platform.isIOS) {}
}

Future<void> openMxPlayer(String title, String videoUrl, String? extension) async {
  log("videoUrl: " + videoUrl);
  String mimeType = MIME.applicationMp4; // MIME.applicationXMpegURL
  if (extension == "mp4") {
    mimeType = MIME.applicationMp4;
  }

  if (Platform.isAndroid) {
    try {
      await AppCheck.checkAvailability("com.mxtech.videoplayer.ad").then((app) async {
        debugPrint("check mx: " + app.toString());
        bool isMxEnabled = await AppCheck.isAppEnabled(app!.packageName);
        debugPrint("check mx enabled: " + isMxEnabled.toString());
        if (!isMxEnabled) {
          showWarning(Get.context!, "Uyarı", "MX Player uygulaması etkisizleştirilmiş, lütfen ayarlardan etkinleştirin.");
        }else{
          ExternalVideoPlayerLauncher.launchMxPlayer(videoUrl, mimeType, {
            "title": title,
            "name": title
          });
        }
      });
    }on PlatformException catch(mxErr) {
      debugPrint("mxCheckError: " + mxErr.toString());
      await LaunchReview.launch(androidAppId: "com.mxtech.videoplayer.ad", writeReview: false);
    }
  }else if(Platform.isIOS) {}
}

Future<void> openExternalPlayer(String title, String videoUrl, String? extension) async {

  String mimeType = MIME.applicationMp4; // MIME.applicationXMpegURL
  if (extension == "mp4") {
    mimeType = MIME.applicationMp4;
  }

  if (Platform.isAndroid) {
    /*await AppCheck.checkAvailability("com.alptech.iptv").then((app) async {
      debugPrint("check iptv: " + app!.packageName);
      bool isIpTvEnabled = await AppCheck.isAppEnabled(app!.packageName);
      debugPrint("check iptv enabled: " + isIpTvEnabled.toString());
      if (!isIpTvEnabled) {
        showWarning(Get.context!, "Uyarı", "IPTv uygulaması etkisizleştirilmiş, lütfen ayarlardan etkinleştirin.");
      }
    });*/

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
            "title": title,
            "name": title
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
              "title": title,
              "name": title
            });
          }
        });
      } on PlatformException catch(vlcErr) {
        debugPrint("vlcCheckError: " + vlcErr.toString());
        await LaunchReview.launch(androidAppId: "com.mxtech.videoplayer.ad", writeReview: false);
      }
    }
  }else if(Platform.isIOS) {}
}