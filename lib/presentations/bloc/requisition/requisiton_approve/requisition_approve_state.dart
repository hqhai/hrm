import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'requisition_approve_state.g.dart';

@CopyWith()
class RequisitionApproveState extends Equatable {
  final Request requisition;
  final List<Request> requisitions;
  final RequisitionEnum status;
  final int countItem;
  final int page;
  final String requisitionTypeEnum;
  final String departmentId;
  final String startTime;
  final String endTime;
  final String statusRequest;

  const RequisitionApproveState(
      {this.requisition = const Request(id: ''),
      this.requisitions = const [],
      this.status = RequisitionEnum.init,
      this.countItem = 0,
      this.page = 0,
      this.requisitionTypeEnum = '',
      this.departmentId = '',
      this.startTime = '',
      this.endTime = '',
      this.statusRequest = ''});

  @override
  List<Object> get props => [
        requisition,
        requisitions,
        status,
        countItem,
        endTime,
        startTime,
        departmentId,
        requisitionTypeEnum,
        page,
        statusRequest
      ];
}
