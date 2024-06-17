import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'flow_state.g.dart';

@CopyWith()
class FlowState extends Equatable {
  final FlowRequest flow;
  final List<FlowRequest> flows;
  final FlowStatusEnum status;
  final int totalItems;

  const FlowState(
      {this.flow = const FlowRequest(id: ''),
      this.flows = const [],
      this.status = FlowStatusEnum.init,
      this.totalItems = 0});

  @override
  List<Object> get props => [flow, flows, status, totalItems];
}
