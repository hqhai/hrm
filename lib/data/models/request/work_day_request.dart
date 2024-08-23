import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_day_request.g.dart';

@JsonSerializable()
class WorkDayRequest {
  final String workShiftSettingDetailId;
  final String workDate;

  const WorkDayRequest({
    this.workShiftSettingDetailId = '',
    this.workDate = '',
  });

  factory WorkDayRequest.fromJson(Map<String, dynamic> json) =>
      _$WorkDayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDayRequestToJson(this);
}

@JsonSerializable()
class CancelWorkDayRequest {
  final String id;
  final String note;

  const CancelWorkDayRequest({
    this.note = '',
    this.id = '',
  });

  factory CancelWorkDayRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelWorkDayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelWorkDayRequestToJson(this);
}

@JsonSerializable()
class WorkDaysRequest {
  final List<WorkDayRequest> workShiftRequestList;

  const WorkDaysRequest({
    this.workShiftRequestList = const [],
  });

  factory WorkDaysRequest.fromJson(Map<String, dynamic> json) =>
      _$WorkDaysRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDaysRequestToJson(this);
}

@JsonSerializable()
class WorkDayAdminRequest {
  final WorkShiftRequestStatus requestStatus;
  final String name;

  const WorkDayAdminRequest({
    this.name = '',
    this.requestStatus = WorkShiftRequestStatus.approve,
  });

  factory WorkDayAdminRequest.fromJson(Map<String, dynamic> json) =>
      _$WorkDayAdminRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDayAdminRequestToJson(this);
}

@JsonSerializable()
class WorkDayGetElectiveShiftRequest {
  final bool isApprove;
  final String startDate;
  final String endDate;

  const WorkDayGetElectiveShiftRequest({
    this.isApprove = true,
    this.endDate = '',
    this.startDate = '',
  });

  factory WorkDayGetElectiveShiftRequest.fromJson(Map<String, dynamic> json) =>
      _$WorkDayGetElectiveShiftRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDayGetElectiveShiftRequestToJson(this);
}

@JsonSerializable()
class GetElectiveShiftDetailRequest {
  final String workShiftSettingDetailId;
  final bool isApprove;
  final String startDate;
  final String endDate;

  const GetElectiveShiftDetailRequest({
    this.workShiftSettingDetailId = '',
    this.isApprove = true,
    this.endDate = '',
    this.startDate = '',
  });

  factory GetElectiveShiftDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$GetElectiveShiftDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetElectiveShiftDetailRequestToJson(this);
}

@JsonSerializable()
class ApproveRequest {
  final WorkShiftRequestStatus status;
  final List<UpdateWorkShiftApprovesRequest> updateWorkShiftApproves;

  const ApproveRequest({
    this.status = WorkShiftRequestStatus.approve,
    this.updateWorkShiftApproves = const [],
  });
  factory ApproveRequest.fromJson(Map<String, dynamic> json) =>
      _$ApproveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveRequestToJson(this);
}

@JsonSerializable()
class UpdateWorkShiftApprovesRequest {
  final String id;
  final String note;

  const UpdateWorkShiftApprovesRequest({
    this.note = '',
    this.id = '',
  });

  factory UpdateWorkShiftApprovesRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkShiftApprovesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateWorkShiftApprovesRequestToJson(this);
}
