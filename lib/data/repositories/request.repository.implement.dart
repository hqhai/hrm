import 'dart:io';
import 'dart:typed_data';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/request/change_list_status/change_list_status_request.dart';
import 'package:base_app/data/models/request/change_list_status/change_status_request_command_models.dart';

import 'package:base_app/data/models/create_request/create_request_request.dart';
import 'package:base_app/data/models/request/explanation/create_explanation_config_request.dart';
import 'package:base_app/data/models/request/explanation/create_explanation_request.dart';
import 'package:base_app/data/models/request/explanation/get_list_user_by_request_explanation.dart';
import 'package:base_app/data/models/request/get_request/get_request.dart';
import 'package:base_app/data/models/request/get_request/get_by_admin/get_request_by_admin.dart';
import 'package:base_app/data/models/request/get_request/get_by_id/get_request_by_id.dart';
import 'package:base_app/data/models/request/on_leave/create_onleave_config_request.dart';
import 'package:base_app/data/models/request/on_leave/create_onleave_request.dart';
import 'package:base_app/data/models/request/overtime/list_request_types.dart';
import 'package:base_app/data/models/request/overtime/create_overtime_request.dart';
import 'package:base_app/data/models/request/room_meeting/create_request_type_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/create_request_type_room_meeting_config.dart';
import 'package:base_app/data/models/request/room_meeting/create_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/delete_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/update_room_meeting.dart';
import 'package:base_app/data/models/request/update_request_request.dart';
import 'package:base_app/data/models/request/upload_file.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/repositories/request.repository.dart';
import 'package:base_app/domain/services/request.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RequestRepository)
class RequestRepositoryImplement extends RequestRepository {
  final RequestService requestService;

  RequestRepositoryImplement() : requestService = dI<RequestService>();

  @override
  Future<int> createRequest(
      {required String type,
      required bool isApprove,
      required String priority,
      String? title,
      String? content,
      List<String>? filePaths,
      String? approverId,
      String? config}) async {
    return await requestService.createRequest(
      CreateRequestRequest(
        type: type,
        isApprove: isApprove,
        priority: priority,
        title: title,
        content: content,
        approverId: approverId,
        filePaths: filePaths,
        config: config,
      ),
    );
  }

  @override
  Future<int> getRequest(String status, int page) async {
    return await requestService.getRequest(GetRequestRequest(status: status, page: page));
  }

  @override
  Future<Request> getRequestById(String id) async {
    return await requestService.getRequestById(GetRequestRequestById(id: id));
  }

  @override
  Future<String> uploadFile({File? originFile, Uint8List? imageData,}) async {
    return await requestService.uploadFile(
        uploadFileRequest: UploadFileRequest(originFile: originFile, imageData: imageData));
  }

  @override
  Future<Request> updateRequestById(
      {required String priority,
      String? title,
      String? content,
      List<String>? filePaths,
      required String id}) async {
    return await requestService.upDateRequestById(
        updateRequestRequest: UpdateRequestRequest(
            priority: priority, title: title, content: content, filePaths: filePaths),
        id: id);
  }

  @override
  Future<List<Request>> getRequestByAdmin(String type, String startDate, String endDate) async {
    return await requestService.getRequestByAdmin(
        GetRequestByAdminRequest(requestType: type, endDate: endDate, startDate: startDate));
  }

  @override
  Future<int> createOvertimeRequest(
      {required String type, required bool isApprove, ListRequestTypes? config}) async {
    return await requestService.createOvertimeRequest(
      CreateOverTimeRequest(
        type: type,
        isApprove: isApprove,
        config: config,
      ),
    );
  }

  @override
  Future<int> createOnLeaveRequest(
      {required String type,
      required bool isApprove,
      required String priority,
      String? title,
      String? content,
      CreateOnLeaveConfigRequest? config}) async {
    return await requestService.createOnLeave(
      CreateOnLeaveRequest(
          type: type,
          isApprove: isApprove,
          priority: priority,
          title: title,
          content: content,
          config: config),
    );
  }
  @override
  Future<int> createExplanationRequest(
      {required String type,
        required bool isApprove,
        required String priority,
        String? title,
        String? content,
        CreateExplanationConfigRequest? config}) async {
    return await requestService.createExplanation(
      CreateExplanationRequest(
          type: type,
          isApprove: isApprove,
          priority: priority,
          title: title,
          content: content,
          config: config),
    );
  }


  @override
  Future<int> changeListStatus(
      {required List<ChangeStatusRequestCommandModels> changeStatusRequestCommandModels,
      required String enumRequestType}) async {
    return await requestService.changeListStatus(
        changeListStatusRequest: ChangeListStatusRequest(
            changeStatusRequestCommandModels: changeStatusRequestCommandModels,
            enumRequestType: enumRequestType));
  }



  @override
  Future<int> createRoomMeeting(
      {String? roomName,
      int? numberOfSeats,
      String? address,
      String? description,
      bool? isApproval}) async {
    return await requestService.createRoomMeeting(
        createRoomMeetingRequest: CreateRoomMeetingRequest(
            roomName: roomName,
            numberOfSeats: numberOfSeats,
            description: description,
            address: address,
            isApproval: isApproval));
  }

  @override
  Future<List<RoomMeeting>> getRoomMeeting() async {
    return await requestService.getRoomMeeting();
  }

  @override
  Future<int> createRoomMeetingRequest(
      {required String type,
      String? title,
      String? content,
      required CreateRequestTypeRoomMeetingConfigRequest config}) async {
    return await requestService.createRoomMeetingRequest(
        createRequestTypeRoomMeetingRequest: CreateRequestTypeRoomMeetingRequest(
            type: type, title: title, content: content, config: config));
  }

  @override
  Future<List<User>> getListUserByRequest(
      {required String startDate, required String endDate}) async {
    final users = await requestService.getListUserByRequest(
        getListUserByRequestExplanationRequest:
            GetListUserByRequestExplanationRequest(startDate: startDate, endDate: endDate));
    return users;
  }

  @override
  Future<int> updateRoomMeeting(
      {String? roomName,
      int? numberOfSeats,
      String? address,
      String? description,
      String? id}) async {
    return await requestService.updateRoomMeeting(
        updateRoomMeetingRequest: UpdateRoomMeetingRequest(
            id: id,
            address: address,
            description: description,
            numberOfSeats: numberOfSeats,
            roomName: roomName));
  }

  @override
  Future<int> deleteRoomMeeting({String? id}) async {
    return await requestService.deleteRoomMeeting(
        deleteRoomMeetingRequest: DeleteRoomMeetingRequest(
      id: id,
    ));
  }
}
