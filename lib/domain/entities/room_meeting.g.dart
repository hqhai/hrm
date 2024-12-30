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

Map<String, dynamic> _$RoomMeetingToJson(RoomMeeting instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'createdUserId': instance.createdUserId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updatedUserId', instance.updatedUserId);
  writeNotNull('createdFullName', instance.createdFullName);
  writeNotNull('updatedFullName', instance.updatedFullName);
  writeNotNull('createdDate', instance.createdDate);
  writeNotNull('updatedDate', instance.updatedDate);
  writeNotNull('roomName', instance.roomName);
  writeNotNull('numberOfSeats', instance.numberOfSeats);
  writeNotNull('address', instance.address);
  writeNotNull('description', instance.description);
  writeNotNull('isApproval', instance.isApproval);
  val['requestRoomMeeting'] = instance.requestRoomMeeting;
  return val;
}
