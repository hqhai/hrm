import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/use_cases/personnel_usecase.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_event.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PersonnelBloc extends HydratedBloc<PersonnelEvent, PersonnelState> {
  final PersonnelUseCase personnelUseCase;

  PersonnelBloc()
      : personnelUseCase = dI<PersonnelUseCase>(),
        super(const PersonnelState()) {
    on<PersonnelEvent>((event, emit) {});
    on<CreatePersonnelEvent>(_createPersonnelEvent);
    on<GetPersonnelEvent>(_getPersonnelEvent);
    on<ResetPersonnelEvent>(_resetPersonnelEvent);
  }

  FutureOr<void> _createPersonnelEvent(
      CreatePersonnelEvent event, Emitter<PersonnelState> emit) async {
    emit(state.copyWith(status: PersonnelStatus.createPersonnelInit));
    try {
      await personnelUseCase.createPersonnel(
          code: event.code,
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          phoneNumber: event.phoneNumber,
          startDate: event.startDate,
          attendanceId: event.attendanceId,
          departmentId: event.departmentId,
          positionId: event.positionId,
          morningStartTime: event.morningStartTime,
          morningEndTime: event.morningStartTime,
          afternoonStartTime: event.afternoonStartTime,
          afternoonEndTime: event.afternoonEndTime);
      emit(state.copyWith(status: PersonnelStatus.createPersonnelSuccess));
    } catch (e) {
      emit(state.copyWith(status: PersonnelStatus.createPersonnelError));
    }
  }

  FutureOr<void> _getPersonnelEvent(GetPersonnelEvent event, Emitter<PersonnelState> emit) async {

  }

  @override
  PersonnelState? fromJson(Map<String, dynamic> json) {
    return PersonnelState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PersonnelState state) {
    return state.toJson();
  }

  FutureOr<void> _resetPersonnelEvent(ResetPersonnelEvent event, Emitter<PersonnelState> emit) {
    emit(const PersonnelState());
  }
}
