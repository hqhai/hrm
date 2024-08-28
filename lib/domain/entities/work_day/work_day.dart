import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/domain/entities/work_day/work_shift_approve.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_day.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class WorkDay {
  final String id;
  final WorkShiftRequestStatus status;
  final WeekDayEnum dayOfWeek;
  final DateTime? workDate;
  final List<WorkShiftApprove> workShiftApproves;
  final WorkShiftApprove workShiftApprove;
  final String createdUserId;
  final String createdFullName;
  final DateTime? createdDate;
  final List<Shift> items;

  const WorkDay({
    this.id = '',
    this.createdFullName = '',
    this.createdUserId = '',
    this.status = WorkShiftRequestStatus.pending,
    this.createdDate,
    this.items = const [],
    this.workDate,
    this.workShiftApprove = const WorkShiftApprove(),
    this.workShiftApproves = const [],
    this.dayOfWeek = WeekDayEnum.monday,
  });

  factory WorkDay.fromJson(Map<String, dynamic> json) =>
      _$WorkDayFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDayToJson(this);
}

@CopyWith()
@JsonSerializable()
class WorkDayAdmin {
  final String workShiftApproveId;
  final DateTime? workDate;
  final String nameWorkShift;
  final int startTime;
  final int endTime;
  final WorkShiftRequestStatus status;
  final String name;
  final String code;
  final String email;
  final String companyEmail;
  final String phoneNumber;
  final String namePosition;
  final String positionId;
  final DateTime? createdDate;
  final String content;
  final String note;
  final String workShiftRequestId;
  final String type;
  final String workShiftSettingDetailId;
  final double workEffort;
  final int checkInStartTimeValid;
  final int checkInEndTimeValid;
  final int checkOutStartTimeValid;
  final int checkOutEndTimeValid;
  final String id;
  final String createdUserId;
  final String updatedUserId;
  final String createdFullName;
  final String updatedFullName;
  final String updatedDate;

  const WorkDayAdmin({
    this.workShiftApproveId = '',
    this.workDate,
    this.nameWorkShift = '',
    this.startTime = 0,
    this.endTime = 0,
    this.status = WorkShiftRequestStatus.unusable,
    this.name = '',
    this.code = '',
    this.email = '',
    this.companyEmail = '',
    this.phoneNumber = '',
    this.namePosition = '',
    this.positionId = '',
    this.createdDate,
    this.content = '',
    this.note = '',
    this.workShiftRequestId = '',
    this.type = '',
    this.workShiftSettingDetailId = "",
    this.workEffort = 0,
    this.checkInStartTimeValid = 0,
    this.checkInEndTimeValid = 0,
    this.checkOutStartTimeValid = 0,
    this.checkOutEndTimeValid = 0,
    this.id = "",
    this.createdUserId = "",
    this.updatedUserId = "",
    this.createdFullName = "",
    this.updatedFullName = "",
    this.updatedDate = '',
  });

  factory WorkDayAdmin.fromJson(Map<String, dynamic> json) =>
      _$WorkDayAdminFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDayAdminToJson(this);
}

@CopyWith()
@JsonSerializable()
class UsableAdmin {
  final DateTime? workDate;
  final List<WorkShiftRegisteredDetails> workShiftRegisteredDetails;

  const UsableAdmin({
    this.workDate,
    this.workShiftRegisteredDetails = const [],
  });

  factory UsableAdmin.fromJson(Map<String, dynamic> json) =>
      _$UsableAdminFromJson(json);

  Map<String, dynamic> toJson() => _$UsableAdminToJson(this);
}

@CopyWith()
@JsonSerializable()
class WorkShiftRegisteredDetails {
  final DateTime? workDate;
  final String workShiftSettingDetailId;
  final String nameWorkShift;
  final int startTime;
  final int endTime;

  const WorkShiftRegisteredDetails({
    this.nameWorkShift = '',
    this.workShiftSettingDetailId = '',
    this.workDate,
    this.startTime = 0,
    this.endTime = 0,
  });

  factory WorkShiftRegisteredDetails.fromJson(Map<String, dynamic> json) =>
      _$WorkShiftRegisteredDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$WorkShiftRegisteredDetailsToJson(this);
}
