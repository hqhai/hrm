import 'package:json_annotation/json_annotation.dart';

part 'department.g.dart';

@JsonSerializable()
class Department {
  final String id;
  final String createdUserId;
  final String? updatedUserId;
  final String? createdFullName;
  final String? updatedFullName;
  final String? code;
  final String? name;
  final String? phoneNumber;
  final String? fax;
  final String? email;
  final String? address;
  final String? description;
  final String? parentId;
  final String? parentName;
  final bool? canNotDelete;
  final List<Department> childrens;

  const Department(
      {this.name,
      this.phoneNumber,
      this.email,
      this.address,
      this.description,
      this.parentId,
      required this.id,
      required this.createdUserId,
      this.updatedUserId,
      this.createdFullName,
      this.updatedFullName,
      this.code,
      this.canNotDelete,
      this.fax,
      this.parentName,
      this.childrens = const []});

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
