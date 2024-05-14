import 'package:base_app/data/models/request/room_meeting/create_request_type_room_meeting_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_request_type_room_meeting.g.dart';

@JsonSerializable()
class CreateRequestTypeRoomMeetingRequest {
  final String type;
  final String? title;
  final String? content;
  final CreateRequestTypeRoomMeetingConfigRequest config;

  const CreateRequestTypeRoomMeetingRequest(
      {required this.type,
      this.title,
      this.content,
      this.config = const CreateRequestTypeRoomMeetingConfigRequest(roomMeetingId: '')});

  factory CreateRequestTypeRoomMeetingRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestTypeRoomMeetingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRequestTypeRoomMeetingRequestToJson(this);
}
