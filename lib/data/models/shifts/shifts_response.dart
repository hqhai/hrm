import 'package:base_app/data/models/response/paging_infor_request.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shifts_response.g.dart';

@CopyWith()
@JsonSerializable()
class ShiftsResponse {
  final List<WorkDay> items;

  const ShiftsResponse({
    this.items = const [],
  });

  factory ShiftsResponse.fromJson(Map<String, dynamic> json) =>
      _$ShiftsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftsResponseToJson(this);
}

@CopyWith()
@JsonSerializable()
class ShiftsAdminResponse {
  final List<WorkDayAdmin> items;
  final PagingInfoRequest pagingInfo;
  const ShiftsAdminResponse(
      {this.items = const [], this.pagingInfo = const PagingInfoRequest()});
  factory ShiftsAdminResponse.fromJson(Map<String, dynamic> json) =>
      _$ShiftsAdminResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftsAdminResponseToJson(this);
}

@CopyWith()
@JsonSerializable()
class GetElectiveShiftResponse {
  final List<UsableAdmin> items;
  final PagingInfoRequest pagingInfo;
  const GetElectiveShiftResponse(
      {this.items = const [], this.pagingInfo = const PagingInfoRequest()});
  factory GetElectiveShiftResponse.fromJson(Map<String, dynamic> json) =>
      _$GetElectiveShiftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetElectiveShiftResponseToJson(this);
}
