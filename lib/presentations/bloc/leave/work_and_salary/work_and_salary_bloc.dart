import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';
import 'package:base_app/domain/use_cases/work_and_salary.usecase.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_event.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WorkAndSalaryBloc extends Bloc<WorkAndSalaryEvent, WorkAndSalaryState> {
  final WorkAndSalaryUseCase _workAndSalaryUseCase;

  WorkAndSalaryBloc()
      : _workAndSalaryUseCase = dI<WorkAndSalaryUseCase>(),
        super(const WorkAndSalaryState()) {
    on<WorkAndSalaryEvent>((event, emit) {});
    on<GetTotalLeaveDayEvent>(_getTotalLeaveDayEvent);
    on<GetTotalWorkdayEvent>(_getTotalWorkdayEvent);
    on<GetTotalLeaveTypeEvent>(_getTotalLeaveTypeEvent);
  }

  FutureOr<void> _getTotalLeaveDayEvent(
      GetTotalLeaveDayEvent event, Emitter<WorkAndSalaryState> emit) async {
    emit(state.copyWith(status: WorkAndSalaryStatusEnum.start));
    try {
      final UserLeave userLeave = await _workAndSalaryUseCase.totalLeaveDay();
      emit(state.copyWith(userLeave: userLeave, status: WorkAndSalaryStatusEnum.success));
      event.completer?.complete(true);
    } catch (e) {
      emit(state.copyWith(status: WorkAndSalaryStatusEnum.fail));
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _getTotalWorkdayEvent(
      GetTotalWorkdayEvent event, Emitter<WorkAndSalaryState> emit) async {
    emit(state.copyWith(status: WorkAndSalaryStatusEnum.start));
    try {
      final double totalWorkday = await _workAndSalaryUseCase.totalWorkday(
          startTime: event.startTime, endTime: event.endTime);
      emit(state.copyWith(
        totalWorkday: totalWorkday,
        status: WorkAndSalaryStatusEnum.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: WorkAndSalaryStatusEnum.fail));
    }
  }

  FutureOr<void> _getTotalLeaveTypeEvent(
      GetTotalLeaveTypeEvent event, Emitter<WorkAndSalaryState> emit) async {
    try {
      final totalLeaveType = await _workAndSalaryUseCase.totalLeaveType();
      final Map<EnumLeaveHistoryType, UserLeaveHistoryTypes> mapTotalLeaveType = Map.fromEntries(
        totalLeaveType.map(
          (item) => MapEntry(
            item.type,
            item,
          ),
        ),
      );
      emit(state.copyWith(
        mapLeaveType: mapTotalLeaveType,
      ));
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }
}
