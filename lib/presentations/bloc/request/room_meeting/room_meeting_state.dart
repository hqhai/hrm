import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'room_meeting_state.g.dart';

@CopyWith()
class RoomMeetingState extends Equatable {
  final RequestStatus status;
  final List<RoomMeeting> roomMeetings;
  const RoomMeetingState({this.roomMeetings = const [], this.status = RequestStatus.init,});

  @override
  List<Object> get props => [roomMeetings, status];
}
