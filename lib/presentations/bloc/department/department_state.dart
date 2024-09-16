import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'department_state.g.dart';

@CopyWith()
@JsonSerializable()
class DepartmentState extends Equatable {
  final Department department;
  final List<Department> departments;
  final DepartmentStatus status;
  final int totalItems;

  const DepartmentState({
    this.department = const Department(id: '', createdUserId: ''),
    this.departments = const [],
    this.status = DepartmentStatus.init,
    this.totalItems = 0,
  });

  @override
  List<Object> get props => [status, department, departments];

  factory DepartmentState.fromJson(Map<String, dynamic> json) =>
      _$DepartmentStateFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentStateToJson(this);
}
