import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/school_status.dart';
import 'package:base_app/data/models/location/get_list_schools_usecase.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:base_app/domain/use_cases/location.usecase.dart';
import 'package:base_app/presentations/bloc/location/school/school_event.dart';
import 'package:base_app/presentations/bloc/location/school/school_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  final LocationUseCase _locationUseCase;

  SchoolBloc()
      : _locationUseCase = dI<LocationUseCase>(),
        super(const SchoolState()) {
    on<SchoolEvent>((event, emit) {});
    on<GetListSchoolsEvent>(_getListSchoolsEvent);
  }

  FutureOr<void> _getListSchoolsEvent(GetListSchoolsEvent event, Emitter<SchoolState> emit) async {
    emit(state.copyWith(status: SchoolStatus.init));
    try {
      final GetListSchoolsUseCase getListSchoolsUseCase = await _locationUseCase.getListSchools();
      final Map<String, School> mapSchools = getListSchoolsUseCase.schools;
      final List<String> schoolsId = getListSchoolsUseCase.schoolsId;
      emit(state.copyWith(
        schools: mapSchools,
        schoolIds: schoolsId,
        status: SchoolStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: SchoolStatus.fail));
    }
  }
}
