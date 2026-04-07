import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/models/paging/paging_infor_request.dart';
import 'package:base_app/domain/entities/leave/user_leave_history.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_leave_history_response_map.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class UserLeaveHistoryResponseMap {
  final Map<String, UserLeaveHistory> items;
  final PagingInfoRequest pagingInfo;
  final List<String> listIds;

  const UserLeaveHistoryResponseMap({
    this.items = const {},
    this.pagingInfo = const PagingInfoRequest(
      page: 0,
      pageSize: 0,
      totalItems: 0,
    ),
    this.listIds = const [],
  });

  factory UserLeaveHistoryResponseMap.fromJson(Map<String, dynamic> json) =>
      _$UserLeaveHistoryResponseMapFromJson(json);

  Map<String, dynamic> toJson() => _$UserLeaveHistoryResponseMapToJson(this);
}
