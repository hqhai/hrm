import 'package:json_annotation/json_annotation.dart';

part 'get_request_by_admin.g.dart';

@JsonSerializable()
class GetRequestByAdminRequest {
  final String startDate;
  final String endDate;
  final String requestType;

  const GetRequestByAdminRequest({required this.endDate, required this.startDate, required this.requestType,});

  factory GetRequestByAdminRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRequestByAdminRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetRequestByAdminRequestToJson(this);
}