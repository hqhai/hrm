import 'dart:io';

import 'package:base_app/data/models/request/change_list_status/change_status_request_command_models.dart';
import 'package:base_app/data/models/request/explanation/create_explanation_config_request.dart';
import 'package:base_app/data/models/request/on_leave/create_onleave_config_request.dart';
import 'package:base_app/data/models/request/overtime/list_request_types.dart';
import 'package:base_app/data/models/request/room_meeting/create_request_type_room_meeting_config.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/repositories/request.repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RequestUseCase {
  RequestUseCase(this._requestRepository);

  final RequestRepository _requestRepository;

  Future<int> createRequest({
    required String type,
    required bool isApprove,
    required String priority,
    String? title,
    String? content,
    List<String>? filePaths,
    String? approverId,
    String? config,
  }) async {
    final response = await _requestRepository.createRequest(
      content: content,
      title: title,
      approverId: approverId,
      config: config,
      filePaths: filePaths,
      isApprove: isApprove,
      priority: priority,
      type: type,
    );
    return response ?? 0;
  }

  Future<int> createOvertimeRequest({
    required String type,
    required bool isApprove,
    ListRequestTypes? config,
  }) async {
    final response = await _requestRepository.createOvertimeRequest(
      config: config,
      isApprove: isApprove,
      type: type,
    );
    return response ?? 0;
  }

  Future<int> createOnLeaveRequest({
    required String type,
    required bool isApprove,
    required String priority,
    String? title,
    String? content,
    CreateOnLeaveConfigRequest? config,
  }) async {
    final response = await _requestRepository.createOnLeaveRequest(
      type: type,
      isApprove: isApprove,
      priority: priority,
      content: content,
      title: title,
      config: config,
    );
    return response ?? 0;
  }

  Future<int> createExplanationRequest({
    required String type,
    required bool isApprove,
    required String priority,
    String? title,
    String? content,
    CreateExplanationConfigRequest? config,
  }) async {
    final response = await _requestRepository.createExplanationRequest(
      type: type,
      isApprove: isApprove,
      priority: priority,
      content: content,
      title: title,
      config: config,
    );
    return response ?? 0;
  }

  Future<int> getRequest({required String status, required int page}) async {
    final getRequestByUserResponse = await _requestRepository.getRequest(status, page);
    return getRequestByUserResponse ?? 0;
  }

  Future<Request> getRequestById({required String id}) async {
    final request = await _requestRepository.getRequestById(id);
    return request ?? const Request();
  }

  Future<String> uploadFile({
    File? originFile,
    Uint8List? imageData,
  }) async {
    final path = await _requestRepository.uploadFile(originFile: originFile, imageData: imageData);
    return path ?? '';
  }

  Future<List<String>> uploadFiles({List<File>? originFile, List<Uint8List>? imageData}) async {
    final path = await _requestRepository.uploadFiles(originFile: originFile, imageData: imageData);
    return path ?? [];
  }

  Future<Request> updateRequestById({required String priority, String? title, String? content, List<String>? filePaths, required String id}) async {
    final request = await _requestRepository.updateRequestById(id: id, priority: priority, filePaths: filePaths, content: content, title: title);
    return request ?? const Request();
  }

  Future<List<Request>> getRequestByAdmin({required String type, required String startDate, required String endDate}) async {
    final requests = await _requestRepository.getRequestByAdmin(type, startDate, endDate);
    return requests ?? [];
  }

  Future<int> changeListStatus({
    required List<ChangeStatusRequestCommandModels> changeStatusRequestCommandModels,
    required String enumRequestType,
  }) async {
    final response = await _requestRepository.changeListStatus(
      changeStatusRequestCommandModels: changeStatusRequestCommandModels,
      enumRequestType: enumRequestType,
    );
    return response ?? 0;
  }

  Future<int> createRoomMeeting({
    String? roomName,
    int? numberOfSeats,
    String? address,
    String? description,
    bool? isApproval,
  }) async {
    final response = await _requestRepository.createRoomMeeting(
      roomName: roomName,
      numberOfSeats: numberOfSeats,
      address: address,
      description: description,
      isApproval: isApproval,
    );
    return response ?? 0;
  }

  Future<List<RoomMeeting>> getRoomMeeting() async {
    final roomMeetings = await _requestRepository.getRoomMeeting();
    return roomMeetings ?? [];
  }

  Future<int> createRoomMeetingRequest({
    required String type,
    String? title,
    String? content,
    required CreateRequestTypeRoomMeetingConfigRequest config,
  }) async {
    final response = await _requestRepository.createRoomMeetingRequest(
      type: type,
      config: config,
      title: title,
      content: content,
    );
    return response ?? 0;
  }

  Future<List<User>> getListUserByRequest({
    required String startDate,
    required String endDate,
  }) async {
    final users = await _requestRepository.getListUserByRequest(
      startDate: startDate,
      endDate: endDate,
    );
    return users ?? [];
  }

  Future<int> updateRoomMeeting({
    String? roomName,
    int? numberOfSeats,
    String? address,
    String? description,
    String? id,
  }) async {
    final response = await _requestRepository.updateRoomMeeting(
      roomName: roomName,
      numberOfSeats: numberOfSeats,
      description: description,
      address: address,
      id: id,
    );
    return response ?? 0;
  }

  Future<int> deleteRoomMeeting({
    String? id,
  }) async {
    final response = await _requestRepository.deleteRoomMeeting(
      id: id,
    );
    return response ?? 0;
  }
}
