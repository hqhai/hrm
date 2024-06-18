import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:equatable/equatable.dart';

sealed class RequisitionFollowingEvent extends Equatable {
  const RequisitionFollowingEvent();

  @override
  List<Object?> get props => [];
}

class GetRequisitionsFollowingEvent extends RequisitionFollowingEvent {
  const GetRequisitionsFollowingEvent({this.page = 0});

  final int page;

  @override
  List<Object?> get props => [page];
}

class GetRequisitionsFollowingByFilterEvent extends RequisitionFollowingEvent {
  const GetRequisitionsFollowingByFilterEvent(
      {this.requisitionTypeEnum,
      this.listStatusRequisition,
      this.startTime,
      this.endTime,
      this.page});

  final int? page;
  final RequisitionTypeEnum? requisitionTypeEnum;
  final List<StatusRequestEnum>? listStatusRequisition;
  final String? startTime;
  final String? endTime;

  @override
  List<Object?> get props => [requisitionTypeEnum, listStatusRequisition, startTime, endTime, page];
}

class GetRequisitionFollowingByIdEvent extends GetRequisitionsFollowingByFilterEvent {
  const GetRequisitionFollowingByIdEvent({this.id});

  final String? id;

  @override
  List<Object?> get props => [id];
}
