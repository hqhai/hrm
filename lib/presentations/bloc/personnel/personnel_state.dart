

import 'package:base_app/common/enum/enum_config.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'personnel_state.g.dart';

@CopyWith()
class PersonnelState extends Equatable {
  final PersonnelStatus status;
  const PersonnelState({this.status = PersonnelStatus.init});

  @override
  List<Object> get props => [status];
}

