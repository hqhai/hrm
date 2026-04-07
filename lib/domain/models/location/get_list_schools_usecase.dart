import 'package:base_app/domain/models/paging/paging_infor_request.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_schools_usecase.g.dart';

@JsonSerializable()
class GetListSchoolsUseCase {
  final Map<String, School> schools;
  final List<String> schoolsId;
  final PagingInfoRequest pagingInfo;

  const GetListSchoolsUseCase({
    this.schoolsId = const [],
    this.schools = const {},
    this.pagingInfo = const PagingInfoRequest(
      totalItems: 0,
      pageSize: 0,
      page: 1,
    ),
  });

  factory GetListSchoolsUseCase.fromJson(Map<String, dynamic> json) =>
      _$GetListSchoolsUseCaseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListSchoolsUseCaseToJson(this);
}
