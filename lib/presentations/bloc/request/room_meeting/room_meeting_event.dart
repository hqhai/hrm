import 'package:equatable/equatable.dart';

abstract class RoomMeetingEvent extends Equatable {
  const RoomMeetingEvent();
}

class CreateRoomMeetingEvent extends RoomMeetingEvent {
  final String roomName;
  final int numberOfSeats;
  final String address;
  final String description;
  final bool isApproval;

  const CreateRoomMeetingEvent(
      this.roomName, this.numberOfSeats, this.address, this.description, this.isApproval);

  @override
  List<Object> get props => [roomName, numberOfSeats, address, description, isApproval];
}

class GetRoomMeetingEvent extends RoomMeetingEvent {
  const GetRoomMeetingEvent();

  @override
  List<Object> get props => [];
}

class UpdateRoomMeetingEvent extends RoomMeetingEvent {
  final String roomName;
  final int numberOfSeats;
  final String address;
  final String description;
  final String id;

  const UpdateRoomMeetingEvent(
      this.roomName, this.numberOfSeats, this.address, this.description, this.id);

  @override
  List<Object> get props => [roomName, numberOfSeats, address, description, id];
}

class DeleteRoomMeetingEvent extends RoomMeetingEvent {
  final String id;

  const DeleteRoomMeetingEvent(this.id);

  @override
  List<Object> get props => [id];
}
