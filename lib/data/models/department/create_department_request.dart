import 'package:json_annotation/json_annotation.dart';

part 'create_department_request.g.dart';

@JsonSerializable()
class CreateDepartmentRequest {
  final String name;
  final String code;
  final String phoneNumber;
  final String email;
  final String address;
  final String? description;
  final String? parentId;

  const CreateDepartmentRequest(
      {required this.name,
        required this.code,
        required this.phoneNumber,
        required this.email,
        required this.address,
        this.description,
        this.parentId,});

  factory CreateDepartmentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDepartmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDepartmentRequestToJson(this);
}
