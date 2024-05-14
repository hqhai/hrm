import 'package:json_annotation/json_annotation.dart';

part 'create_request_type_room_meeting_config.g.dart';

@JsonSerializable()
class CreateRequestTypeRoomMeetingConfigRequest {
  final String roomMeetingId;
  final String meetingStartTime;
  final String meetingEndTime;


  const CreateRequestTypeRoomMeetingConfigRequest(
      {required this.roomMeetingId, this.meetingStartTime = '', this.meetingEndTime = '', });

  factory CreateRequestTypeRoomMeetingConfigRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestTypeRoomMeetingConfigRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRequestTypeRoomMeetingConfigRequestToJson(this);
}
