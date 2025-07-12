import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diolib;
import 'package:get/get_rx/get_rx.dart';
import 'package:guek_iptv/app/models/xtream/remote_config.dart';

class RemoteConfigService extends GetxService {
  //String remoteConfigApiHost = "http://guekportal.site/api";
  String remoteConfigApiHost = "http://guekandroid.xyz/api/remote_config.php?action=all&ack=8a02b3e656c822b8f0ba612275368faa1407e886";
  String remoteConfigApiToken = "2|7W90aHxByJK6MGy08EoxAYtIf8WJbN0MLs772dMded9c9657";

  late diolib.Dio dio;

  String currentVersion = "1.0.3+5";
  RxBool versionValid = true.obs;

  Rx<RemoteConfigModel?> config = Rx<RemoteConfigModel?>(null);

  Future<RemoteConfigService> init() async {
    dio = diolib.Dio();
    // diolib.interceptors.add(
    //   PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     compact: false,
    //   ),
    // );
    return this;
  }

  diolib.Options optHeaders = diolib.Options(headers: <String, dynamic>{
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    "Access-Control-Allow-Credentials":
        true, // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  });

  Future<void> loadConfig() async {
    String getConfigUrl = "$remoteConfigApiHost/app_config";
    debugPrint("getConfigUrl $getConfigUrl");

    diolib.Options options = optHeaders;
    options.headers!.addAll({
      "Authorization": "Bearer $remoteConfigApiToken",
    });

    diolib.Response<String> response = await dio.get(
      getConfigUrl,
      options: options,
    );

    if (response.statusCode == 200) {
      debugPrint("response.data: ${response.data}");
      this.config.value = remoteConfigModelFromJson(response.data ?? []);
      /*debugPrint("lts: " + (this.config.value!.latest_version! == currentVersion).toString());
      debugPrint("cur ver: " + currentVersion);
      debugPrint("lts ver: " + this.config.value!.latest_version!);*/
      if (this.config.value!.latest_version! != currentVersion) {
        versionValid.value = false;
      }
    }
  }
}
