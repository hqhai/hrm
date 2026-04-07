import 'package:json_annotation/json_annotation.dart';

part 'cancel_work_day_request.g.dart';

@JsonSerializable()
class CancelWorkDayAdminRequest {
  final List<String> ids;
  final String note;
  const CancelWorkDayAdminRequest({required this.ids, required this.note});

  factory CancelWorkDayAdminRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelWorkDayAdminRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CancelWorkDayAdminRequestToJson(this);
}
