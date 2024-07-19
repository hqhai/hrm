import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/domain/use_cases/location.usecase.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WorkDayBloc extends Bloc<WorkDayEvent, WorkDayState> {
  final LocationUseCase _locationUseCase;

  WorkDayBloc()
      : _locationUseCase = dI<LocationUseCase>(),
        super(const WorkDayState()) {
    on<WorkDayEvent>((event, emit) {});
    on<GetWorkDaysEvent>(_getWorkDaysEvent);
  }

  FutureOr<void> _getWorkDaysEvent(GetWorkDaysEvent event, Emitter<WorkDayState> emit) async {
    try {
      final shiftsResponse =
          await _locationUseCase.getWorkDays(startDate: event.startDate, endDate: event.endDate);
      final List<WorkDay> workDays = shiftsResponse.items;
      final List<DateTime> workDayId = workDays.map((e) => e.date).toList();
      final Map<DateTime, WorkDay> mapWorkDays = Map.fromEntries(
        workDays.map(
          (item) => MapEntry(
            item.date,
            item,
          ),
        ),
      );
      emit(
        state.copyWith(workDays: mapWorkDays, workDayIds: workDayId),
      );
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }
}
