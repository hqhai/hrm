import 'package:base_app/common/configs/app_configs.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

setupOneSignal() async {
  final appId = appConfig.oneSignalAppId;
  //Remove this method to stop OneSignal Debugging
  // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(appId);
  // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
}
