import 'package:base_app/data/models/notification/change_status_notification_request.dart';
import 'package:base_app/data/models/notification/get_notification_request.dart';
import 'package:base_app/data/models/notification/notification_response.dart';

abstract class NotificationService {
  Future<NotificationResponse> getNotification({
    required GetNotificationRequest getNotificationRequest,
  });

  Future<void> changeNotificationStatus({
    required ChangeStatusNotificationRequest changeStatusNotificationRequest,
  });
}
