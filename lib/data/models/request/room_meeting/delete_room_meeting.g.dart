// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_room_meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteRoomMeetingRequest _$DeleteRoomMeetingRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteRoomMeetingRequest(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$DeleteRoomMeetingRequestToJson(
    DeleteRoomMeetingRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}
