import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/use_cases/work_and_salary.usecase.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_event.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LeaveHistoryBloc extends Bloc<LeaveHistoryEvent, LeaveHistoryState> {
  final WorkAndSalaryUseCase _workAndSalaryUseCase;

  LeaveHistoryBloc()
      : _workAndSalaryUseCase = dI<WorkAndSalaryUseCase>(),
        super(const LeaveHistoryState()) {
    on<LeaveHistoryEvent>((event, emit) {});
    on<GetLeaveHistoryEvent>(_getLeaveHistoryEvent);
  }

  FutureOr<void> _getLeaveHistoryEvent(
      GetLeaveHistoryEvent event, Emitter<LeaveHistoryState> emit) async {
    try {
      final userLeaveHistoryResponseMap = await _workAndSalaryUseCase.totalLeaveUserHistory(
        date: event.time,
        type: event.type,
        page: event.page,
      );
      final newListIds = userLeaveHistoryResponseMap.listIds;
      final newMapLeave = userLeaveHistoryResponseMap.items;
      final totalItems = userLeaveHistoryResponseMap.pagingInfo.totalItems;
      if (event.page != 1) {
        final listIds = [...state.listIds];
        final mapLeave = state.userLeaveHistory;
        listIds.addAll(newListIds);
        mapLeave.addAll(newMapLeave);
        emit(state.copyWith(listIds: listIds, userLeaveHistory: mapLeave, totalItems: totalItems));
      } else {
        emit(state.copyWith(
            listIds: newListIds, userLeaveHistory: newMapLeave, totalItems: totalItems));
      }
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }
}
