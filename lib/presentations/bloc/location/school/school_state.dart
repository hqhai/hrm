import 'package:base_app/common/enum/school_status.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'school_state.g.dart';

@CopyWith()
@JsonSerializable()
class SchoolState extends Equatable {
  final Map<String, School> schools;
  final List<String> schoolIds;
  final SchoolStatus status;
  final int totalItems;

  const SchoolState({
    this.schoolIds = const [],
    this.schools = const {},
    this.status = SchoolStatus.init,
    this.totalItems = 0,
  });

  @override
  List<Object> get props => [schools, status, schoolIds, totalItems];

  factory SchoolState.fromJson(Map<String, dynamic> json) =>
      _$SchoolStateFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolStateToJson(this);
}
