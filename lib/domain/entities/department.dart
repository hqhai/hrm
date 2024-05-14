import 'package:json_annotation/json_annotation.dart';
part 'department.g.dart';

@JsonSerializable()
class Department {
  final String name;
  final String code;
  final String phoneNumber;
  final String email;
  final String address;
  final String? description;
  final String? parentId;
  final String id;
  final String createdUserId;
  final String? updatedUserId;
  final String createdFullName;
  final String? updatedFullName;
  final String createdDate;
  final String? updatedDate;

  const Department({
    required this.name,
    required this.code,
    required this.phoneNumber,
    required this.email,
    required this.address,
    this.description,
    this.parentId,
    required this.id,
    required this.createdUserId,
    this.updatedUserId,
    required this.createdFullName,
    this.updatedFullName,
    required this.createdDate,
    this.updatedDate,
  });

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
