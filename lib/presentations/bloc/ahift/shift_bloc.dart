import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/use_cases/location.usecase.dart';
import 'package:base_app/presentations/bloc/ahift/shift_event.dart';
import 'package:base_app/presentations/bloc/ahift/shift_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ShiftBloc extends Bloc<ShiftEvent, ShiftState> {
  final LocationUseCase _locationUseCase;

  ShiftBloc()
      : _locationUseCase = dI<LocationUseCase>(),
        super(const ShiftState()) {
    on<ShiftEvent>((event, emit) {});
    on<GetShiftByIdEvent>(_getShiftByIdEvent);
  }

  FutureOr<void> _getShiftByIdEvent(GetShiftByIdEvent event, Emitter<ShiftState> emit) async {
    try{
      final shift = await _locationUseCase.getShift(id: event.id);
      emit(state.copyWith(shift: shift));
      event.completer?.complete(true);
    }catch(e){
      event.completer?.complete(false);
    }
  }
}
