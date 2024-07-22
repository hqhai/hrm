import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_shift_approve.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class WorkShiftApprove {
  final String id;
  final DateTime? createdDate;
  final String createdFullName;
  final String createdUserId;
  final WorkShiftApproveStatus status;
  final List<String> approverIds;
  final String note;
  final String content;

  const WorkShiftApprove({
    this.id = '',
    this.createdDate,
    this.status = WorkShiftApproveStatus.pending,
    this.note = '',
    this.createdUserId = '',
    this.createdFullName = '',
    this.content = '',
    this.approverIds = const [],
  });

  factory WorkShiftApprove.fromJson(Map<String, dynamic> json) => _$WorkShiftApproveFromJson(json);

  Map<String, dynamic> toJson() => _$WorkShiftApproveToJson(this);
}
