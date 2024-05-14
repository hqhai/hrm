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
    CreateRequestTypeRoomMeetingRequest instance) {
  final val = <String, dynamic>{
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('content', instance.content);
  val['config'] = instance.config;
  return val;
}
