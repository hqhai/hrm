import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/position.dart';
import 'package:base_app/domain/use_cases/position_usecase.dart';
import 'package:base_app/presentations/bloc/position/position_event.dart';
import 'package:base_app/presentations/bloc/position/position_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PositionBloc extends HydratedBloc<PositionEvent, PositionState> {
  final PositionUseCase positionUseCase;

  PositionBloc()
      : positionUseCase = dI<PositionUseCase>(),
        super(const PositionState()) {
    on<CreatePositionEvent>(_createPositionEvent);
    on<GetPositionsEvent>(_getPositionsEvent);
    on<DeletePositionsEvent>(_deletePositionsEvent);
    on<UpdatePositionEvent>(_updatePositionEvent);
    on<GetPositionByIdEvent>(_getPositionByIdEvent);
    on<ResetPositionEvent>(_resetPositionEvent);
  }

  FutureOr<void> _createPositionEvent(
      CreatePositionEvent event, Emitter<PositionState> emit) async {
    emit(state.copyWith(status: PositionStatus.createPositionSuccess));
    try {
      await positionUseCase.createPosition(name: event.name, description: event.description);
      emit(state.copyWith(status: PositionStatus.createPositionSuccess));
    } catch (e) {
      emit(state.copyWith(status: PositionStatus.createPositionError));
    }
  }

  FutureOr<void> _getPositionsEvent(GetPositionsEvent event, Emitter<PositionState> emit) async {
    emit(state.copyWith(status: PositionStatus.getPositionInit));
    try {
      List<Position> departments = await positionUseCase.getPositions();
      emit(state.copyWith(positions: departments, status: PositionStatus.getPositionSuccess));
    } catch (e) {
      emit(state.copyWith(status: PositionStatus.getPositionError));
    }
  }

  FutureOr<void> _deletePositionsEvent(
      DeletePositionsEvent event, Emitter<PositionState> emit) async {
    emit(state.copyWith(status: PositionStatus.deletePositionInit));
    try {
      int statusCode = await positionUseCase.deletePosition(id: event.id);
      statusCode;
      emit(state.copyWith(status: PositionStatus.deletePositionSuccess));
    } catch (e) {
      emit(state.copyWith(status: PositionStatus.deletePositionError));
    }
  }

  FutureOr<void> _updatePositionEvent(
      UpdatePositionEvent event, Emitter<PositionState> emit) async {
    emit(state.copyWith(status: PositionStatus.updatePositionInit));
    try {
      await positionUseCase.updatePosition(
        id: event.id,
        name: event.name,
        description: event.description,
      );
      emit(state.copyWith(status: PositionStatus.updatePositionSuccess));
    } catch (e) {
      emit(state.copyWith(status: PositionStatus.updatePositionError));
    }
  }

  FutureOr<void> _getPositionByIdEvent(GetPositionByIdEvent event, Emitter<PositionState> emit) {}

  @override
  PositionState? fromJson(Map<String, dynamic> json) {
    return PositionState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PositionState state) {
    return state.toJson();
  }

  FutureOr<void> _resetPositionEvent(ResetPositionEvent event, Emitter<PositionState> emit) {
    emit(const PositionState());
  }
}
