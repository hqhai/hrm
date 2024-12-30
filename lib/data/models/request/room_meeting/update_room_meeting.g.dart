// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_room_meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateRoomMeetingRequest _$UpdateRoomMeetingRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateRoomMeetingRequest(
      roomName: json['roomName'] as String?,
      numberOfSeats: (json['numberOfSeats'] as num?)?.toInt(),
      address: json['address'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UpdateRoomMeetingRequestToJson(
    UpdateRoomMeetingRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('roomName', instance.roomName);
  writeNotNull('numberOfSeats', instance.numberOfSeats);
  writeNotNull('address', instance.address);
  writeNotNull('description', instance.description);
  writeNotNull('id', instance.id);
  return val;
}
