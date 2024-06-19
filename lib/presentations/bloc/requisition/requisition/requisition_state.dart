import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'requisition_state.g.dart';

@CopyWith()
class RequisitionState extends Equatable {
  final Request requisition;
  final List<Request> requisitions;
  final RequisitionEnum statusGetByFilter;
  final RequisitionEnum statusGetById;
  final RequisitionEnum statusPost;
  final RequisitionEnum statusReject;
  final RequisitionEnum statusUpdate;
  final int countItem;

  const RequisitionState({
    this.requisition = const Request(id: ''),
    this.requisitions = const [],
    this.statusGetByFilter = RequisitionEnum.init,
    this.statusGetById = RequisitionEnum.init,
    this.statusPost = RequisitionEnum.init,
    this.statusUpdate = RequisitionEnum.init,
    this.statusReject = RequisitionEnum.init,
    this.countItem = 0,
  });

  @override
  List<Object> get props => [
        requisition,
        requisitions,
        statusPost,
        statusReject,
        statusUpdate,
        statusGetById,
        statusGetByFilter,
        countItem,
      ];
}
