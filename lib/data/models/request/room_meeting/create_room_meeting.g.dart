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
        CreateRoomMeetingRequest instance) =>
    <String, dynamic>{
      if (instance.roomName case final value?) 'roomName': value,
      if (instance.numberOfSeats case final value?) 'numberOfSeats': value,
      if (instance.address case final value?) 'address': value,
      if (instance.description case final value?) 'description': value,
      if (instance.isApproval case final value?) 'isApproval': value,
    };
