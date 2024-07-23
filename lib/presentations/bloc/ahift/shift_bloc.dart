import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shift_event.dart';
part 'shift_state.dart';

class ShiftBloc extends Bloc<ShiftEvent, ShiftState> {
  ShiftBloc() : super(ShiftInitial()) {
    on<ShiftEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
