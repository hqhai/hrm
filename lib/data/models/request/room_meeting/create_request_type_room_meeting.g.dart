// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_request_type_room_meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRequestTypeRoomMeetingRequest
    _$CreateRequestTypeRoomMeetingRequestFromJson(Map<String, dynamic> json) =>
        CreateRequestTypeRoomMeetingRequest(
          type: json['type'] as String,
          title: json['title'] as String?,
          content: json['content'] as String?,
          config: json['config'] == null
              ? const CreateRequestTypeRoomMeetingConfigRequest(
                  roomMeetingId: '')
              : CreateRequestTypeRoomMeetingConfigRequest.fromJson(
                  json['config'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$CreateRequestTypeRoomMeetingRequestToJson(
        CreateRequestTypeRoomMeetingRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      if (instance.title case final value?) 'title': value,
      if (instance.content case final value?) 'content': value,
      'config': instance.config,
    };
