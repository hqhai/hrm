import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_day_admin_query_params.g.dart';

@JsonSerializable()
class WorkDayAdminQueryParams {
  final String workDayAdminIndex;
  final WorkShiftRequestStatus type;

  WorkDayAdminQueryParams({
    required this.workDayAdminIndex,
    required this.type,
  });

  factory WorkDayAdminQueryParams.fromJson(Map<String, dynamic> json) =>
      _$WorkDayAdminQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDayAdminQueryParamsToJson(this);
}
