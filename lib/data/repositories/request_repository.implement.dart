import 'dart:io';
import 'dart:typed_data';

import 'package:base_app/data/models/create_request/create_request_request.dart';
import 'package:base_app/data/models/request/change_list_status/change_list_status_request.dart';
import 'package:base_app/data/models/request/change_list_status/change_status_request_command_models.dart';
import 'package:base_app/data/models/request/explanation/create_explanation_config_request.dart';
import 'package:base_app/data/models/request/explanation/create_explanation_request.dart';
import 'package:base_app/data/models/request/explanation/get_list_user_by_request_explanation.dart';
import 'package:base_app/data/models/request/get_request/get_by_admin/get_request_by_admin.dart';
import 'package:base_app/data/models/request/get_request/get_by_id/get_request_by_id.dart';
import 'package:base_app/data/models/request/get_request/get_request.dart';
import 'package:base_app/data/models/request/on_leave/create_onleave_config_request.dart';
import 'package:base_app/data/models/request/on_leave/create_onleave_request.dart';
import 'package:base_app/data/models/request/overtime/create_overtime_request.dart';
import 'package:base_app/data/models/request/overtime/list_request_types.dart';
import 'package:base_app/data/models/request/room_meeting/create_request_type_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/create_request_type_room_meeting_config.dart';
import 'package:base_app/data/models/request/room_meeting/create_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/delete_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/update_room_meeting.dart';
import 'package:base_app/data/models/request/update_request_request.dart';
import 'package:base_app/data/models/request/upload_file.dart';
import 'package:base_app/data/models/request/upload_files.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/repositories/request.repository.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/request_service.dart';

@LazySingleton(as: RequestRepository)
class RequestRepositoryImplement extends RequestRepository {
  final RequestService _requestService;

  RequestRepositoryImplement(this._requestService);

  @override
  Future<int?> createRequest({required String type, required bool isApprove, required String priority, String? title, String? content, List<String>? filePaths, String? approverId, String? config}) async {
    final response = await _requestService.createRequest(
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
    return response?.statusCode;
  }

  @override
  Future<int?> getRequest(String status, int page) async {
    final response = await _requestService.getRequest(GetRequestRequest(status: status, page: page));
    return response;
  }

  @override
  Future<Request?> getRequestById(String id) async {
    final response = await _requestService.getRequestById(GetRequestRequestById(id: id));
    return response?.data;
  }

  @override
  Future<String?> uploadFile({
    File? originFile,
    Uint8List? imageData,
  }) async {
    final response = await _requestService.uploadFile(uploadFileRequest: UploadFileRequest(originFile: originFile, imageData: imageData));
    return response?.data;
  }

  @override
  Future<List<String>?> uploadFiles({List<File>? originFile, List<Uint8List>? imageData}) async {
    final response = await _requestService.uploadFiles(uploadFileRequests: UploadFilesRequest(imageDatas: imageData, originFiles: originFile));
    return response?.meta?.items;
  }

  @override
  Future<Request?> updateRequestById({required String priority, String? title, String? content, List<String>? filePaths, required String id}) async {
    final response = await _requestService.upDateRequestById(updateRequestRequest: UpdateRequestRequest(priority: priority, title: title, content: content, filePaths: filePaths), id: id);
    return response?.data;
  }

  @override
  Future<List<Request>?> getRequestByAdmin(String type, String startDate, String endDate) async {
    final response = await _requestService.getRequestByAdmin(GetRequestByAdminRequest(requestType: type, endDate: endDate, startDate: startDate));
    return response?.result;
  }

  @override
  Future<int?> createOvertimeRequest({required String type, required bool isApprove, ListRequestTypes? config}) async {
    final response = await _requestService.createOvertimeRequest(
      CreateOverTimeRequest(
        type: type,
        isApprove: isApprove,
        config: config,
      ),
    );
    return response?.statusCode;
  }

  @override
  Future<int?> createOnLeaveRequest({required String type, required bool isApprove, required String priority, String? title, String? content, CreateOnLeaveConfigRequest? config}) async {
    final response = await _requestService.createOnLeave(
      CreateOnLeaveRequest(type: type, isApprove: isApprove, priority: priority, title: title, content: content, config: config),
    );
    return response?.statusCode;
  }

  @override
  Future<int?> createExplanationRequest({required String type, required bool isApprove, required String priority, String? title, String? content, CreateExplanationConfigRequest? config}) async {
    final response = await _requestService.createExplanation(
      CreateExplanationRequest(type: type, isApprove: isApprove, priority: priority, title: title, content: content, config: config),
    );
    return response?.statusCode;
  }

  @override
  Future<int?> changeListStatus({required List<ChangeStatusRequestCommandModels> changeStatusRequestCommandModels, required String enumRequestType}) async {
    final response = await _requestService.changeListStatus(changeListStatusRequest: ChangeListStatusRequest(changeStatusRequestCommandModels: changeStatusRequestCommandModels, enumRequestType: enumRequestType));
    return response?.statusCode;
  }

  @override
  Future<int?> createRoomMeeting({String? roomName, int? numberOfSeats, String? address, String? description, bool? isApproval}) async {
    final response = await _requestService.createRoomMeeting(createRoomMeetingRequest: CreateRoomMeetingRequest(roomName: roomName, numberOfSeats: numberOfSeats, description: description, address: address, isApproval: isApproval));
    return response?.statusCode;
  }

  @override
  Future<List<RoomMeeting>?> getRoomMeeting() async {
    final response = await _requestService.getRoomMeeting();
    return response?.result;
  }

  @override
  Future<int?> createRoomMeetingRequest({required String type, String? title, String? content, required CreateRequestTypeRoomMeetingConfigRequest config}) async {
    final response = await _requestService.createRoomMeetingRequest(createRequestTypeRoomMeetingRequest: CreateRequestTypeRoomMeetingRequest(type: type, title: title, content: content, config: config));

    return response?.statusCode;
  }

  @override
  Future<List<User>?> getListUserByRequest({required String startDate, required String endDate}) async {
    final response = await _requestService.getListUserByRequest(getListUserByRequestExplanationRequest: GetListUserByRequestExplanationRequest(startDate: startDate, endDate: endDate));
    return response?.meta?.items;
  }

  @override
  Future<int?> updateRoomMeeting({String? roomName, int? numberOfSeats, String? address, String? description, String? id}) async {
    final response = await _requestService.updateRoomMeeting(updateRoomMeetingRequest: UpdateRoomMeetingRequest(id: id, address: address, description: description, numberOfSeats: numberOfSeats, roomName: roomName));
    return response?.statusCode;
  }

  @override
  Future<int?> deleteRoomMeeting({String? id}) async {
    final response = await _requestService.deleteRoomMeeting(
        deleteRoomMeetingRequest: DeleteRoomMeetingRequest(
      id: id,
    ));
    return response?.statusCode;
  }
}
