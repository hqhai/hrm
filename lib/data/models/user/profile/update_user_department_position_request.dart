import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_department_position_request.g.dart';

@CopyWith()
@JsonSerializable()
class UpdateUserDepartmentPositionRequest {
  final String? id;
  final String? departmentId;
  final String? positionId;

  const UpdateUserDepartmentPositionRequest({
    this.id,
    this.departmentId,
    this.positionId,
  });

  factory UpdateUserDepartmentPositionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDepartmentPositionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDepartmentPositionRequestToJson(this);
}
