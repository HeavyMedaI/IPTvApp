import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//import 'package:japx/japx.dart';
import 'package:guek_iptv/app/models/session.dart';
import 'package:guek_iptv/app/services/api_service.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService extends GetxService {
  ApiService api = Get.find<ApiService>(tag: "api");

  RxBool isLogged = false.obs;
  Rx<SessionModel?> session = SessionModel().obs;

  GetStorage storage = GetStorage();

  //final SharedPreferences store = await SharedPreferences.getInstance();

  @override
  void onInit() async {
    //log("onInit.auth.is_logged: " + storage.read("auth.is_logged").toString());
    log("onInit.auth.is_logged: ");
    super.onInit();
    //dynamic validate = await Get.find<ApiService>(tag: "api").validateSession("28|QGAEgYtOTyq7fNnjUMhu4Esn9I5l8EAKst4WrOCX9552f7ca");
    //log("validate: " + validate.toString());
  }

  @override
  void onReady() async {
    log("onReady.auth.is_logged: ");
    dynamic validate = await Get.find<ApiService>(tag: "api").validateSession("28|QGAEgYtOTyq7fNnjUMhu4Esn9I5l8EAKst4WrOCX9552f7ca");
    log("validate: " + validate.toString());
    log("validate res: " + api.lastResponse.statusCode!.toString());

    this.isLogged.value = this.storage.hasData("auth.is_logged")
        ? this.storage.read("auth.is_logged")
        : false;

    log("onReady.auth.is_logged: " + storage.read("auth.is_logged").toString());
    if (storage.hasData("auth.token")) {
      //storage.erase();
      //this.user.value = SessionModel.fromJson(storage.read("session"));
      //this.session.value = sessionModelFromJson(storage.read("session"));

      dynamic validate = await Get.find<ApiService>(tag: "api").validateSession("28|QGAEgYtOTyq7fNnjUMhu4Esn9I5l8EAKst4WrOCX9552f7ca");
      if (validate && api.lastResponseCode == 200) {
        session.value = validate;
        if (this.storage.hasData("auth.is_logged") && this.isLogged.isTrue) {
          this.isLogged.value = true;
        }
      }else if(api.lastResponseCode == 401) {
        destroy();
      }
    }
    /*if(store.getBool("isLogged") != null) {
      this.isLogged.value = store.getBool("isLogged");
      this.session.value = SessionModel.fromJson(jsonDecode(store.getString("session")));
    }*/
    super.onReady();
  }

  void destroy() async {
    isLogged.value = false;
    this.storage.write("auth.is_logged", false);
    session.value = null;
  }
}
