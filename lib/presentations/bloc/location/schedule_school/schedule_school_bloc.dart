import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/use_cases/location.usecase.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_event.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ScheduleSchoolBloc extends Bloc<ScheduleSchoolEvent, ScheduleSchoolState> {
  final LocationUseCase _locationUseCase;

  ScheduleSchoolBloc()
      : _locationUseCase = dI<LocationUseCase>(),
        super(const ScheduleSchoolState()) {
    on<ScheduleSchoolEvent>((event, emit) {});
    on<GetScheduleSchoolEvent>(_getScheduleSchoolEvent);
  }

  FutureOr<void> _getScheduleSchoolEvent(
      GetScheduleSchoolEvent event, Emitter<ScheduleSchoolState> emit) async {
    try {
      final scheduleSchool = await _locationUseCase.getScheduleSchool(workDate: event.dateTime);
      emit(state.copyWith(scheduleSchools: scheduleSchool));
      event.completer?.complete(true);
    } catch (e) {
      if (e is ResponseBase) {
        final listErrorCode = e.errorMessages.map((e) => e.errorCode).toList();
        if (listErrorCode.contains('DataNotExist')) {
          event.completer?.complete(null);
        } else {
          event.completer?.complete(false);
        }
      } else {
        event.completer?.complete(false);
      }
    }
  }
}
