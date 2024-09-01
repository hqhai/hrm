import 'package:base_app/data/models/response/paging_infor_request.dart';
import 'package:base_app/domain/entities/notification/notification_message.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

@CopyWith()
@JsonSerializable()
class NotificationResponse {
  final List<NotificationMessage> items;
  final PagingInfoRequest pagingInfo;

  const NotificationResponse({
    this.items = const [],
    this.pagingInfo = const PagingInfoRequest(),
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
