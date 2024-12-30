import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/base/data_response.dart';
import 'package:base_app/data/models/notification/change_status_notification_request.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/client/notification_api_client.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:base_app/domain/entities/notification/notification_message.dart';
import 'package:injectable/injectable.dart';

import '../../../models/notification/get_notification_request.dart';

@LazySingleton()
class NotificationService {
  final NotificationApiClient _notificationApiClient;

  NotificationService(this._notificationApiClient);

  Future<DataResponse<bool>?> changeNotificationStatus({required ChangeStatusNotificationRequest changeStatusNotificationRequest}) async {
    return _notificationApiClient.request(
      method: RestMethod.put,
      path: PathConfig.notification,
      body: changeStatusNotificationRequest.toJson(),
      decoder: (json) => json as bool,
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListRecordPagingResponse<NotificationMessage>?> getNotification({required GetNotificationRequest getNotificationRequest}) async {
    return _notificationApiClient.request(
      method: RestMethod.get,
      path: PathConfig.notification,
      queryParameters: getNotificationRequest.toJson(),
      decoder: (json) => NotificationMessage.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataRecordPaging,
    );
  }
}
