import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService extends GetxService {

  Future<OneSignalService> init({bool askConsent = false}) async {
    await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    await requestConsent(askConsent);
    return this;
  }

  Future<void> start(String appId, {bool askPermission = true, bool inAppMessages = false}) async {
    OneSignal.initialize(appId);
    await requestPermission(askPermission);
    await enableLiveActivities();
    await clearNotifications();
    await setupObservers();
    setupListeners();
    enableInAppMessages(inAppMessages);
  }

  Future<bool> requestPermission(bool ask) async {
    return await OneSignal.Notifications.requestPermission(ask);
  }

  Future<void> requestConsent(bool ask) async {
    await OneSignal.consentRequired(ask);
  }

  Future<void> consent(bool given) async {
    await OneSignal.consentGiven(given);
  }

  Future<void> enableLiveActivities({LiveActivitySetupOptions? options}) async {
    await OneSignal.LiveActivities.setupDefault(options: options);
  }

  Future<void> enableInAppMessages(bool paused) async {
    await OneSignal.InAppMessages.paused(paused);
  }

  Future<void> enableLocation(bool shared) async {
    await OneSignal.Location.setShared(shared);
  }

  Future<void> clearNotifications() async {
    await OneSignal.Notifications.clearAll();
  }

  Future<void> setupObservers() async {
    OneSignal.User.pushSubscription.addObserver((state) {
      print(OneSignal.User.pushSubscription.optedIn);
      print(OneSignal.User.pushSubscription.id);
      print(OneSignal.User.pushSubscription.token);
      print(state.current.jsonRepresentation());
    });

    OneSignal.User.addObserver((state) {
      var userState = state.jsonRepresentation();
      print('OneSignal user changed: $userState');
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission " + state.toString());
    });
  }

  void setupListeners() {
    OneSignal.Notifications.addClickListener((event) {
      debugPrint("NOTIFICATION CLICK LISTENER CALLED WITH EVENT: ${event}");
      debugPrint("Clicked notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      print(
          'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();

      debugPrint("Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
    });

    OneSignal.InAppMessages.addClickListener((event) {
      debugPrint("In App Message Clicked: \n${event.result.jsonRepresentation().replaceAll("\\n", "\n")}");
    });

    OneSignal.InAppMessages.addWillDisplayListener((event) {
      print("ON WILL DISPLAY IN APP MESSAGE ${event.message.messageId}");
    });

    OneSignal.InAppMessages.addDidDisplayListener((event) {
      print("ON DID DISPLAY IN APP MESSAGE ${event.message.messageId}");
    });

    OneSignal.InAppMessages.addWillDismissListener((event) {
      print("ON WILL DISMISS IN APP MESSAGE ${event.message.messageId}");
    });

    OneSignal.InAppMessages.addDidDismissListener((event) {
      print("ON DID DISMISS IN APP MESSAGE ${event.message.messageId}");
    });
  }

  Future<void> userTag(String key, dynamic value) async {
    await OneSignal.User.addTagWithKey(key, value);
  }

  Future<void> userTags(Map<String, dynamic> tags) async {
    await OneSignal.User.addTags(tags);
  }

  Future<void> userAlias(String alias, dynamic id) async {
    await OneSignal.User.addAlias(alias, id);
  }

  Future<void> userAliases(Map<String, dynamic> aliases) async {
    await OneSignal.User.addAliases(aliases);
  }

  Future<Map<String, String>> getUserTags() async {
    return await OneSignal.User.getTags();
  }

  Future<void> removeUserTag(String key) async {
    await OneSignal.User.removeTag(key);
  }

  Future<void> removeUserTags(List<String> keys) async {
    await OneSignal.User.removeTags(keys);
  }

  Future<void> userLang(String locale) async {
    await OneSignal.User.setLanguage(locale);
  }

  Future<void> userEmail(String email) async {
    await OneSignal.User.addEmail(email);
  }

  Future<void> removeUserEmail(String email) async {
    await OneSignal.User.removeEmail(email);
  }

  Future<void> userPhone(String phoneNumber) async {
    await OneSignal.User.addSms(phoneNumber);
  }

  Future<void> removeUserPhone(String phoneNumber) async {
    await OneSignal.User.removeSms(phoneNumber);
  }

  Future<String?> userExternalId() async {
    return await OneSignal.User.getExternalId();
  }

  Future<String?> userOneSignalId() async {
    return await OneSignal.User.getOnesignalId();
  }

  Future<void> login(String userExtId) async {
    await OneSignal.login(userExtId);
  }

  Future<void> logout() async {
    await OneSignal.logout();
  }

}