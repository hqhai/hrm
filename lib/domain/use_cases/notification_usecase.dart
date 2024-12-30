import 'package:base_app/common/enum/notification_enum.dart';
import 'package:base_app/data/models/notification/notification_response_usecase.dart';
import 'package:base_app/domain/entities/notification/notification_message.dart';
import 'package:base_app/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/notification/notification_response.dart';

@Injectable()
class NotificationUseCase {
  NotificationUseCase(this._notificationRepository);

  final NotificationRepository _notificationRepository;

  Future<bool> changeNotificationStatus({List<String>? ids, required bool isAll}) async {
    final response = await _notificationRepository.changeNotificationStatus(isAll: isAll, ids: ids);
    return response ?? false;
  }

  Future<NotificationResponseUserCase> getNotification({required int page, required NotificationStatus status}) async {
    final response = await _notificationRepository.getNotification(page: page, status: status);
    final responseServices = response ?? const NotificationResponse();
    final Map<String, NotificationMessage> mapNotification = Map.fromEntries(
      responseServices.items.map(
        (item) => MapEntry(
          item.id,
          item,
        ),
      ),
    );
    final keys = responseServices.items.map((e) => e.id).toList();
    final totalItems = responseServices.pagingInfo.totalItems;
    return NotificationResponseUserCase(
      totalItems: totalItems,
      keys: keys,
      items: mapNotification,
    );
  }
}
