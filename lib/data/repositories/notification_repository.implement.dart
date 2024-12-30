import 'package:base_app/common/enum/notification_enum.dart';
import 'package:base_app/data/models/notification/change_status_notification_request.dart';
import 'package:base_app/data/models/notification/get_notification_request.dart';
import 'package:base_app/data/models/notification/notification_response.dart';
import 'package:base_app/data/models/response/paging_infor_request.dart';
import 'package:base_app/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/notification_service.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationService _notificationService;

  NotificationRepositoryImpl(this._notificationService);

  @override
  Future<bool?> changeNotificationStatus({List<String>? ids, required bool isAll}) async {
    final response = await _notificationService.changeNotificationStatus(
      changeStatusNotificationRequest: ChangeStatusNotificationRequest(
        ids: ids,
        isAll: isAll,
      ),
    );
    return response?.data;
  }

  @override
  Future<NotificationResponse?> getNotification({required int page, required NotificationStatus status}) async {
    final response = await _notificationService.getNotification(
      getNotificationRequest: GetNotificationRequest(
        page: page,
        status: status,
      ),
    );
    final listMessaging = response?.meta?.items;
    final paging = response?.meta?.pageInfo;
    return NotificationResponse(
        items: listMessaging ?? [],
        pagingInfo: PagingInfoRequest(
          page: paging?.page ?? 0,
          totalItems: paging?.totalItems ?? 0,
          pageSize: paging?.pageSize ?? 0,
        ));
  }
}
