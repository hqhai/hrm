// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DepartmentStateCWProxy {
  DepartmentState department(Department department);

  DepartmentState departments(List<Department> departments);

  DepartmentState status(DepartmentStatus status);

  DepartmentState totalItems(int totalItems);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepartmentState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepartmentState(...).copyWith(id: 12, name: "My name")
  /// ````
  DepartmentState call({
    Department? department,
    List<Department>? departments,
    DepartmentStatus? status,
    int? totalItems,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDepartmentState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDepartmentState.copyWith.fieldName(...)`
class _$DepartmentStateCWProxyImpl implements _$DepartmentStateCWProxy {
  final DepartmentState _value;

  const _$DepartmentStateCWProxyImpl(this._value);

  @override
  DepartmentState department(Department department) =>
      this(department: department);

  @override
  DepartmentState departments(List<Department> departments) =>
      this(departments: departments);

  @override
  DepartmentState status(DepartmentStatus status) => this(status: status);

  @override
  DepartmentState totalItems(int totalItems) => this(totalItems: totalItems);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DepartmentState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DepartmentState(...).copyWith(id: 12, name: "My name")
  /// ````
  DepartmentState call({
    Object? department = const $CopyWithPlaceholder(),
    Object? departments = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? totalItems = const $CopyWithPlaceholder(),
  }) {
    return DepartmentState(
      department:
          department == const $CopyWithPlaceholder() || department == null
              ? _value.department
              // ignore: cast_nullable_to_non_nullable
              : department as Department,
      departments:
          departments == const $CopyWithPlaceholder() || departments == null
              ? _value.departments
              // ignore: cast_nullable_to_non_nullable
              : departments as List<Department>,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as DepartmentStatus,
      totalItems:
          totalItems == const $CopyWithPlaceholder() || totalItems == null
              ? _value.totalItems
              // ignore: cast_nullable_to_non_nullable
              : totalItems as int,
    );
  }
}

extension $DepartmentStateCopyWith on DepartmentState {
  /// Returns a callable class that can be used as follows: `instanceOfDepartmentState.copyWith(...)` or like so:`instanceOfDepartmentState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DepartmentStateCWProxy get copyWith => _$DepartmentStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentState _$DepartmentStateFromJson(Map<String, dynamic> json) =>
    DepartmentState(
      department: json['department'] == null
          ? const Department(id: '', createdUserId: '')
          : Department.fromJson(json['department'] as Map<String, dynamic>),
      departments: (json['departments'] as List<dynamic>?)
              ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$DepartmentStatusEnumMap, json['status']) ??
          DepartmentStatus.init,
      totalItems: json['totalItems'] as int? ?? 0,
    );

Map<String, dynamic> _$DepartmentStateToJson(DepartmentState instance) =>
    <String, dynamic>{
      'department': instance.department,
      'departments': instance.departments,
      'status': _$DepartmentStatusEnumMap[instance.status]!,
      'totalItems': instance.totalItems,
    };

const _$DepartmentStatusEnumMap = {
  DepartmentStatus.init: 'init',
  DepartmentStatus.createDepartmentInit: 'createDepartmentInit',
  DepartmentStatus.createDepartmentSuccess: 'createDepartmentSuccess',
  DepartmentStatus.createDepartmentError: 'createDepartmentError',
  DepartmentStatus.updateDepartmentInit: 'updateDepartmentInit',
  DepartmentStatus.updateDepartmentSuccess: 'updateDepartmentSuccess',
  DepartmentStatus.updateDepartmentError: 'updateDepartmentError',
  DepartmentStatus.getDepartmentInit: 'getDepartmentInit',
  DepartmentStatus.getDepartmentSuccess: 'getDepartmentSuccess',
  DepartmentStatus.getDepartmentError: 'getDepartmentError',
  DepartmentStatus.deleteDepartmentInit: 'deleteDepartmentInit',
  DepartmentStatus.deleteDepartmentSuccess: 'deleteDepartmentSuccess',
  DepartmentStatus.deleteDepartmentError: 'deleteDepartmentError',
  DepartmentStatus.getDepartmentByIdInit: 'getDepartmentByIdInit',
  DepartmentStatus.getDepartmentByIdSuccess: 'getDepartmentByIdSuccess',
  DepartmentStatus.getDepartmentByIdError: 'getDepartmentByIdError',
};
