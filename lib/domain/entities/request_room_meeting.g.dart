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

Map<String, dynamic> _$RequestRoomMeetingToJson(RequestRoomMeeting instance) =>
    <String, dynamic>{
      if (instance.meetingStartTime case final value?)
        'meetingStartTime': value,
      if (instance.meetingEndTime case final value?) 'meetingEndTime': value,
    };
