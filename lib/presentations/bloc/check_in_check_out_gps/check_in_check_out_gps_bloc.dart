import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/timekeeping_status.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/use_cases/location.usecase.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_event.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckInCheckOutGpsBloc extends Bloc<CheckInCheckOutGpsEvent, CheckInCheckOutGpsState> {
  final LocationUseCase locationUseCase;

  CheckInCheckOutGpsBloc()
      : locationUseCase = dI<LocationUseCase>(),
        super(const CheckInCheckOutGpsState()) {
    on<CheckInCheckOutGpsEvent>((event, emit) {});
    on<PostTimekeepingGPSRequestEvent>(_postTimekeepingGPSRequestEvent);
  }

  FutureOr<void> _postTimekeepingGPSRequestEvent(
      PostTimekeepingGPSRequestEvent event, Emitter<CheckInCheckOutGpsState> emit) async {
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
      e as ResponseBase;
      final listErrorCode = e.errorMessages.map((e) => e.errorCode).toList();
      if (listErrorCode.contains("DistanceNotEnough")) {
        emit(state.copyWith(
            status: TimekeepingStatus.distanceNotEnough, errorCode: "DistanceNotEnough"));
        event.completer.complete(TimekeepingStatus.distanceNotEnough);
      } else {
        emit(state.copyWith(errorCode: '', status: TimekeepingStatus.fail));
        event.completer.complete(TimekeepingStatus.fail);
      }
    }
  }
}
