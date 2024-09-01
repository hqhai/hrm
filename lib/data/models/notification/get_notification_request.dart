import 'package:base_app/common/enum/notification_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_notification_request.g.dart';

@CopyWith()
@JsonSerializable()
class GetNotificationRequest {
  final int page;
  final NotificationStatus status;

  const GetNotificationRequest({
    this.page = 1,
    this.status = NotificationStatus.sent,
  });

  factory GetNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetNotificationRequestToJson(this);
}
