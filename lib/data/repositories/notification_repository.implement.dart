import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/notification_enum.dart';
import 'package:base_app/data/models/notification/change_status_notification_request.dart';
import 'package:base_app/data/models/notification/get_notification_request.dart';
import 'package:base_app/data/models/notification/notification_response.dart';
import 'package:base_app/domain/repositories/notification_repository.dart';
import 'package:base_app/domain/services/notification_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationService _notificationService;

  NotificationRepositoryImpl() : _notificationService = dI<NotificationService>();

  @override
  Future<bool> changeNotificationStatus({List<String>? ids, required bool isAll}) async {
    return  await _notificationService.changeNotificationStatus(
      changeStatusNotificationRequest: ChangeStatusNotificationRequest(
        ids: ids,
        isAll: isAll,
      ),
    );
  }

  @override
  Future<NotificationResponse> getNotification({required int page, required NotificationStatus status}) async {
    return await _notificationService.getNotification(
      getNotificationRequest: GetNotificationRequest(
        page: page,
        status: status,
      ),
    );
  }
}
