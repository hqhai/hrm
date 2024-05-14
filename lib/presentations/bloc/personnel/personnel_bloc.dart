import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/use_cases/personnel_usecase.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_event.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PersonnelBloc extends Bloc<PersonnelEvent, PersonnelState> {
  final PersonnelUseCase personnelUseCase;

  PersonnelBloc()
      : personnelUseCase = dI<PersonnelUseCase>(),
        super(const PersonnelState()) {
    on<PersonnelEvent>((event, emit) {});
    on<CreatePersonnelEvent>(_createPersonnelEvent);
    on<GetPersonnelEvent>(_getPersonnelEvent);
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
}
