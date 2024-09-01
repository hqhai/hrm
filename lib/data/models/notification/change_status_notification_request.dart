import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_status_notification_request.g.dart';

@CopyWith()
@JsonSerializable()
class ChangeStatusNotificationRequest {
  final List<String>? ids;
  final bool isAll;

  const ChangeStatusNotificationRequest({
    this.ids,
    this.isAll = false,
  });

  factory ChangeStatusNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangeStatusNotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeStatusNotificationRequestToJson(this);
}
