// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_room_meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRoomMeetingRequest _$CreateRoomMeetingRequestFromJson(
        Map<String, dynamic> json) =>
    CreateRoomMeetingRequest(
      roomName: json['roomName'] as String?,
      numberOfSeats: (json['numberOfSeats'] as num?)?.toInt(),
      address: json['address'] as String?,
      description: json['description'] as String?,
      isApproval: json['isApproval'] as bool?,
    );

Map<String, dynamic> _$CreateRoomMeetingRequestToJson(
    CreateRoomMeetingRequest instance) {
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
  writeNotNull('isApproval', instance.isApproval);
  return val;
}
