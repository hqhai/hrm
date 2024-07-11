import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/use_cases/attendances_usecase.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_event.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WorkSheetBloc extends Bloc<WorkSheetEvent, WorkSheetState> {
  final AttendanceUseCase _attendanceUseCase;

  WorkSheetBloc()
      : _attendanceUseCase = dI<AttendanceUseCase>(),
        super(const WorkSheetState()) {
    on<WorkSheetEvent>((event, emit) {});
    on<GetWorkSheetEvent>(_getWorkSheetEvent);
  }

  FutureOr<void> _getWorkSheetEvent(GetWorkSheetEvent event, Emitter<WorkSheetState> emit) async {
    try {
      final workSheet = await _attendanceUseCase.getWorkSheet(time: event.time);
      emit(state.copyWith(workSheet: workSheet));
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }
}
