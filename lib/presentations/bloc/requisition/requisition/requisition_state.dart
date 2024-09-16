import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_state.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionState extends Equatable {
  final Request requisition;
  final Map<String, Request> requisitions;
  final List<String> requisitionIds;
  final String errorCode;
  final int countItem;

  const RequisitionState({
    this.requisition = const Request(id: ''),
    this.requisitions = const {},
    this.requisitionIds = const [],
    this.countItem = 0,
    this.errorCode = '',
  });

  @override
  List<Object> get props =>
      [requisition, requisitions, requisitionIds, countItem, errorCode];

  factory RequisitionState.fromJson(Map<String, dynamic> json) => _$RequisitionStateFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionStateToJson(this);
}
