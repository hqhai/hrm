// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceStateCWProxy {
  AttendanceState attendance(Attendance attendance);

  AttendanceState status(AttendanceStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceState(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceState call({
    Attendance? attendance,
    AttendanceStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceState.copyWith.fieldName(...)`
class _$AttendanceStateCWProxyImpl implements _$AttendanceStateCWProxy {
  const _$AttendanceStateCWProxyImpl(this._value);

  final AttendanceState _value;

  @override
  AttendanceState attendance(Attendance attendance) =>
      this(attendance: attendance);

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
    Object? attendance = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return AttendanceState(
      attendance:
          attendance == const $CopyWithPlaceholder() || attendance == null
              ? _value.attendance
              // ignore: cast_nullable_to_non_nullable
              : attendance as Attendance,
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceState _$AttendanceStateFromJson(Map<String, dynamic> json) =>
    AttendanceState(
      attendance: json['attendance'] == null
          ? const Attendance()
          : Attendance.fromJson(json['attendance'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$AttendanceStatusEnumMap, json['status']) ??
          AttendanceStatus.init,
    );

Map<String, dynamic> _$AttendanceStateToJson(AttendanceState instance) =>
    <String, dynamic>{
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'attendance': instance.attendance,
    };

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.init: 'init',
  AttendanceStatus.getAttendanceInit: 'getAttendanceInit',
  AttendanceStatus.getAttendanceSuccess: 'getAttendanceSuccess',
  AttendanceStatus.getAttendanceError: 'getAttendanceError',
  AttendanceStatus.setNoteSuccess: 'setNoteSuccess',
  AttendanceStatus.setNoteError: 'setNoteError',
};
