import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'work_and_salary_state.g.dart';

@CopyWith()
class WorkAndSalaryState extends Equatable {
  final double permission;
  final double used;
  final double remaining;
  final double totalWorkday;
  final WorkAndSalaryStatusEnum status;

  const WorkAndSalaryState(
      {this.permission = 0,
      this.used = 0,
      this.remaining = 0,
      this.totalWorkday = 0,
      this.status = WorkAndSalaryStatusEnum.init});

  @override
  List<Object> get props => [permission, used, remaining, totalWorkday, status];
}
