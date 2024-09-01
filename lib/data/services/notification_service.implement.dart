import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/notification/change_status_notification_request.dart';
import 'package:base_app/data/models/notification/get_notification_request.dart';
import 'package:base_app/data/models/notification/notification_response.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/services/notification_service.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: NotificationService)
class NotificationServiceImpl extends BaseService implements NotificationService {
  late String baseNotification;

  NotificationServiceImpl() : super() {
    baseNotification = appConfig.baseNotificationUrl;
  }

  @override
  Future<void> changeNotificationStatus(
      {required ChangeStatusNotificationRequest changeStatusNotificationRequest}) async {
    final url = '$baseNotification${PathConfig.notification}';
    final body = jsonEncode(changeStatusNotificationRequest.toJson());
    await client.put(url, body: body);
  }

  @override
  Future<NotificationResponse> getNotification(
      {required GetNotificationRequest getNotificationRequest}) async {
    final url = '$baseNotification${PathConfig.notification}';
    final params = getNotificationRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final notificationResponse = NotificationResponse.fromJson(data);
    return notificationResponse;
  }
}
