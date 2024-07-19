import 'dart:async';

import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WorkDayBloc extends Bloc<WorkDayEvent, WorkDayState> {
  WorkDayBloc() : super(const WorkDayState()) {
    on<WorkDayEvent>((event, emit) {});
    on<GetWorkDaysEvent>(_getWorkDaysEvent);
  }

  FutureOr<void> _getWorkDaysEvent(GetWorkDaysEvent event, Emitter<WorkDayState> emit) {}
}
