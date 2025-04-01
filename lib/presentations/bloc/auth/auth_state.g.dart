// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthStateCWProxy {
  AuthState status(AuthStatus status);

  AuthState token(String token);

  AuthState saveLogin(bool saveLogin);

  AuthState email(String email);

  AuthState password(String password);

  AuthState roles(List<String> roles);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthState(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthState call({
    AuthStatus? status,
    String? token,
    bool? saveLogin,
    String? email,
    String? password,
    List<String>? roles,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthState.copyWith.fieldName(...)`
class _$AuthStateCWProxyImpl implements _$AuthStateCWProxy {
  const _$AuthStateCWProxyImpl(this._value);

  final AuthState _value;

  @override
  AuthState status(AuthStatus status) => this(status: status);

  @override
  AuthState token(String token) => this(token: token);

  @override
  AuthState saveLogin(bool saveLogin) => this(saveLogin: saveLogin);

  @override
  AuthState email(String email) => this(email: email);

  @override
  AuthState password(String password) => this(password: password);

  @override
  AuthState roles(List<String> roles) => this(roles: roles);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthState(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
    Object? saveLogin = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? roles = const $CopyWithPlaceholder(),
  }) {
    return AuthState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AuthStatus,
      token: token == const $CopyWithPlaceholder() || token == null
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
      saveLogin: saveLogin == const $CopyWithPlaceholder() || saveLogin == null
          ? _value.saveLogin
          // ignore: cast_nullable_to_non_nullable
          : saveLogin as bool,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      roles: roles == const $CopyWithPlaceholder() || roles == null
          ? _value.roles
          // ignore: cast_nullable_to_non_nullable
          : roles as List<String>,
    );
  }
}

extension $AuthStateCopyWith on AuthState {
  /// Returns a callable class that can be used as follows: `instanceOfAuthState.copyWith(...)` or like so:`instanceOfAuthState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthStateCWProxy get copyWith => _$AuthStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) => AuthState(
      status: $enumDecode(_$AuthStatusEnumMap, json['status']),
      token: json['token'] as String? ?? '',
      saveLogin: json['saveLogin'] as bool? ?? false,
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'status': _$AuthStatusEnumMap[instance.status]!,
      'token': instance.token,
      'saveLogin': instance.saveLogin,
      'email': instance.email,
      'password': instance.password,
      'roles': instance.roles,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.authInitial: 'authInitial',
  AuthStatus.ignoreLogin: 'ignoreLogin',
  AuthStatus.loading: 'loading',
  AuthStatus.loggedIn: 'loggedIn',
  AuthStatus.loggedOut: 'loggedOut',
  AuthStatus.loginFail: 'loginFail',
  AuthStatus.unAuthentication: 'unAuthentication',
  AuthStatus.unauthorized: 'unauthorized',
};
