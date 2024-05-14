import 'package:json_annotation/json_annotation.dart';

part 'update_department_request.g.dart';

@JsonSerializable()
class UpdateDepartmentRequest {
  final String id;
  final String name;
  final String code;
  final String phoneNumber;
  final String email;
  final String address;
  final String? description;
  final String? parentId;

  const UpdateDepartmentRequest({
    required this.id,
    required this.name,
    required this.code,
    required this.phoneNumber,
    required this.email,
    required this.address,
    this.description,
    this.parentId,
  });

  factory UpdateDepartmentRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateDepartmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDepartmentRequestToJson(this);
}
