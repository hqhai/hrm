import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flow_state.g.dart';

@CopyWith()
@JsonSerializable()
class FlowState extends Equatable {
  final FlowRequest flow;
  final List<FlowRequest> flows;
  final FlowStatusEnum statusGet;
  final FlowStatusEnum statusGetById;
  final int totalItems;
  final String? errorCode;

  const FlowState({
    this.flow = const FlowRequest(id: ''),
    this.flows = const [],
    this.statusGet = FlowStatusEnum.init,
    this.statusGetById = FlowStatusEnum.init,
    this.totalItems = 0,
    this.errorCode,
  });

  @override
  List<Object> get props => [
        flow,
        flows,
        statusGet,
        statusGetById,
        totalItems,
        errorCode ?? '',
      ];

  factory FlowState.fromJson(Map<String, dynamic> json) =>
      _$FlowStateFromJson(json);

  Map<String, dynamic> toJson() => _$FlowStateToJson(this);
}
