// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomMeeting _$RoomMeetingFromJson(Map<String, dynamic> json) => RoomMeeting(
      id: json['id'] as String,
      createdUserId: json['createdUserId'] as String,
      updatedUserId: json['updatedUserId'] as String?,
      createdFullName: json['createdFullName'] as String?,
      updatedFullName: json['updatedFullName'] as String?,
      createdDate: json['createdDate'] as String?,
      updatedDate: json['updatedDate'] as String?,
      roomName: json['roomName'] as String?,
      numberOfSeats: (json['numberOfSeats'] as num?)?.toInt(),
      address: json['address'] as String?,
      description: json['description'] as String?,
      isApproval: json['isApproval'] as bool?,
      requestRoomMeeting: (json['requestRoomMeeting'] as List<dynamic>?)
              ?.map(
                  (e) => RequestRoomMeeting.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RoomMeetingToJson(RoomMeeting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdUserId': instance.createdUserId,
      if (instance.updatedUserId case final value?) 'updatedUserId': value,
      if (instance.createdFullName case final value?) 'createdFullName': value,
      if (instance.updatedFullName case final value?) 'updatedFullName': value,
      if (instance.createdDate case final value?) 'createdDate': value,
      if (instance.updatedDate case final value?) 'updatedDate': value,
      if (instance.roomName case final value?) 'roomName': value,
      if (instance.numberOfSeats case final value?) 'numberOfSeats': value,
      if (instance.address case final value?) 'address': value,
      if (instance.description case final value?) 'description': value,
      if (instance.isApproval case final value?) 'isApproval': value,
      'requestRoomMeeting': instance.requestRoomMeeting,
    };
