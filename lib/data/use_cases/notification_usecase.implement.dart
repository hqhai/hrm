import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/notification_enum.dart';
import 'package:base_app/data/models/notification/notification_response_usecase.dart';
import 'package:base_app/domain/entities/notification/notification_message.dart';
import 'package:base_app/domain/repositories/notification_repository.dart';
import 'package:base_app/domain/use_cases/notification_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationUseCase)
class NotificationUseCaseImpl extends NotificationUseCase {
  final NotificationRepository _notificationRepository;

  NotificationUseCaseImpl() : _notificationRepository = dI<NotificationRepository>();

  @override
  Future<void> changeNotificationStatus({List<String>? ids, required bool isAll}) async {
    await _notificationRepository.changeNotificationStatus(isAll: isAll, ids: ids);
  }

  @override
  Future<NotificationResponseUserCase> getNotification(
      {required int page, required NotificationStatus status}) async {
    final responseServices =
        await _notificationRepository.getNotification(page: page, status: status);

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
