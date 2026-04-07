import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/models/paging/paging_infor_request.dart';
import 'package:base_app/domain/entities/leave/user_leave_history.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_leave_history_response.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class UserLeaveHistoryResponse {
  final List<UserLeaveHistory> items;
  final PagingInfoRequest pagingInfo;

  const UserLeaveHistoryResponse({
    this.items = const [],
    this.pagingInfo = const PagingInfoRequest(
      page: 0,
      pageSize: 0,
      totalItems: 0,
    ),
  });

  factory UserLeaveHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLeaveHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLeaveHistoryResponseToJson(this);
}
