// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceCWProxy {
  Attendance workTimeReal(int workTimeReal);

  Attendance workTimeActual(int workTimeActual);

  Attendance overTime(int overTime);

  Attendance realRate(double realRate);

  Attendance overTimeRate(int overTimeRate);

  Attendance overTimeDay(EnumOvertimeDay overTimeDay);

  Attendance noSalaryRate(double noSalaryRate);

  Attendance leaveRate(double leaveRate);

  Attendance holidayRate(double holidayRate);

  Attendance actualRate(double actualRate);

  Attendance userId(String? userId);

  Attendance timeLate(int timeLate);

  Attendance salaryRate(double salaryRate);

  Attendance name(String? name);

  Attendance code(String? code);

  Attendance countEarly(int countEarly);

  Attendance countLate(int countLate);

  Attendance timeEarly(int timeEarly);

  Attendance userWorkingHistories(
      List<UserWorkingHistoryModel> userWorkingHistories);

  Attendance overTimeLeave(int overTimeLeave);

  Attendance overTimeSalary(int overTimeSalary);

  Attendance compensatoryLeaveRate(double compensatoryLeaveRate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Attendance(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Attendance(...).copyWith(id: 12, name: "My name")
  /// ````
  Attendance call({
    int? workTimeReal,
    int? workTimeActual,
    int? overTime,
    double? realRate,
    int? overTimeRate,
    EnumOvertimeDay? overTimeDay,
    double? noSalaryRate,
    double? leaveRate,
    double? holidayRate,
    double? actualRate,
    String? userId,
    int? timeLate,
    double? salaryRate,
    String? name,
    String? code,
    int? countEarly,
    int? countLate,
    int? timeEarly,
    List<UserWorkingHistoryModel>? userWorkingHistories,
    int? overTimeLeave,
    int? overTimeSalary,
    double? compensatoryLeaveRate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendance.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendance.copyWith.fieldName(...)`
class _$AttendanceCWProxyImpl implements _$AttendanceCWProxy {
  const _$AttendanceCWProxyImpl(this._value);

  final Attendance _value;

  @override
  Attendance workTimeReal(int workTimeReal) => this(workTimeReal: workTimeReal);

  @override
  Attendance workTimeActual(int workTimeActual) =>
      this(workTimeActual: workTimeActual);

  @override
  Attendance overTime(int overTime) => this(overTime: overTime);

  @override
  Attendance realRate(double realRate) => this(realRate: realRate);

  @override
  Attendance overTimeRate(int overTimeRate) => this(overTimeRate: overTimeRate);

  @override
  Attendance overTimeDay(EnumOvertimeDay overTimeDay) =>
      this(overTimeDay: overTimeDay);

  @override
  Attendance noSalaryRate(double noSalaryRate) =>
      this(noSalaryRate: noSalaryRate);

  @override
  Attendance leaveRate(double leaveRate) => this(leaveRate: leaveRate);

  @override
  Attendance holidayRate(double holidayRate) => this(holidayRate: holidayRate);

  @override
  Attendance actualRate(double actualRate) => this(actualRate: actualRate);

  @override
  Attendance userId(String? userId) => this(userId: userId);

  @override
  Attendance timeLate(int timeLate) => this(timeLate: timeLate);

  @override
  Attendance salaryRate(double salaryRate) => this(salaryRate: salaryRate);

  @override
  Attendance name(String? name) => this(name: name);

  @override
  Attendance code(String? code) => this(code: code);

  @override
  Attendance countEarly(int countEarly) => this(countEarly: countEarly);

  @override
  Attendance countLate(int countLate) => this(countLate: countLate);

  @override
  Attendance timeEarly(int timeEarly) => this(timeEarly: timeEarly);

  @override
  Attendance userWorkingHistories(
          List<UserWorkingHistoryModel> userWorkingHistories) =>
      this(userWorkingHistories: userWorkingHistories);

  @override
  Attendance overTimeLeave(int overTimeLeave) =>
      this(overTimeLeave: overTimeLeave);

  @override
  Attendance overTimeSalary(int overTimeSalary) =>
      this(overTimeSalary: overTimeSalary);

  @override
  Attendance compensatoryLeaveRate(double compensatoryLeaveRate) =>
      this(compensatoryLeaveRate: compensatoryLeaveRate);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Attendance(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Attendance(...).copyWith(id: 12, name: "My name")
  /// ````
  Attendance call({
    Object? workTimeReal = const $CopyWithPlaceholder(),
    Object? workTimeActual = const $CopyWithPlaceholder(),
    Object? overTime = const $CopyWithPlaceholder(),
    Object? realRate = const $CopyWithPlaceholder(),
    Object? overTimeRate = const $CopyWithPlaceholder(),
    Object? overTimeDay = const $CopyWithPlaceholder(),
    Object? noSalaryRate = const $CopyWithPlaceholder(),
    Object? leaveRate = const $CopyWithPlaceholder(),
    Object? holidayRate = const $CopyWithPlaceholder(),
    Object? actualRate = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? timeLate = const $CopyWithPlaceholder(),
    Object? salaryRate = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? countEarly = const $CopyWithPlaceholder(),
    Object? countLate = const $CopyWithPlaceholder(),
    Object? timeEarly = const $CopyWithPlaceholder(),
    Object? userWorkingHistories = const $CopyWithPlaceholder(),
    Object? overTimeLeave = const $CopyWithPlaceholder(),
    Object? overTimeSalary = const $CopyWithPlaceholder(),
    Object? compensatoryLeaveRate = const $CopyWithPlaceholder(),
  }) {
    return Attendance(
      workTimeReal:
          workTimeReal == const $CopyWithPlaceholder() || workTimeReal == null
              ? _value.workTimeReal
              // ignore: cast_nullable_to_non_nullable
              : workTimeReal as int,
      workTimeActual: workTimeActual == const $CopyWithPlaceholder() ||
              workTimeActual == null
          ? _value.workTimeActual
          // ignore: cast_nullable_to_non_nullable
          : workTimeActual as int,
      overTime: overTime == const $CopyWithPlaceholder() || overTime == null
          ? _value.overTime
          // ignore: cast_nullable_to_non_nullable
          : overTime as int,
      realRate: realRate == const $CopyWithPlaceholder() || realRate == null
          ? _value.realRate
          // ignore: cast_nullable_to_non_nullable
          : realRate as double,
      overTimeRate:
          overTimeRate == const $CopyWithPlaceholder() || overTimeRate == null
              ? _value.overTimeRate
              // ignore: cast_nullable_to_non_nullable
              : overTimeRate as int,
      overTimeDay:
          overTimeDay == const $CopyWithPlaceholder() || overTimeDay == null
              ? _value.overTimeDay
              // ignore: cast_nullable_to_non_nullable
              : overTimeDay as EnumOvertimeDay,
      noSalaryRate:
          noSalaryRate == const $CopyWithPlaceholder() || noSalaryRate == null
              ? _value.noSalaryRate
              // ignore: cast_nullable_to_non_nullable
              : noSalaryRate as double,
      leaveRate: leaveRate == const $CopyWithPlaceholder() || leaveRate == null
          ? _value.leaveRate
          // ignore: cast_nullable_to_non_nullable
          : leaveRate as double,
      holidayRate:
          holidayRate == const $CopyWithPlaceholder() || holidayRate == null
              ? _value.holidayRate
              // ignore: cast_nullable_to_non_nullable
              : holidayRate as double,
      actualRate:
          actualRate == const $CopyWithPlaceholder() || actualRate == null
              ? _value.actualRate
              // ignore: cast_nullable_to_non_nullable
              : actualRate as double,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      timeLate: timeLate == const $CopyWithPlaceholder() || timeLate == null
          ? _value.timeLate
          // ignore: cast_nullable_to_non_nullable
          : timeLate as int,
      salaryRate:
          salaryRate == const $CopyWithPlaceholder() || salaryRate == null
              ? _value.salaryRate
              // ignore: cast_nullable_to_non_nullable
              : salaryRate as double,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      countEarly:
          countEarly == const $CopyWithPlaceholder() || countEarly == null
              ? _value.countEarly
              // ignore: cast_nullable_to_non_nullable
              : countEarly as int,
      countLate: countLate == const $CopyWithPlaceholder() || countLate == null
          ? _value.countLate
          // ignore: cast_nullable_to_non_nullable
          : countLate as int,
      timeEarly: timeEarly == const $CopyWithPlaceholder() || timeEarly == null
          ? _value.timeEarly
          // ignore: cast_nullable_to_non_nullable
          : timeEarly as int,
      userWorkingHistories:
          userWorkingHistories == const $CopyWithPlaceholder() ||
                  userWorkingHistories == null
              ? _value.userWorkingHistories
              // ignore: cast_nullable_to_non_nullable
              : userWorkingHistories as List<UserWorkingHistoryModel>,
      overTimeLeave:
          overTimeLeave == const $CopyWithPlaceholder() || overTimeLeave == null
              ? _value.overTimeLeave
              // ignore: cast_nullable_to_non_nullable
              : overTimeLeave as int,
      overTimeSalary: overTimeSalary == const $CopyWithPlaceholder() ||
              overTimeSalary == null
          ? _value.overTimeSalary
          // ignore: cast_nullable_to_non_nullable
          : overTimeSalary as int,
      compensatoryLeaveRate:
          compensatoryLeaveRate == const $CopyWithPlaceholder() ||
                  compensatoryLeaveRate == null
              ? _value.compensatoryLeaveRate
              // ignore: cast_nullable_to_non_nullable
              : compensatoryLeaveRate as double,
    );
  }
}

extension $AttendanceCopyWith on Attendance {
  /// Returns a callable class that can be used as follows: `instanceOfAttendance.copyWith(...)` or like so:`instanceOfAttendance.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceCWProxy get copyWith => _$AttendanceCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      workTimeReal: (json['workTimeReal'] as num?)?.toInt() ?? 0,
      workTimeActual: (json['workTimeActual'] as num?)?.toInt() ?? 0,
      overTime: (json['overTime'] as num?)?.toInt() ?? 0,
      realRate: (json['realRate'] as num?)?.toDouble() ?? 0,
      overTimeRate: (json['overTimeRate'] as num?)?.toInt() ?? 0,
      overTimeDay: $enumDecodeNullable(
              _$EnumOvertimeDayEnumMap, json['overTimeDay'],
              unknownValue: EnumOvertimeDay.unknown) ??
          EnumOvertimeDay.unknown,
      noSalaryRate: (json['noSalaryRate'] as num?)?.toDouble() ?? 0,
      leaveRate: (json['leaveRate'] as num?)?.toDouble() ?? 0,
      holidayRate: (json['holidayRate'] as num?)?.toDouble() ?? 0,
      actualRate: (json['actualRate'] as num?)?.toDouble() ?? 0,
      userId: json['userId'] as String?,
      timeLate: (json['timeLate'] as num?)?.toInt() ?? 0,
      salaryRate: (json['salaryRate'] as num?)?.toDouble() ?? 0,
      name: json['name'] as String?,
      code: json['code'] as String?,
      countEarly: (json['countEarly'] as num?)?.toInt() ?? 0,
      countLate: (json['countLate'] as num?)?.toInt() ?? 0,
      timeEarly: (json['timeEarly'] as num?)?.toInt() ?? 0,
      userWorkingHistories: (json['userWorkingHistories'] as List<dynamic>?)
              ?.map((e) =>
                  UserWorkingHistoryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      overTimeLeave: (json['overTimeLeave'] as num?)?.toInt() ?? 0,
      overTimeSalary: (json['overTimeSalary'] as num?)?.toInt() ?? 0,
      compensatoryLeaveRate:
          (json['compensatoryLeaveRate'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.code case final value?) 'code': value,
      if (instance.userId case final value?) 'userId': value,
      'actualRate': instance.actualRate,
      'leaveRate': instance.leaveRate,
      'compensatoryLeaveRate': instance.compensatoryLeaveRate,
      'holidayRate': instance.holidayRate,
      'noSalaryRate': instance.noSalaryRate,
      'overTime': instance.overTime,
      'overTimeRate': instance.overTimeRate,
      'overTimeSalary': instance.overTimeSalary,
      'overTimeLeave': instance.overTimeLeave,
      'overTimeDay': _$EnumOvertimeDayEnumMap[instance.overTimeDay]!,
      'workTimeReal': instance.workTimeReal,
      'workTimeActual': instance.workTimeActual,
      'timeEarly': instance.timeEarly,
      'timeLate': instance.timeLate,
      'countEarly': instance.countEarly,
      'countLate': instance.countLate,
      'salaryRate': instance.salaryRate,
      'realRate': instance.realRate,
      'userWorkingHistories': instance.userWorkingHistories,
    };

const _$EnumOvertimeDayEnumMap = {
  EnumOvertimeDay.holiday: 'Holiday',
  EnumOvertimeDay.noShiftsWork: 'NoShiftsWork',
  EnumOvertimeDay.saturday: 'Saturday',
  EnumOvertimeDay.sunday: 'Sunday',
  EnumOvertimeDay.regularDay: 'RegularDay',
  EnumOvertimeDay.unknown: '',
};
