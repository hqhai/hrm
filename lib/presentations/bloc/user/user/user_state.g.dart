// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserStateCWProxy {
  UserState user(User user);

  UserState email(String email);

  UserState status(UserStatus status);

  UserState errorCode(String errorCode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserState(...).copyWith(id: 12, name: "My name")
  /// ````
  UserState call({
    User? user,
    String? email,
    UserStatus? status,
    String? errorCode,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserState.copyWith.fieldName(...)`
class _$UserStateCWProxyImpl implements _$UserStateCWProxy {
  const _$UserStateCWProxyImpl(this._value);

  final UserState _value;

  @override
  UserState user(User user) => this(user: user);

  @override
  UserState email(String email) => this(email: email);

  @override
  UserState status(UserStatus status) => this(status: status);

  @override
  UserState errorCode(String errorCode) => this(errorCode: errorCode);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserState(...).copyWith(id: 12, name: "My name")
  /// ````
  UserState call({
    Object? user = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? errorCode = const $CopyWithPlaceholder(),
  }) {
    return UserState(
      user: user == const $CopyWithPlaceholder() || user == null
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as UserStatus,
      errorCode: errorCode == const $CopyWithPlaceholder() || errorCode == null
          ? _value.errorCode
          // ignore: cast_nullable_to_non_nullable
          : errorCode as String,
    );
  }
}

extension $UserStateCopyWith on UserState {
  /// Returns a callable class that can be used as follows: `instanceOfUserState.copyWith(...)` or like so:`instanceOfUserState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserStateCWProxy get copyWith => _$UserStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserState _$UserStateFromJson(Map<String, dynamic> json) => UserState(
      user: json['user'] == null
          ? const User(id: "", createdUserId: "", gender: GenderEnum.male)
          : User.fromJson(json['user'] as Map<String, dynamic>),
      email: json['email'] as String? ?? '',
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
          UserStatus.init,
      errorCode: json['errorCode'] as String? ?? '',
    );

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'user': instance.user,
      'email': instance.email,
      'errorCode': instance.errorCode,
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
