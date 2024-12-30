import 'dart:async';

import 'package:base_app/common/enum/school_status.dart';
import 'package:base_app/data/models/location/get_list_schools_usecase.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:base_app/domain/use_cases/location_usecase.dart';
import 'package:base_app/presentations/bloc/location/school/school_event.dart';
import 'package:base_app/presentations/bloc/location/school/school_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class SchoolBloc extends HydratedBloc<SchoolEvent, SchoolState> {
  final LocationUseCase _locationUseCase;

  SchoolBloc(this._locationUseCase) : super(const SchoolState()) {
    on<SchoolEvent>((event, emit) {});
    on<GetListSchoolsEvent>(_getListSchoolsEvent);
    on<ResetSchoolEvent>(_resetSchoolEvent);
  }

  FutureOr<void> _getListSchoolsEvent(
      GetListSchoolsEvent event, Emitter<SchoolState> emit) async {
    emit(state.copyWith(status: SchoolStatus.init));
    try {
      final GetListSchoolsUseCase getListSchoolsUseCase =
          await _locationUseCase.getListSchools(
        page: event.page,
        keyword: event.keyword,
      );
      final Map<String, School> mapSchools = getListSchoolsUseCase.schools;
      final List<String> schoolsId = getListSchoolsUseCase.schoolsId;
      final totalItems = getListSchoolsUseCase.pagingInfo;
      if (event.page != 1) {
        final Map<String, School> mapOld = state.schools;
        final listIdOld = [...state.schoolIds];
        mapOld.addAll(mapSchools);
        listIdOld.addAll(schoolsId);
        emit(state.copyWith(
          totalItems: totalItems.totalItems,
          schools: mapOld,
          schoolIds: listIdOld,
          status: SchoolStatus.success,
        ));
        event.completer?.complete(true);
      } else {
        emit(state.copyWith(
          totalItems: totalItems.totalItems,
          schools: mapSchools,
          schoolIds: schoolsId,
          status: SchoolStatus.success,
        ));
        event.completer?.complete(true);
      }
    } catch (e) {
      emit(state.copyWith(status: SchoolStatus.fail));
      event.completer?.complete(false);
    }
  }

  @override
  SchoolState? fromJson(Map<String, dynamic> json) {
    return SchoolState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SchoolState state) {
    return state.toJson();
  }

  FutureOr<void> _resetSchoolEvent(
      ResetSchoolEvent event, Emitter<SchoolState> emit) {
    emit(const SchoolState());
  }
}
