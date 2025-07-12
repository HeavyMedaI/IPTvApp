import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diolib;
import 'package:guek_iptv/app/models/session.dart';
import 'package:guek_iptv/constants/global.dart';

class ApiService extends GetxService {
  late diolib.Dio dio;
  //late http.Client client;

  late String api;

  late int lastResponseCode;
  late diolib.Response lastResponse;

  Future<ApiService> init() async {
    dio = diolib.Dio();
    api = GlobalConstants.api_host + GlobalConstants.api_path;
    //client = http.Client();
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

  diolib.Options optHeaders = diolib.Options(
    headers: <String, dynamic>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      "Access-Control-Allow-Credentials": true,
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    },
    validateStatus: (code) {
      debugPrint("status code: " + code.toString());
      if(code == 401) {
        //Get.find<AuthenticationService>(tag: "auth").destroy();
      }
      return true;
    }
  );

  Future<dynamic> validateSession(String token) async {
    SessionModel? sessionModel;
    String getSession = '${api}/user/validate_session';
    log("session url: " + getSession);

    diolib.Options _options = optHeaders;
    _options.headers!.addAll({'Authorization': "Bearer " + token});

    debugPrint("validate headers: " + _options.headers.toString());

    diolib.Response response = await dio.get(
      getSession,
      options: _options,
    );
    if (response.statusCode == 200) {
      optHeaders.headers!.addAll({'Authorization': "Bearer " + token});
      debugPrint("Validate session:===>${response.data}");
      return SessionModel.fromJson(response.data);
    }

    lastResponseCode = response.statusCode!;
    lastResponse = response;



    return false;

    //debugPrint("${response.data}");
    //return sessionModel;
  }

  Future<SessionModel?> loginAsync(String username, String password) async {
    SessionModel? sessionModel;
    String getSession =
        'url/player_api.php?username=$username&password=$password';
    log("session url: " + getSession);

    diolib.Response response = await dio.get(
      getSession,
      options: optHeaders,
    );

    try {
      if (response.statusCode == 200) {
        debugPrint("Login apiservice:===>${response.data}");
        return SessionModel.fromJson(response.data);
      } else if (response.statusCode == 404) {
        //showToast("Lütfen bilgilerinizi kontrol ediniz");
        throw Exception('Oturum açılamadı, giriş bilgileri yanlış');
      }
    } on Exception catch (e) {
      throw e;
    }

    debugPrint("${response.data}");
    return sessionModel;
  }
}
