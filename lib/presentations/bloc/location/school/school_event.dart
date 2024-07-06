import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class SchoolEvent extends Equatable {
  const SchoolEvent();

  @override
  List<Object?> get props => [];
}

class GetListSchoolsEvent extends SchoolEvent {
  final String keyword;
  final int page;
  final Completer? completer;
  const GetListSchoolsEvent({this.page = 1, this.keyword = '',this.completer});

  @override
  List<Object?> get props => [page, keyword, completer];
}
