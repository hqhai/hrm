import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/domain/use_cases/location.usecase.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WorkDayBloc extends Bloc<WorkDayEvent, WorkDayState> {
  final LocationUseCase _locationUseCase;

  WorkDayBloc()
      : _locationUseCase = dI<LocationUseCase>(),
        super(const WorkDayState()) {
    on<WorkDayEvent>((event, emit) {});
    on<GetWorkDaysEvent>(_getWorkDaysEvent);
    on<ChangeSelectDate>(_changeSelectDate);
    on<RegisterWorkDay>(_registerWorkDay);
    on<CancelRegisterWorkDay>(_cancelRegisterWorkDay);
    on<ChangeLoading>(_changeLoading);
    on<GetWorkDayAdmin>(_getWorkDayAdmin);
    on<GetElectiveShift>(_getElectiveShift);
    on<GetElectiveShiftDetail>(_getElectiveShiftDetail);
    on<RegisterWorkDayAdmin>(_registerAdmin);
    on<CancelRegisterWorkDayAdmin>(_cancelRegisterAdmin);
    on<GetWorkDayByUser>(_getWorkDayByUser);
  }

  FutureOr<void> _getWorkDaysEvent(
      GetWorkDaysEvent event, Emitter<WorkDayState> emit) async {
    try {
      final shiftsResponse = await _locationUseCase.getWorkDays(
          startDate: event.startDate, endDate: event.endDate);
      final List<WorkDay> workDays = shiftsResponse.items;
      final List<DateTime> workDayId =
          workDays.map((e) => id(e.workDate ?? DateTime.now())).toList();
      final Map<DateTime, WorkDay> mapWorkDays = Map.fromEntries(
        workDays.map(
          (item) => MapEntry(
            id(item.workDate ?? DateTime.now()),
            item,
          ),
        ),
      );
      emit(state.copyWith(workDays: mapWorkDays, workDayIds: workDayId));
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  DateTime id(DateTime time) {
    return DateTime(time.year, time.month, time.day);
  }

  FutureOr<void> _changeSelectDate(
      ChangeSelectDate event, Emitter<WorkDayState> emit) {
    emit(state.copyWith(selectDate: event.date));
  }

  FutureOr<void> _registerWorkDay(
      RegisterWorkDay event, Emitter<WorkDayState> emit) async {
    final data = await _locationUseCase.registerWorkDays(
        request: WorkDaysRequest(workShiftRequestList: event.request));

    event.completer.complete(data);
  }

  Future<FutureOr<void>> _cancelRegisterWorkDay(
      CancelRegisterWorkDay event, Emitter<WorkDayState> emit) async {
    try {
      await _locationUseCase.cancelRegisterWorkDays(request: event.data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  FutureOr<void> _changeLoading(
      ChangeLoading event, Emitter<WorkDayState> emit) {
    emit(state.copyWith(isLoading: event.status));
  }

  FutureOr<void> _getWorkDayAdmin(
      GetWorkDayAdmin event, Emitter<WorkDayState> emit) async {
    final data = await _locationUseCase.getWorkDaysAdmin(request: event.data);
    emit(state.copyWith(items: data.items, pagingInfo: data.pagingInfo));
  }

  Future<FutureOr<void>> _getElectiveShift(
      GetElectiveShift event, Emitter<WorkDayState> emit) async {
    final data =
        await _locationUseCase.workDayGetElectiveShift(request: event.data);
    emit(state.copyWith(
        electiveShiftItems: data.items,
        electiveShiftPagingInfo: data.pagingInfo));
  }

  FutureOr<void> _getElectiveShiftDetail(
      GetElectiveShiftDetail event, Emitter<WorkDayState> emit) async {
    final data =
        await _locationUseCase.getElectiveShiftDetail(request: event.data);
    emit(state.copyWith(
        itemsDetail: data.items, pagingInfoDetail: data.pagingInfo));
  }

  FutureOr<void> _registerAdmin(
      RegisterWorkDayAdmin event, Emitter<WorkDayState> emit) async {
    try {
      final isCheck = await _locationUseCase.addApprove(request: event.request);
      event.completer.complete(isCheck);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<FutureOr<void>> _cancelRegisterAdmin(
      CancelRegisterWorkDayAdmin event, Emitter<WorkDayState> emit) async {
    try {
      final check = await _locationUseCase.cancelWorkDay(request: event.data);
      event.completer.complete(check);
    } catch (e) {
      if (kDebugMode) {
        print("e");
      }
      event.completer.complete(false);
    }
  }

  Future<FutureOr<void>> _getWorkDayByUser(
      GetWorkDayByUser event, Emitter<WorkDayState> emit) async {
    final data = await _locationUseCase.getWorkShiftRequestByUser();
    emit(state.copyWith(items: data.items));
    event.completer.complete(data.items.isNotEmpty);
  }
}
