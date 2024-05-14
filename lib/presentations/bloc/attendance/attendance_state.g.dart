// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceStateCWProxy {
  AttendanceState attendances(List<Attendance> attendances);

  AttendanceState status(AttendanceStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceState(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceState call({
    List<Attendance>? attendances,
    AttendanceStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceState.copyWith.fieldName(...)`
class _$AttendanceStateCWProxyImpl implements _$AttendanceStateCWProxy {
  final AttendanceState _value;

  const _$AttendanceStateCWProxyImpl(this._value);

  @override
  AttendanceState attendances(List<Attendance> attendances) =>
      this(attendances: attendances);

  @override
  AttendanceState status(AttendanceStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceState(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceState call({
    Object? attendances = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return AttendanceState(
      attendances:
          attendances == const $CopyWithPlaceholder() || attendances == null
              ? _value.attendances
              // ignore: cast_nullable_to_non_nullable
              : attendances as List<Attendance>,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AttendanceStatus,
    );
  }
}

extension $AttendanceStateCopyWith on AttendanceState {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceState.copyWith(...)` or like so:`instanceOfAttendanceState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceStateCWProxy get copyWith => _$AttendanceStateCWProxyImpl(this);
}
