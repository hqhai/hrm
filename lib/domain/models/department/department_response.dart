import 'package:base_app/domain/models/paging/paging_infor_request.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:json_annotation/json_annotation.dart';

part 'department_response.g.dart';

@JsonSerializable()
class DepartmentResponse {
  final List<Department> items;
  final PagingInfoRequest pagingInfo;

  const DepartmentResponse({
    this.items = const [],
    this.pagingInfo = const PagingInfoRequest(page: 0, pageSize: 0, totalItems: 0),
  });

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) =>
      _$DepartmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentResponseToJson(this);
}
