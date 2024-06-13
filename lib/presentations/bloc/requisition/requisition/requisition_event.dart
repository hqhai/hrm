import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
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
  final int page;

  const GetRequisitionsEvent({this.page = 0});

  @override
  List<Object?> get props => [page];
}

class GetRequisitionsByFilterEvent extends RequisitionEvent {
  const GetRequisitionsByFilterEvent(
      {this.requisitionTypeEnum, this.listStatusRequisition, this.startTime, this.endTime, this.page});

  final int? page;
  final RequisitionTypeEnum? requisitionTypeEnum;
  final List<StatusRequestEnum>? listStatusRequisition;
  final String? startTime;
  final String? endTime;

  @override
  List<Object?> get props => [requisitionTypeEnum, listStatusRequisition, startTime, endTime, page];
}

class GetRequisitionByIdEvent extends RequisitionEvent {
  const GetRequisitionByIdEvent({this.id});

  final String? id;

  @override
  List<Object?> get props => [id];
}
