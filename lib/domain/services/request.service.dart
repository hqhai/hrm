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
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:base_app/domain/entities/user.dart';

abstract class RequestService {
  Future<int> createRequest(CreateRequestRequest createRequestRequest);

  Future<int> createOvertimeRequest(CreateOverTimeRequest createOverTimeRequest);

  Future<int> createOnLeave(CreateOnLeaveRequest createOnLeaveRequest);

  Future<int> createExplanation(CreateExplanationRequest createExplanationRequest);

  Future<int> getRequest(
    GetRequestRequest getRequestRequest,
  );

  Future<List<Request>> getRequestByAdmin(
    GetRequestByAdminRequest getRequestByAdminRequest,
  );

  Future<Request> getRequestById(
    GetRequestRequestById getRequestRequestById,
  );

  Future<String> uploadFile({
    UploadFileRequest? uploadFileRequest,
  });

  Future<Request> upDateRequestById({required UpdateRequestRequest updateRequestRequest, required String id});

  Future<int> changeListStatus({required ChangeListStatusRequest changeListStatusRequest});

  Future<int> createRoomMeeting({required CreateRoomMeetingRequest createRoomMeetingRequest});

  Future<List<RoomMeeting>> getRoomMeeting();

  Future<int>createRoomMeetingRequest(
      {required CreateRequestTypeRoomMeetingRequest createRequestTypeRoomMeetingRequest});

  Future<List<User>> getListUserByRequest(
      {required GetListUserByRequestExplanationRequest getListUserByRequestExplanationRequest});

  Future<int> updateRoomMeeting({required UpdateRoomMeetingRequest updateRoomMeetingRequest});

  Future<int> deleteRoomMeeting({required DeleteRoomMeetingRequest deleteRoomMeetingRequest});
}
