import 'dart:async';

import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/domain/use_cases/location_usecase.dart';
import 'package:base_app/presentations/bloc/shift/shift_event.dart';
import 'package:base_app/presentations/bloc/shift/shift_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ShiftBloc extends HydratedBloc<ShiftEvent, ShiftState> {
  final LocationUseCase _locationUseCase;

  ShiftBloc(this._locationUseCase) : super(const ShiftState()) {
    on<ShiftEvent>((event, emit) {});
    on<GetShiftByIdEvent>(_getShiftByIdEvent);
    on<GetShiftByIdsEvent>(_getShiftByIdsEvent);
    on<ResetShiftEvent>(_resetShiftEvent);
  }

  FutureOr<void> _getShiftByIdEvent(GetShiftByIdEvent event, Emitter<ShiftState> emit) async {
    try {
      final shift = await _locationUseCase.getShift(id: event.id);
      emit(state.copyWith(shift: shift));
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _getShiftByIdsEvent(GetShiftByIdsEvent event, Emitter<ShiftState> emit) async {
    try {
      final shifts = await _locationUseCase.getShifts(ids: event.ids);
      final Map<String, Shift> mapShifts = Map.fromEntries(
        shifts.map(
          (item) => MapEntry(
            item.id,
            item,
          ),
        ),
      );
      emit(state.copyWith(mapShift: mapShifts, keys: event.ids));
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  @override
  ShiftState? fromJson(Map<String, dynamic> json) {
    return ShiftState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ShiftState state) {
    return state.toJson();
  }

  FutureOr<void> _resetShiftEvent(ResetShiftEvent event, Emitter<ShiftState> emit) {
    emit(const ShiftState());
  }
}
