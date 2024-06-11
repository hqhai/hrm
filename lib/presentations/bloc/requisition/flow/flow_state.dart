import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'flow_state.g.dart';

@CopyWith()
class FlowState extends Equatable {
  const FlowState(
      {this.flow = const Flow(id: ''), this.flows = const [], this.status = FlowStatusEnum.init});

  final Flow flow;
  final List<Flow> flows;
  final FlowStatusEnum status;

  @override
  List<Object> get props => [flow, flows, status];
}
