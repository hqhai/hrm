import 'package:equatable/equatable.dart';

sealed class SchoolEvent extends Equatable {
  const SchoolEvent();

  @override
  List<Object?> get props => [];
}

class GetListSchoolsEvent extends SchoolEvent {
  const GetListSchoolsEvent();

  @override
  List<Object?> get props => [];
}
