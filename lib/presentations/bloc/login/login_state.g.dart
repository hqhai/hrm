// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginStateCWProxy {
  LoginState status(LoginStatus status);

  LoginState username(String username);

  LoginState password(String password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginState(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginState call({
    LoginStatus? status,
    String? username,
    String? password,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLoginState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLoginState.copyWith.fieldName(...)`
class _$LoginStateCWProxyImpl implements _$LoginStateCWProxy {
  const _$LoginStateCWProxyImpl(this._value);

  final LoginState _value;

  @override
  LoginState status(LoginStatus status) => this(status: status);

  @override
  LoginState username(String username) => this(username: username);

  @override
  LoginState password(String password) => this(password: password);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginState(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return LoginState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as LoginStatus,
      username: username == const $CopyWithPlaceholder() || username == null
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $LoginStateCopyWith on LoginState {
  /// Returns a callable class that can be used as follows: `instanceOfLoginState.copyWith(...)` or like so:`instanceOfLoginState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginStateCWProxy get copyWith => _$LoginStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginState _$LoginStateFromJson(Map<String, dynamic> json) => LoginState(
      status: $enumDecodeNullable(_$LoginStatusEnumMap, json['status']) ??
          LoginStatus.initLoginState,
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );

Map<String, dynamic> _$LoginStateToJson(LoginState instance) =>
    <String, dynamic>{
      'status': _$LoginStatusEnumMap[instance.status]!,
      'username': instance.username,
      'password': instance.password,
    };

const _$LoginStatusEnumMap = {
  LoginStatus.userLocked: 'userLocked',
  LoginStatus.wrongBiometricAccount: 'wrongBiometricAccount',
  LoginStatus.initLoginState: 'initLoginState',
  LoginStatus.loginSuccess: 'loginSuccess',
  LoginStatus.firstLoginSuccess: 'firstLoginSuccess',
  LoginStatus.loadingState: 'loadingState',
  LoginStatus.loginAccountRequired: 'loginAccountRequired',
  LoginStatus.loginFailed: 'loginFailed',
  LoginStatus.validateFailed: 'validateFailed',
  LoginStatus.validateSuccess: 'validateSuccess',
  LoginStatus.statusSuccess: 'statusSuccess',
  LoginStatus.statusFalse: 'statusFalse',
  LoginStatus.emailOrUserFalse: 'emailOrUserFalse',
  LoginStatus.passFalse: 'passFalse',
  LoginStatus.errorState: 'errorState',
  LoginStatus.notRegisteredForBiometrics: 'notRegisteredForBiometrics',
};
