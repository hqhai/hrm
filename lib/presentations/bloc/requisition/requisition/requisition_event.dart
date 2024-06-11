import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:equatable/equatable.dart';

sealed class RequisitionEvent extends Equatable {
  const RequisitionEvent();

  @override
  List<Object?> get props => [];
}

class PostRequestEvent extends RequisitionEvent {
  final PostRequestRequest postRequestRequest;

  const PostRequestEvent({
    this.postRequestRequest = const PostRequestRequest(),
  });

  @override
  List<Object?> get props => [postRequestRequest];
}

class GetRequisitionsEvent extends RequisitionEvent {
  const GetRequisitionsEvent();

  @override
  List<Object?> get props => [];
}

class GetRequisitionsByFilterEvent extends RequisitionEvent {
  const GetRequisitionsByFilterEvent(
      {this.requisitionTypeEnum, this.listStatusRequisition, this.startTime, this.endTime});

  final RequisitionTypeEnum? requisitionTypeEnum;
  final List<StatusRequestEnum>? listStatusRequisition;
  final String? startTime;
  final String? endTime;

  @override
  List<Object?> get props => [requisitionTypeEnum, listStatusRequisition, startTime, endTime];
}

class GetRequisitionByIdEvent extends RequisitionEvent {
  const GetRequisitionByIdEvent({this.requisition});

  final Request? requisition;

  @override
  List<Object?> get props => [requisition];
}
