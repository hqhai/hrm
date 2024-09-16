

import 'package:base_app/common/enum/enum_config.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'personnel_state.g.dart';

@CopyWith()
@JsonSerializable()
class PersonnelState extends Equatable {
  final PersonnelStatus status;
  const PersonnelState({this.status = PersonnelStatus.init});

  @override
  List<Object> get props => [status];

  factory PersonnelState.fromJson(Map<String, dynamic> json) => _$PersonnelStateFromJson(json);

  Map<String, dynamic> toJson() => _$PersonnelStateToJson(this);
}

