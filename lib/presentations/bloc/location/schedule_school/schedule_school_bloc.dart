import 'dart:async';

import 'package:base_app/common/exception/remote/remote_exception.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_event.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/use_cases/location_usecase.dart';

@lazySingleton
class ScheduleSchoolBloc extends HydratedBloc<ScheduleSchoolEvent, ScheduleSchoolState> {
  final LocationUseCase _locationUseCase;

  ScheduleSchoolBloc(this._locationUseCase) : super(const ScheduleSchoolState()) {
    on<GetScheduleSchoolEvent>(_getScheduleSchoolEvent);
    on<ResetScheduleSchoolEvent>(_resetScheduleSchoolEvent);
  }

  FutureOr<void> _getScheduleSchoolEvent(GetScheduleSchoolEvent event, Emitter<ScheduleSchoolState> emit) async {
    try {
      final scheduleSchool = await _locationUseCase.getScheduleSchool(workDate: event.dateTime);
      emit(state.copyWith(scheduleSchools: scheduleSchool));
      event.completer?.complete(true);
    } catch (e) {
      if (e is RemoteException) {
        final listErrorCode = e.serverError?.errors.map((e) => e).toList();
        if (listErrorCode != null && listErrorCode.isNotEmpty) {
          if (listErrorCode.contains('DataNotExist')) {
            emit(state.copyWith(errorMessage: listErrorCode.first));
            event.completer?.complete(false);
          } else {
            emit(state.copyWith(errorMessage: ''));
            event.completer?.complete(false);
          }
        }
      } else {
        event.completer?.complete(false);
      }
    }
  }

  @override
  ScheduleSchoolState? fromJson(Map<String, dynamic> json) {
    return ScheduleSchoolState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ScheduleSchoolState state) {
    return state.toJson();
  }

  FutureOr<void> _resetScheduleSchoolEvent(ResetScheduleSchoolEvent event, Emitter<ScheduleSchoolState> emit) {
    emit(const ScheduleSchoolState());
  }
}
