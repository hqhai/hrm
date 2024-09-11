import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'work_and_salary_state.g.dart';

@CopyWith()
class WorkAndSalaryState extends Equatable {
  final UserLeave userLeave;
  final double totalWorkday;
  final Map<EnumLeaveHistoryType, UserLeaveHistoryTypes> mapLeaveType;
  final WorkAndSalaryStatusEnum status;

  const WorkAndSalaryState(
      {this.userLeave = const UserLeave(),
      this.totalWorkday = 0,
      this.mapLeaveType = const {},
      this.status = WorkAndSalaryStatusEnum.init});

  @override
  List<Object?> get props => [userLeave, status, totalWorkday, mapLeaveType];
}
