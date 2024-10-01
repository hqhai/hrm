import 'package:base_app/common/enum/notification_enum.dart';
import 'package:base_app/data/models/notification/notification_response_usecase.dart';

abstract class NotificationUseCase {
  Future<NotificationResponseUserCase> getNotification(
      {required int page, required NotificationStatus status});

  Future<bool> changeNotificationStatus({List<String>? ids, required bool isAll});
}
