import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//import 'package:japx/japx.dart';
import 'package:guek_iptv/app/models/xtream/session.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class XtreamAuthenticationService extends GetxService {
  RxBool isLogged = false.obs;
  Rx<SessionModel?> session = SessionModel().obs;

  GetStorage storage = GetStorage();

  //final SharedPreferences store = await SharedPreferences.getInstance();

  @override
  void onInit() {
    //log("onInit.auth.is_logged: " + storage.read("auth.is_logged").toString());
    super.onInit();
  }

  @override
  void onReady() {
    this.isLogged.value = this.storage.hasData("auth.is_logged")
        ? this.storage.read("auth.is_logged")
        : false;

    log("onReady.auth.is_logged: " + storage.read("auth.is_logged").toString());
    if (storage.hasData("session")) {
      //storage.erase();
      //this.user.value = SessionModel.fromJson(storage.read("session"));
      this.session.value = sessionModelFromJson(storage.read("session"));
      if (this.storage.hasData("auth.is_logged") && this.isLogged.isTrue) {
        this.isLogged.value = true;
      }
    }
    /*if(store.getBool("isLogged") != null) {
      this.isLogged.value = store.getBool("isLogged");
      this.session.value = SessionModel.fromJson(jsonDecode(store.getString("session")));
    }*/
    super.onReady();
  }
}
