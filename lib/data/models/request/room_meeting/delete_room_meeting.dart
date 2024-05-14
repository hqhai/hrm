import 'package:json_annotation/json_annotation.dart';

part 'delete_room_meeting.g.dart';

@JsonSerializable()
class DeleteRoomMeetingRequest {
  final String? id;

  const DeleteRoomMeetingRequest(
      {this.id});

  factory DeleteRoomMeetingRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteRoomMeetingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteRoomMeetingRequestToJson(this);
}
