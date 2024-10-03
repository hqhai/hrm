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
  final List<File> files;

  const PostRequestEvent({
    this.postRequestRequest = const PostRequestRequest(),
    this.files = const [],
  });

  @override
  List<Object?> get props => [postRequestRequest, files];
}

class UserRejectRequestEvent extends RequisitionEvent {
  const UserRejectRequestEvent({this.id, this.completer,});

  final String? id;
  final Completer? completer;

  @override
  List<Object?> get props => [id, completer];
}

class GetRequisitionsByFilterEvent extends RequisitionEvent {
  final int? page;
  final List<String>? flowIds;
  final StatusRequestEnum? status;
  final DateTime? startTime;
  final DateTime? endTime;
  final Completer? completer;

  const GetRequisitionsByFilterEvent(
      {this.flowIds,
      this.status,
      this.startTime,
      this.endTime,
      this.page,
      this.completer});

  @override
  List<Object?> get props => [flowIds, status, startTime, endTime, page, completer];
}

class GetRequisitionByIdEvent extends RequisitionEvent {
  const GetRequisitionByIdEvent({this.id, this.completer});

  final Completer? completer;
  final String? id;

  @override
  List<Object?> get props => [id, completer];
}

class EditRequestEvent extends RequisitionEvent {
  final PostRequestRequest postRequestRequest;
  final List<File> files;

  const EditRequestEvent(
      {this.postRequestRequest = const PostRequestRequest(),
      this.files = const []});

  @override
  List<Object?> get props => [postRequestRequest, files];
}

class ResetRequisitionEvent extends RequisitionEvent {
  const ResetRequisitionEvent();

  @override
  List<Object> get props => [];
}

class GetRequisitionUserCountEvent extends RequisitionEvent {
  final List<String>? flowIds;
  final StatusRequestEnum? status;
  final DateTime? startTime;
  final DateTime? endTime;
  final Completer? completer;

  const GetRequisitionUserCountEvent(
      {this.flowIds,
        this.status,
        this.startTime,
        this.endTime,
        this.completer});

  @override
  List<Object?> get props => [flowIds, status, startTime, endTime, completer];
}
