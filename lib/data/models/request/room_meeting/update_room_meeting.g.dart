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
        UpdateRoomMeetingRequest instance) =>
    <String, dynamic>{
      if (instance.roomName case final value?) 'roomName': value,
      if (instance.numberOfSeats case final value?) 'numberOfSeats': value,
      if (instance.address case final value?) 'address': value,
      if (instance.description case final value?) 'description': value,
      if (instance.id case final value?) 'id': value,
    };
