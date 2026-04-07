import 'package:base_app/domain/models/paging/paging_infor_request.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_schools_response.g.dart';

@JsonSerializable()
class GetListSchoolsResponse {
  final List<School> items;
  final PagingInfoRequest pagingInfo;

  const GetListSchoolsResponse({
    this.items = const [],
    this.pagingInfo = const PagingInfoRequest(totalItems: 0, pageSize: 0, page: 1),
  });

  factory GetListSchoolsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListSchoolsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListSchoolsResponseToJson(this);
}
