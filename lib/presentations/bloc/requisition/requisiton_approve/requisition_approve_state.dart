import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'requisition_approve_state.g.dart';

@CopyWith()
class RequisitionApproveState extends Equatable {
  final Request requisition;
  final List<Request> requisitions;
  final int countItem;
  final RequisitionEnum statusPost;
  final RequisitionEnum statusGet;
  final RequisitionEnum statusGetById;
  final RequisitionEnum statusApprove;

  const RequisitionApproveState({
    this.requisition = const Request(id: ''),
    this.requisitions = const [],
    this.statusApprove = RequisitionEnum.init,
    this.statusGetById = RequisitionEnum.init,
    this.statusPost = RequisitionEnum.init,
    this.statusGet = RequisitionEnum.init,
    this.countItem = 0,
  });

  @override
  List<Object> get props => [
        requisition,
        requisitions.hashCode,
        statusPost,
        statusGetById,
        statusApprove,
        countItem,
        statusGet,
      ];
}
