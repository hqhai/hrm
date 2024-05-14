// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_room_meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestRoomMeeting _$RequestRoomMeetingFromJson(Map<String, dynamic> json) =>
    RequestRoomMeeting(
      meetingStartTime: json['meetingStartTime'] as String? ?? '',
      meetingEndTime: json['meetingEndTime'] as String? ?? '',
    );

Map<String, dynamic> _$RequestRoomMeetingToJson(RequestRoomMeeting instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('meetingStartTime', instance.meetingStartTime);
  writeNotNull('meetingEndTime', instance.meetingEndTime);
  return val;
}
