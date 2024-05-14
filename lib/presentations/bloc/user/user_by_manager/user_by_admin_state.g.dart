// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_by_admin_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserByAdminStateCWProxy {
  UserByAdminState status(RequestStatus status);

  UserByAdminState users(List<User> users);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserByAdminState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserByAdminState(...).copyWith(id: 12, name: "My name")
  /// ````
  UserByAdminState call({
    RequestStatus? status,
    List<User>? users,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserByAdminState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserByAdminState.copyWith.fieldName(...)`
class _$UserByAdminStateCWProxyImpl implements _$UserByAdminStateCWProxy {
  final UserByAdminState _value;

  const _$UserByAdminStateCWProxyImpl(this._value);

  @override
  UserByAdminState status(RequestStatus status) => this(status: status);

  @override
  UserByAdminState users(List<User> users) => this(users: users);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserByAdminState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserByAdminState(...).copyWith(id: 12, name: "My name")
  /// ````
  UserByAdminState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? users = const $CopyWithPlaceholder(),
  }) {
    return UserByAdminState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as RequestStatus,
      users: users == const $CopyWithPlaceholder() || users == null
          ? _value.users
          // ignore: cast_nullable_to_non_nullable
          : users as List<User>,
    );
  }
}

extension $UserByAdminStateCopyWith on UserByAdminState {
  /// Returns a callable class that can be used as follows: `instanceOfUserByAdminState.copyWith(...)` or like so:`instanceOfUserByAdminState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserByAdminStateCWProxy get copyWith => _$UserByAdminStateCWProxyImpl(this);
}
