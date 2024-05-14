import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/room_meeting.dart';
import 'package:base_app/domain/use_cases/request_usecase.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_event.dart';
import 'package:base_app/presentations/bloc/request/room_meeting/room_meeting_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RoomMeetingBloc extends Bloc<RoomMeetingEvent, RoomMeetingState> {
  final RequestUseCase _requestUseCase;

  RoomMeetingBloc()
      : _requestUseCase = dI<RequestUseCase>(),
        super(const RoomMeetingState()) {
    on<RoomMeetingEvent>((event, emit) {});
    on<CreateRoomMeetingEvent>(_createRoomMeetingEvent);
    on<GetRoomMeetingEvent>(_getRoomMeetingEvent);
    on<DeleteRoomMeetingEvent>(_deleteRoomMeetingEvent);
    on<UpdateRoomMeetingEvent>(_updateRoomMeetingEvent);
  }

  FutureOr<void> _createRoomMeetingEvent(
      CreateRoomMeetingEvent event, Emitter<RoomMeetingState> emit) async {
    emit(state.copyWith(status: RequestStatus.roomMeetingInit));
    try {
      await _requestUseCase.createRoomMeeting(
        roomName: event.roomName,
        numberOfSeats: event.numberOfSeats,
        address: event.address,
        description: event.description,
        isApproval: event.isApproval,
      );
      emit(state.copyWith(status: RequestStatus.createRoomMeetingSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.roomMeetingError));
    }
  }

  FutureOr<void> _getRoomMeetingEvent(
      GetRoomMeetingEvent event, Emitter<RoomMeetingState> emit) async {
    emit(state.copyWith(status: RequestStatus.roomMeetingInit));
    try {
      List<RoomMeeting> roomMeetings = await _requestUseCase.getRoomMeeting();
      emit(state.copyWith(roomMeetings: roomMeetings, status: RequestStatus.roomMeetingSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.roomMeetingError));
    }
  }

  FutureOr<void> _deleteRoomMeetingEvent(
      DeleteRoomMeetingEvent event, Emitter<RoomMeetingState> emit) async {
    emit(state.copyWith(status: RequestStatus.roomMeetingInit));
    try {
      await _requestUseCase.deleteRoomMeeting(id: event.id);
      emit(state.copyWith(status: RequestStatus.deleteRoomMeetingSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.roomMeetingError));
    }
  }

  FutureOr<void> _updateRoomMeetingEvent(
      UpdateRoomMeetingEvent event, Emitter<RoomMeetingState> emit) async {
    emit(state.copyWith(status: RequestStatus.roomMeetingInit));
    try {
      await _requestUseCase.updateRoomMeeting(
          roomName: event.roomName,
          numberOfSeats: event.numberOfSeats,
          address: event.address,
          description: event.description,
          id: event.id);
      emit(state.copyWith(status: RequestStatus.updateRoomMeetingSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.roomMeetingError));
    }
  }
}
