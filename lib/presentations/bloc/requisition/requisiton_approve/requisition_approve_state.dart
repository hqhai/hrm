import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'requisition_approve_state.g.dart';

@CopyWith()
class RequisitionApproveState extends Equatable {
  final Request requisition;
  final Map<String, Request> requisitions;
  final List<String> requisitionIds;
  final String errorCode;
  final int countItem;

  const RequisitionApproveState({
    this.requisition = const Request(id: ''),
    this.requisitions = const {},
    this.requisitionIds = const [],
    this.countItem = 0,
    this.errorCode = '',
  });

  @override
  List<Object> get props => [requisition, requisitions, requisitionIds, countItem, errorCode];
}
