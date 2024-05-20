import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/entities/position.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_department_position.g.dart';

@CopyWith()
@JsonSerializable()
class UserDepartmentPosition {
  final String? userId;
  final String? departmentId;
  final Department? department;
  final String? positionId;
  final Position? position;

  const UserDepartmentPosition(
      {this.userId, this.departmentId, this.department, this.positionId, this.position});

  factory UserDepartmentPosition.fromJson(Map<String, dynamic> json) =>
      _$UserDepartmentPositionFromJson(json);

  Map<String, dynamic> toJson() => _$UserDepartmentPositionToJson(this);
}
