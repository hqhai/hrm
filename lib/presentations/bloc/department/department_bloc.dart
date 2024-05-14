import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/use_cases/departments_usecase.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  final DepartmentUseCase departmentUseCase;

  DepartmentBloc()
      : departmentUseCase = dI<DepartmentUseCase>(),
        super(const DepartmentState()) {
    on<DepartmentEvent>((event, emit) {});
    on<CreateDepartmentEvent>(_createDepartmentEvent);
    on<GetDepartmentsEvent>(_getDepartmentsEvent);
    on<DeleteDepartmentsEvent>(_deleteDepartmentsEvent);
    on<UpdateDepartmentEvent>(_updateDepartmentEvent);
    on<GetDepartmentByIdEvent>(_getDepartmentByIdEvent);
  }

  FutureOr<void> _createDepartmentEvent(
      CreateDepartmentEvent event, Emitter<DepartmentState> emit) async {
    emit(state.copyWith(status: DepartmentStatus.createDepartmentInit));
    try {
      await departmentUseCase.createDepartment(
          name: event.name,
          code: event.code,
          phoneNumber: event.phoneNumber,
          email: event.email,
          address: event.address,
          parentId: event.parentId,
          description: event.description);
      emit(state.copyWith(status: DepartmentStatus.createDepartmentSuccess));
    } catch (e) {
      emit(state.copyWith(status: DepartmentStatus.createDepartmentError));
    }
  }

  FutureOr<void> _getDepartmentsEvent(
      GetDepartmentsEvent event, Emitter<DepartmentState> emit) async {
    emit(state.copyWith(status: DepartmentStatus.getDepartmentInit));
    try {
      List<Department> departments = await departmentUseCase.getDepartments();
      emit(state.copyWith(departments: departments, status: DepartmentStatus.getDepartmentSuccess));
    } catch (e) {
      emit(state.copyWith(status: DepartmentStatus.getDepartmentError));
    }
  }

  FutureOr<void> _deleteDepartmentsEvent(
      DeleteDepartmentsEvent event, Emitter<DepartmentState> emit) async {
    emit(state.copyWith(status: DepartmentStatus.deleteDepartmentInit));
    try {
      int statusCode = await departmentUseCase.deleteDepartments(id: event.id);
      statusCode;
      emit(state.copyWith(status: DepartmentStatus.deleteDepartmentSuccess));
    } catch (e) {
      emit(state.copyWith(status: DepartmentStatus.deleteDepartmentError));
    }
  }

  FutureOr<void> _updateDepartmentEvent(
      UpdateDepartmentEvent event, Emitter<DepartmentState> emit) async {
    emit(state.copyWith(status: DepartmentStatus.updateDepartmentInit));
    try {
      int statusCode = await departmentUseCase.updateDepartment(
          id: event.id,
          name: event.name,
          code: event.code,
          phoneNumber: event.phoneNumber,
          email: event.email,
          address: event.address,
          description: event.description,
          parentId: event.parentId);
      statusCode;
      emit(state.copyWith(status: DepartmentStatus.updateDepartmentSuccess));
    } catch (e) {
      emit(state.copyWith(status: DepartmentStatus.updateDepartmentError));
    }
  }

  FutureOr<void> _getDepartmentByIdEvent(
      GetDepartmentByIdEvent event, Emitter<DepartmentState> emit) async {
    emit(state.copyWith(status: DepartmentStatus.getDepartmentByIdInit));
    try {
      Department department = await departmentUseCase.getDepartment(id: event.id);
      emit(state.copyWith(
          department: department, status: DepartmentStatus.getDepartmentByIdSuccess));
    } catch (e) {
      emit(state.copyWith(status: DepartmentStatus.getDepartmentByIdError));
    }
  }
}
