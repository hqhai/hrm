import 'package:base_app/common/enum/school_status.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'school_state.g.dart';

@CopyWith()
class SchoolState extends Equatable {
  final Map<String, School> schools;
  final List<String> schoolIds;
  final SchoolStatus status;

  const SchoolState({
    this.schoolIds = const [],
    this.schools = const {},
    this.status = SchoolStatus.init,
  });

  @override
  List<Object> get props => [schools, status, schoolIds];
}
