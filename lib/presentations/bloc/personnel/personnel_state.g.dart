// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personnel_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PersonnelStateCWProxy {
  PersonnelState status(PersonnelStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PersonnelState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PersonnelState(...).copyWith(id: 12, name: "My name")
  /// ````
  PersonnelState call({
    PersonnelStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPersonnelState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPersonnelState.copyWith.fieldName(...)`
class _$PersonnelStateCWProxyImpl implements _$PersonnelStateCWProxy {
  final PersonnelState _value;

  const _$PersonnelStateCWProxyImpl(this._value);

  @override
  PersonnelState status(PersonnelStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PersonnelState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PersonnelState(...).copyWith(id: 12, name: "My name")
  /// ````
  PersonnelState call({
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return PersonnelState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as PersonnelStatus,
    );
  }
}

extension $PersonnelStateCopyWith on PersonnelState {
  /// Returns a callable class that can be used as follows: `instanceOfPersonnelState.copyWith(...)` or like so:`instanceOfPersonnelState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PersonnelStateCWProxy get copyWith => _$PersonnelStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonnelState _$PersonnelStateFromJson(Map<String, dynamic> json) =>
    PersonnelState(
      status: $enumDecodeNullable(_$PersonnelStatusEnumMap, json['status']) ??
          PersonnelStatus.init,
    );

Map<String, dynamic> _$PersonnelStateToJson(PersonnelState instance) =>
    <String, dynamic>{
      'status': _$PersonnelStatusEnumMap[instance.status]!,
    };

const _$PersonnelStatusEnumMap = {
  PersonnelStatus.init: 'init',
  PersonnelStatus.createPersonnelInit: 'createPersonnelInit',
  PersonnelStatus.createPersonnelSuccess: 'createPersonnelSuccess',
  PersonnelStatus.createPersonnelError: 'createPersonnelError',
  PersonnelStatus.updatePersonnelInit: 'updatePersonnelInit',
  PersonnelStatus.updatePersonnelSuccess: 'updatePersonnelSuccess',
  PersonnelStatus.updatePersonnelError: 'updatePersonnelError',
  PersonnelStatus.getPersonnelInit: 'getPersonnelInit',
  PersonnelStatus.getPersonnelSuccess: 'getPersonnelSuccess',
  PersonnelStatus.getPersonnelError: 'getPersonnelError',
  PersonnelStatus.deletePersonnelInit: 'deletePersonnelInit',
  PersonnelStatus.deletePersonnelSuccess: 'deletePersonnelSuccess',
  PersonnelStatus.deletePersonnelError: 'deletePersonnelError',
  PersonnelStatus.getPersonnelByIdInit: 'getPersonnelByIdInit',
  PersonnelStatus.getPersonnelByIdSuccess: 'getPersonnelByIdSuccess',
  PersonnelStatus.getPersonnelByIdError: 'getPersonnelByIdError',
};
