import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/request/change_list_status/change_list_status_request.dart';
import 'package:base_app/data/models/create_request/create_request_request.dart';
import 'package:base_app/data/models/request/explanation/create_explanation_request.dart';
import 'package:base_app/data/models/request/explanation/get_list_user_by_request_explanation.dart';
import 'package:base_app/data/models/request/get_request/get_request.dart';
import 'package:base_app/data/models/request/get_request/get_by_admin/get_request_by_admin.dart';
import 'package:base_app/data/models/request/get_request/get_by_id/get_request_by_id.dart';
import 'package:base_app/data/models/request/on_leave/create_onleave_request.dart';
import 'package:base_app/data/models/request/overtime/create_overtime_request.dart';
import 'package:base_app/data/models/request/room_meeting/create_request_type_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/create_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/delete_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/update_room_meeting.dart';
import 'package:base_app/data/models/request/update_request_request.dart';
import 'package:base_app/data/models/request/upload_file.dart';
import 'package:base_app/data/models/request/upload_files.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/services/request.service.dart';
import 'package:common/model/response.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'base.service.dart';

@LazySingleton(as: RequestService)
class RequestServiceImpl extends BaseService implements RequestService {
  late String baseUrl;
  late String baseURLFile;
  late String baseUrlUser;

  RequestServiceImpl() : super() {
    baseUrl = appConfig.baseRequestUrl;
    baseURLFile = appConfig.baseURLFile;
    baseUrlUser = appConfig.baseUserUrl;
  }

  @override
  Future<int> createRequest(CreateRequestRequest createRequestRequest) async {
    final url = '$baseUrl${PathConfig.request}';
    final body = jsonEncode(createRequestRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.statusCode;
    return data;
  }

  @override
  Future<int> createOvertimeRequest(
      CreateOverTimeRequest createOverTimeRequest) async {
    final url = '$baseUrl${PathConfig.request}';
    final body = jsonEncode(createOverTimeRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.statusCode;
    return data;
  }

  @override
  Future<int> createOnLeave(CreateOnLeaveRequest createOnLeaveRequest) async {
    final url = '$baseUrl${PathConfig.request}';
    final body = jsonEncode(createOnLeaveRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.statusCode;
    return data;
  }

  @override
  Future<int> createExplanation(
      CreateExplanationRequest createExplanationRequest) async {
    final url = '$baseUrl${PathConfig.request}';
    final body = jsonEncode(createExplanationRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.statusCode;
    return data;
  }

  @override
  Future<int> getRequest(GetRequestRequest getRequestRequest) async {
    return 0;
  }

  @override
  Future<Request> getRequestById(
      GetRequestRequestById getRequestRequestById) async {
    final url = '$baseUrl${PathConfig.request}/${getRequestRequestById.id}';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    Request request = Request.fromJson(data);
    return request;
  }

  @override
  Future<String> uploadFile({UploadFileRequest? uploadFileRequest}) async {
    bool isFile = uploadFileRequest!.originFile!.path.endsWith('png') ||
        uploadFileRequest.originFile!.path.endsWith('jpg');
    String sendFileType = isFile ? 'HRM' : 'HRM';
    final url = '$baseURLFile${PathConfig.file}/$sendFileType';
    String filename = uploadFileRequest.originFile!.path.split('/').last;
    final response = await client.postUploadFile(url,
        fileType: 'image/${uploadFileRequest.originFile!.path.split('.').last}',
        uploadFileBytes: kIsWeb
            ? uploadFileRequest.imageData!
            : uploadFileRequest.originFile!.readAsBytesSync(),
        fileName: filename);
    final responseBase = ResponseBase.fromJson(json.decode(response));
    return responseBase.result as String;
  }

  @override
  Future<List<String>> uploadFiles(
      {UploadFilesRequest? uploadFileRequests}) async {
    /* final List<bool> isFile = [
      ...uploadFileRequests!.originFiles!
          .map((e) => e.path.endsWith('png') || e.path.endsWith('jpg'))
    ];
    final List<String> sendFileType = [
      ...isFile.map(
        (e) => e ? 'Images' : 'Files',
      )
    ];
    final url = '$baseURLFile${PathConfig.files}/Files';
    final List<String> filenames = [
      ...uploadFileRequests.originFiles!.map(
        (e) => e.path.split('/').last,
      )
    ];
    final response = await client.postUploadFiles(url,
        fileTypes: uploadFileRequests.originFiles!
            .map(
              (e) => '/${e.path.split('.').last}',
            )
            .toList(),
        uploadFileBytes: uploadFileRequests.originFiles!
            .map(
              (e) => e.readAsBytesSync(),
            )
            .toList(),
        fileNames: filenames);
    final responseBase = ResponseBase.fromJson(json.decode(response));
    return responseBase.result as List<String>;*/
    return [];
  }

  @override
  Future<Request> upDateRequestById(
      {required UpdateRequestRequest updateRequestRequest,
      required String id}) async {
    final url = '$baseUrl${PathConfig.request}/$id';
    final body = jsonEncode(updateRequestRequest.toJson());
    final response = await client.put(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    Request request = Request.fromJson(data);
    return request;
  }

  @override
  Future<List<Request>> getRequestByAdmin(
      GetRequestByAdminRequest getRequestByAdminRequest) async {
    final url = '$baseUrl${PathConfig.getRequestByAdmin}';
    final params = getRequestByAdminRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    List<Request> requests = (data as List<dynamic>)
        .map((e) => Request.fromJson(e as Map<String, dynamic>))
        .toList();
    return requests;
  }

  @override
  Future<int> changeListStatus(
      {required ChangeListStatusRequest changeListStatusRequest}) async {
    if (changeListStatusRequest.enumRequestType == 'RoomMeeting') {
      final url = '$baseUrl${PathConfig.updateStatusTypeRoomMeeting}';
      final body = jsonEncode(changeListStatusRequest.toJson());
      final response = await client.put(url, body: body);
      final responseBase = ResponseBase.fromJson(json.decode(response.body));
      final data = responseBase.statusCode;
      return data;
    } else {
      final url = '$baseUrl${PathConfig.changeListStatus}';
      final body = jsonEncode(changeListStatusRequest.toJson());
      final response = await client.put(url, body: body);
      final responseBase = ResponseBase.fromJson(json.decode(response.body));
      final data = responseBase.statusCode;
      return data;
    }
  }

  @override
  Future<int> createRoomMeeting(
      {required CreateRoomMeetingRequest createRoomMeetingRequest}) async {
    final url = '$baseUrl${PathConfig.roomMeeting}';
    final body = jsonEncode(createRoomMeetingRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.statusCode;
    return data;
  }

  @override
  Future<List<RoomMeeting>> getRoomMeeting() async {
    final url = '$baseUrl${PathConfig.roomMeeting}';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    List<RoomMeeting> roomMeetings = (data as List<dynamic>)
        .map((e) => RoomMeeting.fromJson(e as Map<String, dynamic>))
        .toList();
    return roomMeetings;
  }

  @override
  Future<int> createRoomMeetingRequest(
      {required CreateRequestTypeRoomMeetingRequest
          createRequestTypeRoomMeetingRequest}) async {
    final url = '$baseUrl${PathConfig.createRequestTypeRoomMeeting}';
    final body = jsonEncode(createRequestTypeRoomMeetingRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.statusCode;
    return data;
  }

  @override
  Future<List<User>> getListUserByRequest(
      {required GetListUserByRequestExplanationRequest
          getListUserByRequestExplanationRequest}) async {
    final url = '$baseUrlUser${PathConfig.getListUserByRequestExplanation}';
    final params = getListUserByRequestExplanationRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result['items'];
    List<User> users = (data as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
    return users;
  }

  @override
  Future<int> updateRoomMeeting(
      {required UpdateRoomMeetingRequest updateRoomMeetingRequest}) async {
    final url = '$baseUrl${PathConfig.roomMeeting}';
    final body = jsonEncode(updateRoomMeetingRequest.toJson());
    final response = await client.put(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.statusCode;
    return data;
  }

  @override
  Future<int> deleteRoomMeeting(
      {required DeleteRoomMeetingRequest deleteRoomMeetingRequest}) async {
    final url =
        '$baseUrl${PathConfig.roomMeeting}/${deleteRoomMeetingRequest.id}';
    final response = await client.delete(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.statusCode;
    return data;
  }
}
