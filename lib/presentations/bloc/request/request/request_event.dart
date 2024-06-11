import 'dart:io';

import 'package:base_app/data/models/request/change_list_status/change_status_request_command_models.dart';
import 'package:base_app/data/models/request/explanation/create_explanation_config_request.dart';
import 'package:base_app/data/models/request/on_leave/create_onleave_config_request.dart';
import 'package:base_app/data/models/request/overtime/list_request_types.dart';
import 'package:base_app/data/models/request/room_meeting/create_request_type_room_meeting_config.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

sealed class RequestEvent extends Equatable {
  const RequestEvent();

  @override
  List<Object> get props => [];
}

class CreateOvertimeRequestEvent extends RequestEvent {
  final String type;
  final bool isApprove;
  final ListRequestTypes config;

  const CreateOvertimeRequestEvent({
    this.type = '',
    this.isApprove = false,
    this.config = const ListRequestTypes(listRequestTypes: []),
  });

  @override
  List<Object> get props => [
        type,
        isApprove,
        config,
      ];
}

class CreateOnLeaveRequestEvent extends RequestEvent {
  final String type;
  final bool isApprove;
  final String priority;
  final String title;
  final String content;
  final CreateOnLeaveConfigRequest config;

  const CreateOnLeaveRequestEvent({
    this.type = '',
    this.isApprove = false,
    this.priority = '',
    this.title = '',
    this.content = '',
    this.config = const CreateOnLeaveConfigRequest(endOnLeave: '', startOnLeave: ''),
  });

  @override
  List<Object> get props => [
        type,
        isApprove,
        priority,
        title,
        content,
        config,
      ];
}

class CreateExplanationRequestEvent extends RequestEvent {
  final String type;
  final bool isApprove;
  final String priority;
  final String title;
  final String content;
  final CreateExplanationConfigRequest config;

  const CreateExplanationRequestEvent({
    this.type = '',
    this.isApprove = false,
    this.priority = '',
    this.title = '',
    this.content = '',
    this.config = const CreateExplanationConfigRequest(lateDay: ''),
  });

  @override
  List<Object> get props => [
        type,
        isApprove,
        priority,
        title,
        content,
        config,
      ];
}

class CreateRequestEventNeedApproval extends RequestEvent {
  final String type;
  final bool isApprove;
  final String priority;
  final String title;
  final String content;
  final File? file;
  final Uint8List? imageData;
  final String approverId;
  final String config;

  const CreateRequestEventNeedApproval({
    this.type = '',
    this.isApprove = true,
    this.config = '',
    this.content = '',
    this.file,
    this.imageData,
    this.approverId = '',
    this.priority = '',
    this.title = '',
  });

  @override
  List<Object> get props => [
        type,
        isApprove,
        config,
        content,
        file ?? File(''),
        imageData ?? Uint8List(0),
        approverId,
        priority,
        title,
      ];
}

class CreateRequestEventNoNeedApproval extends RequestEvent {
  final String type;
  final bool isApprove;
  final String priority;
  final String title;
  final String content;
  final File? file;
  final Uint8List? imageData;
  final String config;

  const CreateRequestEventNoNeedApproval({
    this.type = '',
    this.isApprove = true,
    this.config = '',
    this.content = '',
    this.file,
    this.imageData,
    this.priority = '',
    this.title = '',
  });

  @override
  List<Object> get props => [
        type,
        isApprove,
        config,
        content,
        file ?? File(''),
        imageData ?? Uint8List.fromList(List.filled(10, 0)),
        priority,
        title,
      ];
}

class GetRequestEvent extends RequestEvent {
  final String status;
  final int page;
  final List<Request> requests;

  const GetRequestEvent({this.status = '', this.page = 0, this.requests = const []});

  @override
  List<Object> get props => [status, page, requests];
}

class GetRequestByAdminEvent extends RequestEvent {
  final String type;
  final String startDate;
  final String endDate;

  const GetRequestByAdminEvent({this.type = '', this.startDate = '', this.endDate = ''});

  @override
  List<Object> get props => [type, startDate, endDate];
}

class GetRequestByIdEvent extends RequestEvent {
  final String id;

  const GetRequestByIdEvent({
    this.id = '',
  });

  @override
  List<Object> get props => [id];
}

class UpdateRequestByIdEvent extends RequestEvent {
  final String id;
  final String priority;
  final String title;
  final String content;
  final File? file;
  final Uint8List? imageData;
  final List<String> path;

  const UpdateRequestByIdEvent({
    this.id = '',
    this.priority = '',
    this.file,
    this.content = '',
    this.title = '',
    this.imageData,
    this.path = const [],
  });

  @override
  List<Object> get props => [
        id,
        priority,
        title,
        content,
        file ?? File(''),
        imageData ?? Uint8List.fromList(List.filled(10, 0)),
        path
      ];
}

class ChangeListStatusEvent extends RequestEvent {
  final List<ChangeStatusRequestCommandModels> changeStatusRequestCommandModels;
  final String enumRequestType;

  const ChangeListStatusEvent(
      {this.changeStatusRequestCommandModels = const [], this.enumRequestType = ''});

  @override
  List<Object> get props => [changeStatusRequestCommandModels, enumRequestType];
}

class CreateRoomMeetingRequestEvent extends RequestEvent {
  final String type;
  final String title;
  final String content;
  final CreateRequestTypeRoomMeetingConfigRequest config;

  const CreateRoomMeetingRequestEvent({
    this.type = '',
    this.title = '',
    this.content = '',
    this.config = const CreateRequestTypeRoomMeetingConfigRequest(
      roomMeetingId: '',
      meetingEndTime: '',
      meetingStartTime: '',
    ),
  });

  @override
  List<Object> get props => [type, title, content, config];
}

class ResetRequestEvent extends RequestEvent {
  const ResetRequestEvent();

  @override
  List<Object> get props => [];
}

class GetRequestByUserEvent extends RequestEvent {
  final List<Request> requests;
  final String userId;

  const GetRequestByUserEvent({this.requests = const [], this.userId = ''});

  @override
  List<Object> get props => [requests, userId];
}
