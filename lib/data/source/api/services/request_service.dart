import 'dart:io';

import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/base/data_response.dart';
import 'package:base_app/data/models/create_request/create_request_request.dart';
import 'package:base_app/data/models/request/change_list_status/change_list_status_request.dart';
import 'package:base_app/data/models/request/explanation/create_explanation_request.dart';
import 'package:base_app/data/models/request/explanation/get_list_user_by_request_explanation.dart';
import 'package:base_app/data/models/request/get_request/get_by_admin/get_request_by_admin.dart';
import 'package:base_app/data/models/request/get_request/get_by_id/get_request_by_id.dart';
import 'package:base_app/data/models/request/get_request/get_request.dart';
import 'package:base_app/data/models/request/on_leave/create_onleave_request.dart';
import 'package:base_app/data/models/request/overtime/create_overtime_request.dart';
import 'package:base_app/data/models/request/room_meeting/create_request_type_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/create_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/delete_room_meeting.dart';
import 'package:base_app/data/models/request/room_meeting/update_room_meeting.dart';
import 'package:base_app/data/models/request/update_request_request.dart';
import 'package:base_app/data/models/request/upload_file.dart';
import 'package:base_app/data/models/request/upload_files.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/client/request_api_client.dart';
import 'package:base_app/data/source/api/client/url_file_api_client.dart';
import 'package:base_app/data/source/api/client/user_api_client.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class RequestService {
  final RequestApiClient _requestUrlApiClient;
  final UserApiClient _userApiClient;
  final UrlFileApiClient _urlFileApiClient;

  RequestService(this._requestUrlApiClient, this._userApiClient, this._urlFileApiClient);

  Future<DataResponse?> createRequest(CreateRequestRequest createRequestRequest) async {
    return _requestUrlApiClient.request(
      method: RestMethod.post,
      path: PathConfig.request,
      body: createRequestRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> createOvertimeRequest(CreateOverTimeRequest createOverTimeRequest) async {
    return _requestUrlApiClient.request(
      method: RestMethod.post,
      path: PathConfig.request,
      body: createOverTimeRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> createOnLeave(CreateOnLeaveRequest createOnLeaveRequest) async {
    return _requestUrlApiClient.request(
      method: RestMethod.post,
      path: PathConfig.request,
      body: createOnLeaveRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> createExplanation(CreateExplanationRequest createExplanationRequest) async {
    return _requestUrlApiClient.request(
      method: RestMethod.post,
      path: PathConfig.request,
      queryParameters: createExplanationRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<int> getRequest(GetRequestRequest getRequestRequest) async {
    return 0;
  }

  Future<DataResponse<Request>?> getRequestById(GetRequestRequestById getRequestRequestById) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: PathConfig.request,
      queryParameters: getRequestRequestById.toJson(),
      decoder: (json) => Request.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<Request>?> upDateRequestById({required UpdateRequestRequest updateRequestRequest, required String id}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.put,
      path: '${PathConfig.request}/$id',
      body: updateRequestRequest.toJson(),
      decoder: (json) => Request.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<Request>?> getRequestByAdmin(GetRequestByAdminRequest getRequestByAdminRequest) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: PathConfig.getRequestByAdmin,
      queryParameters: getRequestByAdminRequest.toJson(),
      decoder: (json) => Request.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> changeListStatus({required ChangeListStatusRequest changeListStatusRequest}) async {
    if (changeListStatusRequest.enumRequestType == 'RoomMeeting') {
      return _requestUrlApiClient.request(
        method: RestMethod.put,
        path: PathConfig.updateStatusTypeRoomMeeting,
        body: changeListStatusRequest.toJson(),
        successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
      );
    } else {
      return _requestUrlApiClient.request(
        method: RestMethod.put,
        path: PathConfig.changeListStatus,
        body: changeListStatusRequest.toJson(),
        successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
      );
    }
  }

  Future<DataResponse?> createRoomMeeting({required CreateRoomMeetingRequest createRoomMeetingRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.post,
      path: PathConfig.roomMeeting,
      body: createRoomMeetingRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<RoomMeeting>?> getRoomMeeting() async {
    return _requestUrlApiClient.request(
      path: PathConfig.roomMeeting,
      method: RestMethod.get,
      decoder: (json) => RoomMeeting.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> createRoomMeetingRequest({required CreateRequestTypeRoomMeetingRequest createRequestTypeRoomMeetingRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.post,
      path: PathConfig.createRequestTypeRoomMeeting,
      body: createRequestTypeRoomMeetingRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> updateRoomMeeting({required UpdateRoomMeetingRequest updateRoomMeetingRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.put,
      path: PathConfig.roomMeeting,
      body: updateRoomMeetingRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> deleteRoomMeeting({required DeleteRoomMeetingRequest deleteRoomMeetingRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.post,
      path: PathConfig.roomMeeting,
      queryParameters: deleteRoomMeetingRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

// base url user

  // result->items
  Future<DataListRecordPagingResponse<User>?> getListUserByRequest({required GetListUserByRequestExplanationRequest getListUserByRequestExplanationRequest}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.getListUserByRequestExplanation,
      queryParameters: getListUserByRequestExplanationRequest.toJson(),
      decoder: (json) => User.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  // base url file
  Future<DataResponse<String>?> uploadFile({UploadFileRequest? uploadFileRequest}) async {

    final data = FormData();
    final originFile = uploadFileRequest?.originFile;
    final imageData = uploadFileRequest?.imageData;
    if (originFile != null) {
      final fileName = originFile.path.split(Platform.pathSeparator).last;
      final fileExtension = fileName.split('.').last.toLowerCase();
      if (fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'jpeg') {
        data.files.add(MapEntry(
          'file',
          MultipartFile.fromFileSync(
            originFile.path,
            filename: originFile.path.split(Platform.pathSeparator).last,
            contentType: MediaType.parse('image/png'),
          ),
        ));
      }
    } else if (imageData != null) {
      data.files.add(MapEntry(
        'image',
        MultipartFile.fromBytes(
          imageData,
          filename: 'image.png',
          contentType: MediaType('image', 'png'),
        ),
      ));
    }

    return _urlFileApiClient.request(
      method: RestMethod.post,
      path: '${PathConfig.file}/HRM',
      body: data,
      options: Options(
        contentType: 'multipart/form-data',
      ),
      decoder: (json) => json as String,
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListRecordPagingResponse<String>?> uploadFiles({UploadFilesRequest? uploadFileRequests}) async {
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
    return null;
  }
}
