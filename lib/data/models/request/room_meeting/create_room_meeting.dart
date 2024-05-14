import 'package:json_annotation/json_annotation.dart';

part 'create_room_meeting.g.dart';

@JsonSerializable()
class CreateRoomMeetingRequest {
  final String? roomName;
  final int? numberOfSeats;
  final String? address;
  final String? description;
  final bool? isApproval;

  const CreateRoomMeetingRequest(
      {this.roomName, this.numberOfSeats, this.address, this.description, this.isApproval});

  factory CreateRoomMeetingRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRoomMeetingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRoomMeetingRequestToJson(this);
}
