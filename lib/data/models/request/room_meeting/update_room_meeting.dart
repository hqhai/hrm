import 'package:json_annotation/json_annotation.dart';

part 'update_room_meeting.g.dart';

@JsonSerializable()
class UpdateRoomMeetingRequest {
  final String? roomName;
  final int? numberOfSeats;
  final String? address;
  final String? description;
  final String? id;

  const UpdateRoomMeetingRequest(
      {this.roomName, this.numberOfSeats, this.address, this.description, this.id});

  factory UpdateRoomMeetingRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateRoomMeetingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRoomMeetingRequestToJson(this);
}
