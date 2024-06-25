import 'dart:async';
import 'dart:io';

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
  final Completer completer;
  final List<File> files;

  const PostRequestEvent({
    this.postRequestRequest = const PostRequestRequest(),
    required this.completer,
    this.files = const [],
  });

  @override
  List<Object?> get props => [postRequestRequest, completer, files];
}

class UserRejectRequestEvent extends RequisitionEvent {
  const UserRejectRequestEvent({this.id});
  final String? id;

  @override
  List<Object?> get props => [id];
}

class GetRequisitionsByFilterEvent extends RequisitionEvent {
  const GetRequisitionsByFilterEvent(
      {this.flowId, this.listStatusRequisition, this.startTime, this.endTime, this.page});

  final int? page;
  final String? flowId;
  final List<StatusRequestEnum>? listStatusRequisition;
  final String? startTime;
  final String? endTime;

  @override
  List<Object?> get props => [flowId, listStatusRequisition, startTime, endTime, page];
}

class GetRequisitionByIdEvent extends RequisitionEvent {
  const GetRequisitionByIdEvent({this.id});

  final String? id;

  @override
  List<Object?> get props => [id];
}

class EditRequestEvent extends RequisitionEvent {
  final PostRequestRequest postRequestRequest;
  final Completer completer;
  final List<File> files;

  const EditRequestEvent({
    this.postRequestRequest = const PostRequestRequest(),
    required this.completer,
    this.files = const []
  });

  @override
  List<Object?> get props => [postRequestRequest, completer, files];
}
