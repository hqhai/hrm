import 'package:base_app/domain/entities/request_room_meeting.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_meeting.g.dart';

@JsonSerializable()
class RoomMeeting {
  final String id;
  final String createdUserId;
  final String? updatedUserId;
  final String? createdFullName;
  final String? updatedFullName;
  final String? createdDate;
  final String? updatedDate;
  final String? roomName;
  final int? numberOfSeats;
  final String? address;
  final String? description;
  final bool? isApproval;
  final List<RequestRoomMeeting> requestRoomMeeting;

  const RoomMeeting({
    required this.id,
    required this.createdUserId,
    this.updatedUserId,
    this.createdFullName,
    this.updatedFullName,
    this.createdDate,
    this.updatedDate,
    this.roomName,
    this.numberOfSeats,
    this.address,
    this.description,
    this.isApproval,
    this.requestRoomMeeting = const [],
  });

  factory RoomMeeting.fromJson(Map<String, dynamic> json) => _$RoomMeetingFromJson(json);

  Map<String, dynamic> toJson() => _$RoomMeetingToJson(this);
}
