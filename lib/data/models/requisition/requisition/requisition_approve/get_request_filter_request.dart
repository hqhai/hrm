import 'package:json_annotation/json_annotation.dart';

part 'get_request_filter_request.g.dart';

@JsonSerializable()
class GetRequestFilterRequest {
  final int? page;
  final String? type;
  final String? createdDepartmentId;
  final String? startDate;
  final String? endDate;
  final String? statuses;

  const GetRequestFilterRequest({
    this.page,
    this.endDate,
    this.statuses,
    this.type,
    this.createdDepartmentId,
    this.startDate,
  });

  factory GetRequestFilterRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRequestFilterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestFilterRequestToJson(this);
}
