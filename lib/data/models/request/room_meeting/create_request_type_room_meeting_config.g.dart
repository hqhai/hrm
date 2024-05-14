// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_request_type_room_meeting_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRequestTypeRoomMeetingConfigRequest
    _$CreateRequestTypeRoomMeetingConfigRequestFromJson(
            Map<String, dynamic> json) =>
        CreateRequestTypeRoomMeetingConfigRequest(
          roomMeetingId: json['roomMeetingId'] as String,
          meetingStartTime: json['meetingStartTime'] as String? ?? '',
          meetingEndTime: json['meetingEndTime'] as String? ?? '',
        );

Map<String, dynamic> _$CreateRequestTypeRoomMeetingConfigRequestToJson(
        CreateRequestTypeRoomMeetingConfigRequest instance) =>
    <String, dynamic>{
      'roomMeetingId': instance.roomMeetingId,
      'meetingStartTime': instance.meetingStartTime,
      'meetingEndTime': instance.meetingEndTime,
    };
