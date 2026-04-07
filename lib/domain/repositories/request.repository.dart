import 'dart:io';

import 'package:base_app/domain/models/request/change_list_status/change_status_request_command_models.dart';
import 'package:base_app/domain/models/request/explanation/create_explanation_config_request.dart';
import 'package:base_app/domain/models/request/on_leave/create_onleave_config_request.dart';
import 'package:base_app/domain/models/request/overtime/list_request_types.dart';
import 'package:base_app/domain/models/request/room_meeting/create_request_type_room_meeting_config.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:flutter/services.dart';

abstract class RequestRepository {
  Future<int?> createRequest({
    required String type,
    required bool isApprove,
    required String priority,
    String? title,
    String? content,
    List<String>? filePaths,
    String? approverId,
    String? config,
  });

  Future<int?> createOvertimeRequest({
    required String type,
    required bool isApprove,
    ListRequestTypes? config,
  });

  Future<int?> createOnLeaveRequest({
    required String type,
    required bool isApprove,
    required String priority,
    String? title,
    String? content,
    CreateOnLeaveConfigRequest? config,
  });

  Future<int?> createExplanationRequest({
    required String type,
    required bool isApprove,
    required String priority,
    String? title,
    String? content,
    CreateExplanationConfigRequest? config,
  });

  Future<String?> uploadFile({
    File? originFile,
    Uint8List? imageData,
  });

  Future<List<String>?> uploadFiles({
    List<File>? originFile,
    List<Uint8List>? imageData,
  });

  Future<int?> getRequest(
    String status,
    int page,
  );

  Future<List<Request>?> getRequestByAdmin(
    String type,
    String startDate,
    String endDate,
  );

  Future<Request?> getRequestById(
    String id,
  );

  Future<Request?> updateRequestById(
      {required String priority,
      String? title,
      String? content,
      List<String>? filePaths,
      required String id});

  Future<int?> changeListStatus({
    required List<ChangeStatusRequestCommandModels>
        changeStatusRequestCommandModels,
    required String enumRequestType,
  });

  Future<int?> createRoomMeeting({
    String? roomName,
    int? numberOfSeats,
    String? address,
    String? description,
    bool? isApproval,
  });

  Future<List<RoomMeeting>?> getRoomMeeting();

  Future<int?> createRoomMeetingRequest({
    required String type,
    String? title,
    String? content,
    required CreateRequestTypeRoomMeetingConfigRequest config,
  });

  Future<List<User>?> getListUserByRequest(
      {required String startDate, required String endDate});

  Future<int?> updateRoomMeeting({
    String? roomName,
    int? numberOfSeats,
    String? address,
    String? description,
    String? id,
  });

  Future<int?> deleteRoomMeeting({
    String? id,
  });
}
