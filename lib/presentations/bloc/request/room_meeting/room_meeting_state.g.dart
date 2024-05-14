// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_meeting_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RoomMeetingStateCWProxy {
  RoomMeetingState roomMeetings(List<RoomMeeting> roomMeetings);

  RoomMeetingState status(RequestStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RoomMeetingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RoomMeetingState(...).copyWith(id: 12, name: "My name")
  /// ````
  RoomMeetingState call({
    List<RoomMeeting>? roomMeetings,
    RequestStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRoomMeetingState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRoomMeetingState.copyWith.fieldName(...)`
class _$RoomMeetingStateCWProxyImpl implements _$RoomMeetingStateCWProxy {
  final RoomMeetingState _value;

  const _$RoomMeetingStateCWProxyImpl(this._value);

  @override
  RoomMeetingState roomMeetings(List<RoomMeeting> roomMeetings) =>
      this(roomMeetings: roomMeetings);

  @override
  RoomMeetingState status(RequestStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RoomMeetingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RoomMeetingState(...).copyWith(id: 12, name: "My name")
  /// ````
  RoomMeetingState call({
    Object? roomMeetings = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return RoomMeetingState(
      roomMeetings:
          roomMeetings == const $CopyWithPlaceholder() || roomMeetings == null
              ? _value.roomMeetings
              // ignore: cast_nullable_to_non_nullable
              : roomMeetings as List<RoomMeeting>,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as RequestStatus,
    );
  }
}

extension $RoomMeetingStateCopyWith on RoomMeetingState {
  /// Returns a callable class that can be used as follows: `instanceOfRoomMeetingState.copyWith(...)` or like so:`instanceOfRoomMeetingState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RoomMeetingStateCWProxy get copyWith => _$RoomMeetingStateCWProxyImpl(this);
}
