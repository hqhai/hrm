import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/reqisition/requisition.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'requisition_state.g.dart';

@CopyWith()
class RequisitionState extends Equatable {
  const RequisitionState({
    this.requisition = const Requisition(id: '',),
    this.requisitions = const [],
    this.status = RequisitionEnum.init
  });

  final Requisition requisition;
  final List<Requisition> requisitions;
  final RequisitionEnum status;

  @override
  List<Object> get props => [requisition, requisitions, status];
}
