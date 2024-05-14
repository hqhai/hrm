// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_setting_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CheckInSettingStateCWProxy {
  CheckInSettingState status(CheckInSettingStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CheckInSettingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CheckInSettingState(...).copyWith(id: 12, name: "My name")
  /// ````
  CheckInSettingState call({
    CheckInSettingStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCheckInSettingState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCheckInSettingState.copyWith.fieldName(...)`
class _$CheckInSettingStateCWProxyImpl implements _$CheckInSettingStateCWProxy {
  final CheckInSettingState _value;

  const _$CheckInSettingStateCWProxyImpl(this._value);

  @override
  CheckInSettingState status(CheckInSettingStatus status) =>
      this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CheckInSettingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CheckInSettingState(...).copyWith(id: 12, name: "My name")
  /// ````
  CheckInSettingState call({
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return CheckInSettingState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as CheckInSettingStatus,
    );
  }
}

extension $CheckInSettingStateCopyWith on CheckInSettingState {
  /// Returns a callable class that can be used as follows: `instanceOfCheckInSettingState.copyWith(...)` or like so:`instanceOfCheckInSettingState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CheckInSettingStateCWProxy get copyWith =>
      _$CheckInSettingStateCWProxyImpl(this);
}
