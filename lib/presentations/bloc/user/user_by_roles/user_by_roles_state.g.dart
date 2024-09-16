// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_by_roles_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserByRolesStateCWProxy {
  UserByRolesState status(UserStatus status);

  UserByRolesState users(List<User> users);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserByRolesState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserByRolesState(...).copyWith(id: 12, name: "My name")
  /// ````
  UserByRolesState call({
    UserStatus? status,
    List<User>? users,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserByRolesState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserByRolesState.copyWith.fieldName(...)`
class _$UserByRolesStateCWProxyImpl implements _$UserByRolesStateCWProxy {
  final UserByRolesState _value;

  const _$UserByRolesStateCWProxyImpl(this._value);

  @override
  UserByRolesState status(UserStatus status) => this(status: status);

  @override
  UserByRolesState users(List<User> users) => this(users: users);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserByRolesState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserByRolesState(...).copyWith(id: 12, name: "My name")
  /// ````
  UserByRolesState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? users = const $CopyWithPlaceholder(),
  }) {
    return UserByRolesState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as UserStatus,
      users: users == const $CopyWithPlaceholder() || users == null
          ? _value.users
          // ignore: cast_nullable_to_non_nullable
          : users as List<User>,
    );
  }
}

extension $UserByRolesStateCopyWith on UserByRolesState {
  /// Returns a callable class that can be used as follows: `instanceOfUserByRolesState.copyWith(...)` or like so:`instanceOfUserByRolesState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserByRolesStateCWProxy get copyWith => _$UserByRolesStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserByRolesState _$UserByRolesStateFromJson(Map<String, dynamic> json) =>
    UserByRolesState(
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
          UserStatus.init,
    );

Map<String, dynamic> _$UserByRolesStateToJson(UserByRolesState instance) =>
    <String, dynamic>{
      'users': instance.users,
      'status': _$UserStatusEnumMap[instance.status]!,
    };

const _$UserStatusEnumMap = {
  UserStatus.init: 'init',
  UserStatus.start: 'start',
  UserStatus.success: 'success',
  UserStatus.fail: 'fail',
  UserStatus.unauthorized: 'unauthorized',
  UserStatus.unknown: 'unknown',
};
