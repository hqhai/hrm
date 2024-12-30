import 'dart:async';

import 'package:base_app/common/enum/timekeeping_status.dart';
import 'package:base_app/common/exception/remote/remote_exception.dart';
import 'package:base_app/domain/use_cases/location_usecase.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_event.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckInCheckOutGpsBloc
    extends HydratedBloc<CheckInCheckOutGpsEvent, CheckInCheckOutGpsState> {
  final LocationUseCase locationUseCase;

  CheckInCheckOutGpsBloc(this.locationUseCase)
      : super(const CheckInCheckOutGpsState()) {
    on<CheckInCheckOutGpsEvent>((event, emit) {});
    on<PostTimekeepingGPSRequestEvent>(_postTimekeepingGPSRequestEvent);
    on<ResetCheckInCheckOutGpsEvent>(_resetCheckInCheckOutGpsEvent);
  }

  FutureOr<void> _postTimekeepingGPSRequestEvent(
      PostTimekeepingGPSRequestEvent event,
      Emitter<CheckInCheckOutGpsState> emit) async {
    emit(state.copyWith(status: TimekeepingStatus.start));
    try {
      final check = await locationUseCase.postCheckInGPS(
        longitude: event.longitude,
        latitude: event.latitude,
        scheduleSchoolId: event.scheduleSchoolId,
      );
      if (check.checkIn) {
        emit(state.copyWith(errorCode: '', status: TimekeepingStatus.success));
        event.completer.complete(TimekeepingStatus.success);
      } else {
        emit(state.copyWith(status: TimekeepingStatus.fail));
        event.completer.complete(TimekeepingStatus.fail);
      }
    } catch (e) {
      if (e is RemoteException) {
        final listErrorCode = e.serverError?.errors.map((e) => e).toList();
        if (listErrorCode != null && listErrorCode.isNotEmpty) {
          if (listErrorCode.contains("DistanceNotEnough")) {
            emit(state.copyWith(
                status: TimekeepingStatus.distanceNotEnough,
                errorCode: "DistanceNotEnough"));
            event.completer.complete(TimekeepingStatus.distanceNotEnough);
          } else {
            emit(state.copyWith(errorCode: '', status: TimekeepingStatus.fail));
            event.completer.complete(TimekeepingStatus.fail);
          }
        } else {
          emit(state.copyWith(errorCode: '', status: TimekeepingStatus.fail));
          event.completer.complete(TimekeepingStatus.fail);
        }
      } else {
        emit(state.copyWith(errorCode: '', status: TimekeepingStatus.fail));
        event.completer.complete(TimekeepingStatus.fail);
      }
    }
  }

  FutureOr<void> _resetCheckInCheckOutGpsEvent(
      ResetCheckInCheckOutGpsEvent event,
      Emitter<CheckInCheckOutGpsState> emit) {
    emit(const CheckInCheckOutGpsState());
  }

  @override
  CheckInCheckOutGpsState? fromJson(Map<String, dynamic> json) {
    return CheckInCheckOutGpsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CheckInCheckOutGpsState state) {
    return state.toJson();
  }
}
