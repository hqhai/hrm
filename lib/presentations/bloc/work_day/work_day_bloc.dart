import 'dart:async';

import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/mixins/bloc_error_handler_mixin.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/location_usecase.dart';

@lazySingleton
class WorkDayBloc extends HydratedBloc<WorkDayEvent, WorkDayState>
    with BlocErrorHandlerMixin {
  final LocationUseCase _locationUseCase;

  WorkDayBloc(this._locationUseCase) : super(const WorkDayState()) {
    on<GetWorkDaysEvent>(_getWorkDaysEvent);
    on<ChangeSelectDate>(_changeSelectDate);
    on<RegisterWorkDay>(_registerWorkDay);
    on<RegisterDetailWorkDay>(_registerDetailWorkDay);
    on<CancelRegisterWorkDay>(_cancelRegisterWorkDay);
    on<ChangeLoading>(_changeLoading);
    on<GetWorkDayAdmin>(_getWorkDayAdmin);
    on<GetElectiveShift>(_getElectiveShift);
    on<GetElectiveShiftDetail>(_getElectiveShiftDetail);
    on<RegisterWorkDayAdmin>(_registerAdmin);
    on<CancelRegisterWorkDayAdmin>(_cancelRegisterAdmin);
    on<GetWorkDayByUser>(_getWorkDayByUser);
    on<ResetWorkDayEvent>(_resetWorkDayEvent);
    on<AddApprove>(_addApprove);
  }

  FutureOr<void> _getWorkDaysEvent(
      GetWorkDaysEvent event, Emitter<WorkDayState> emit) async {
    try {
      final shiftsResponse = await _locationUseCase.getWorkDays(
          startDate: event.startDate, endDate: event.endDate);
      final List<WorkDay> workDays = shiftsResponse.items;
      final List<DateTime> workDayId =
          workDays.map((e) => _id(e.workDate ?? DateTime.now())).toList();
      final Map<DateTime, WorkDay> mapWorkDays = Map.fromEntries(
        workDays.map(
          (item) => MapEntry(
            _id(item.workDate ?? DateTime.now()),
            item,
          ),
        ),
      );
      emit(state.copyWith(
          workDays: mapWorkDays, workDayIds: workDayId, errorCode: ''));
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _changeSelectDate(
      ChangeSelectDate event, Emitter<WorkDayState> emit) {
    emit(state.copyWith(selectDate: event.date));
  }

  FutureOr<void> _registerWorkDay(
      RegisterWorkDay event, Emitter<WorkDayState> emit) async {
    try {
      await _locationUseCase.registerWorkDays(
          request: WorkDaysRequest(workShiftRequestList: event.request));
      emit(state.copyWith(errorCode: ''));
      event.completer.complete(true);
    } catch (e) {
      final errorCode = extractErrorCode(e);
      emit(state.copyWith(errorCode: errorCode));
      event.completer.complete(false);
    }
  }

  Future<FutureOr<void>> _cancelRegisterWorkDay(
      CancelRegisterWorkDay event, Emitter<WorkDayState> emit) async {
    try {
      await _locationUseCase.cancelRegisterWorkDays(request: event.data);
      emit(state.copyWith(errorCode: ''));
      event.completer?.complete(true);
    } catch (e) {
      final errorCode = extractErrorCode(e);
      emit(state.copyWith(errorCode: errorCode));
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _changeLoading(
      ChangeLoading event, Emitter<WorkDayState> emit) {
    emit(state.copyWith(isLoading: event.status));
  }

  FutureOr<void> _getWorkDayAdmin(
      GetWorkDayAdmin event, Emitter<WorkDayState> emit) async {
    try {
      final data = await _locationUseCase.getWorkDaysAdmin(request: event.data);
      emit(state.copyWith(items: data.items, pagingInfo: data.pagingInfo));
      if (event.data.requestStatus == WorkShiftRequestStatus.pending) {
        emit(state.copyWith(
          errorCode: '',
          totalPending: data.pagingInfo.totalItems,
        ));
      } else if (event.data.requestStatus ==
          WorkShiftRequestStatus.pendingCancel) {
        emit(state.copyWith(
            totalPendingCancel: data.pagingInfo.totalItems, errorCode: ''));
      }
      event.completer?.complete(true);
    } catch (e) {
      final errorCode = extractErrorCode(e);
      emit(state.copyWith(errorCode: errorCode));
      event.completer?.complete(false);
    }
  }

  Future<FutureOr<void>> _getElectiveShift(
      GetElectiveShift event, Emitter<WorkDayState> emit) async {
    try {
      final data =
          await _locationUseCase.workDayGetElectiveShift(request: event.data);
      final electiveShiftItems = data.items
          .expand((element) => element.workShiftRegisteredDetails)
          .toList();
      emit(state.copyWith(
        errorCode: '',
        electiveShiftItems: electiveShiftItems,
        electiveShiftPagingInfo: data.pagingInfo,
      ));
      event.completer?.complete(true);
    } catch (e) {
      final errorCode = extractErrorCode(e);
      emit(state.copyWith(errorCode: errorCode));
      event.completer?.complete(false);
    }
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
      await _locationUseCase.addApprove(request: event.request);
      emit(state.copyWith(errorCode: ''));
      event.completer.complete(true);
    } catch (e) {
      final errorCode = extractErrorCode(e);
      emit(state.copyWith(errorCode: errorCode));
      event.completer.complete(false);
    }
  }

  Future<FutureOr<void>> _cancelRegisterAdmin(
      CancelRegisterWorkDayAdmin event, Emitter<WorkDayState> emit) async {
    try {
      await _locationUseCase.cancelWorkDay(request: event.data);
      emit(state.copyWith(errorCode: ''));
      event.completer.complete(true);
    } catch (e) {
      final errorCode = extractErrorCode(e);
      emit(state.copyWith(errorCode: errorCode));
      event.completer.complete(false);
    }
  }

  ///-----------------
  Future<FutureOr<void>> _getWorkDayByUser(
      GetWorkDayByUser event, Emitter<WorkDayState> emit) async {
    final data = await _locationUseCase.getWorkShiftRequestByUser(
      request: event.request,
    );
    emit(state.copyWith(items: data.items, errorCode: ''));
    event.completer.complete(data.items.isNotEmpty);
  }

  Future<FutureOr<void>> _registerDetailWorkDay(
      RegisterDetailWorkDay event, Emitter<WorkDayState> emit) async {
    final data =
        await _locationUseCase.registerDetailWorkDays(request: event.request);

    event.completer.complete(data);
  }

  @override
  WorkDayState? fromJson(Map<String, dynamic> json) {
    return WorkDayState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(WorkDayState state) {
    return state.toJson();
  }

  FutureOr<void> _resetWorkDayEvent(
      ResetWorkDayEvent event, Emitter<WorkDayState> emit) {
    emit(const WorkDayState());
  }

  FutureOr<void> _addApprove(
      AddApprove event, Emitter<WorkDayState> emit) async {
    try {
      await _locationUseCase.addApprove(request: event.request);
      emit(state.copyWith(errorCode: ''));
      event.completer?.complete(true);
    } catch (e) {
      final errorCode = extractErrorCode(e);
      emit(state.copyWith(errorCode: errorCode));
      event.completer?.complete(false);
    }
  }
}

DateTime _id(DateTime time) {
  return DateTime(time.year, time.month, time.day);
}
