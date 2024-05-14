import 'package:json_annotation/json_annotation.dart';
part 'request_room_meeting.g.dart';

@JsonSerializable()
class RequestRoomMeeting {
  final String? meetingStartTime;
  final String? meetingEndTime;

  const RequestRoomMeeting({
    this.meetingStartTime = '',
    this.meetingEndTime = '',
  });

  factory RequestRoomMeeting.fromJson(Map<String, dynamic> json) => _$RequestRoomMeetingFromJson(json);
  Map<String, dynamic> toJson() => _$RequestRoomMeetingToJson(this);
}
