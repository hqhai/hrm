import 'package:base_app/common/enum/notification_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_message.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class NotificationMessage {
  final String userId;
  final String id;
  final String senderId;
  final String message;
  final String link;
  final String objectId;
  final DateTime? createdDate;
  final NotificationStatus status;

  const NotificationMessage({
    this.userId = '',
    this.id = '',
    this.status = NotificationStatus.sent,
    this.link = '',
    this.message = '',
    this.objectId = '',
    this.senderId = '',
    this.createdDate,
  });

  factory NotificationMessage.fromJson(Map<String, dynamic> json) => _$NotificationMessageFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationMessageToJson(this);
}
