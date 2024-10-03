import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_state.g.dart';

const statusCountDefault = {
  StatusRequestEnum.process: 0,
  StatusRequestEnum.approve: 0,
  StatusRequestEnum.reject: 0,
  StatusRequestEnum.edit: 0,
  StatusRequestEnum.overdueEdit: 0,
  StatusRequestEnum.cancel: 0,
  StatusRequestEnum.overdueApprove: 0,
};

@CopyWith()
@JsonSerializable()
class RequisitionState extends Equatable {
  final Request requisition;
  final Map<String, Request> requisitions;
  final List<String> requisitionIds;
  final String errorCode;
  final int countItem;
  final Map<StatusRequestEnum, int> statusCount;

  const RequisitionState({
    this.requisition = const Request(id: ''),
    this.requisitions = const {},
    this.requisitionIds = const [],
    this.countItem = 0,
    this.errorCode = '',
    this.statusCount = statusCountDefault,
  });

  @override
  List<Object> get props =>
      [requisition, requisitions, requisitionIds, countItem, errorCode, statusCount];

  factory RequisitionState.fromJson(Map<String, dynamic> json) => _$RequisitionStateFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionStateToJson(this);
}
