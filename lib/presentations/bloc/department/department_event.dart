import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class DepartmentEvent extends Equatable {
  const DepartmentEvent();

  @override
  List<Object?> get props => [];
}

class CreateDepartmentEvent extends DepartmentEvent {
  final String name;
  final String code;
  final String phoneNumber;
  final String email;
  final String address;
  final String? description;
  final String? parentId;

  const CreateDepartmentEvent({
    required this.name,
    required this.code,
    required this.phoneNumber,
    required this.email,
    required this.address,
    this.description,
    this.parentId,
  });

  @override
  List<Object?> get props => [name, code, phoneNumber, email, address, description, parentId];
}

class GetListDepartmentEvent extends DepartmentEvent {
  final Completer? completer;
  final int page;
  final String key;

  const GetListDepartmentEvent({
    this.completer,
    this.page = 1,
    this.key = '',
  });

  @override
  List<Object?> get props => [completer, page, key];
}

class GetDepartmentsEvent extends DepartmentEvent {
  const GetDepartmentsEvent();

  @override
  List<Object?> get props => [];
}

class GetDepartmentByIdEvent extends DepartmentEvent {
  final String id;

  const GetDepartmentByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteDepartmentsEvent extends DepartmentEvent {
  final String id;

  const DeleteDepartmentsEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateDepartmentEvent extends DepartmentEvent {
  final String id;
  final String name;
  final String code;
  final String phoneNumber;
  final String email;
  final String address;
  final String? description;
  final String? parentId;

  const UpdateDepartmentEvent({
    required this.id,
    required this.name,
    required this.code,
    required this.phoneNumber,
    required this.email,
    required this.address,
    this.description,
    this.parentId,
  });

  @override
  List<Object?> get props => [id, name, code, phoneNumber, email, address, description, parentId];
}
