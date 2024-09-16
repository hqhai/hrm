// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegisterStateCWProxy {
  RegisterState registerRequest(RegisterRequest registerRequest);

  RegisterState requestStatus(RegisterRequestStatus requestStatus);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterState(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterState call({
    RegisterRequest? registerRequest,
    RegisterRequestStatus? requestStatus,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegisterState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegisterState.copyWith.fieldName(...)`
class _$RegisterStateCWProxyImpl implements _$RegisterStateCWProxy {
  final RegisterState _value;

  const _$RegisterStateCWProxyImpl(this._value);

  @override
  RegisterState registerRequest(RegisterRequest registerRequest) =>
      this(registerRequest: registerRequest);

  @override
  RegisterState requestStatus(RegisterRequestStatus requestStatus) =>
      this(requestStatus: requestStatus);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterState(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterState call({
    Object? registerRequest = const $CopyWithPlaceholder(),
    Object? requestStatus = const $CopyWithPlaceholder(),
  }) {
    return RegisterState(
      registerRequest: registerRequest == const $CopyWithPlaceholder() ||
              registerRequest == null
          ? _value.registerRequest
          // ignore: cast_nullable_to_non_nullable
          : registerRequest as RegisterRequest,
      requestStatus:
          requestStatus == const $CopyWithPlaceholder() || requestStatus == null
              ? _value.requestStatus
              // ignore: cast_nullable_to_non_nullable
              : requestStatus as RegisterRequestStatus,
    );
  }
}

extension $RegisterStateCopyWith on RegisterState {
  /// Returns a callable class that can be used as follows: `instanceOfRegisterState.copyWith(...)` or like so:`instanceOfRegisterState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegisterStateCWProxy get copyWith => _$RegisterStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterState _$RegisterStateFromJson(Map<String, dynamic> json) =>
    RegisterState(
      registerRequest: json['registerRequest'] == null
          ? const RegisterRequest(
              firstName: '',
              lastName: '',
              password: '',
              email: '',
              dayOfBirth: '',
              gender: '')
          : RegisterRequest.fromJson(
              json['registerRequest'] as Map<String, dynamic>),
      requestStatus: $enumDecodeNullable(
              _$RegisterRequestStatusEnumMap, json['requestStatus']) ??
          RegisterRequestStatus.init,
    );

Map<String, dynamic> _$RegisterStateToJson(RegisterState instance) =>
    <String, dynamic>{
      'registerRequest': instance.registerRequest,
      'requestStatus': _$RegisterRequestStatusEnumMap[instance.requestStatus]!,
    };

const _$RegisterRequestStatusEnumMap = {
  RegisterRequestStatus.init: 'init',
  RegisterRequestStatus.success: 'success',
  RegisterRequestStatus.nameInput: 'nameInput',
  RegisterRequestStatus.emailInput: 'emailInput',
  RegisterRequestStatus.passwordInput: 'passwordInput',
  RegisterRequestStatus.errorNameInput: 'errorNameInput',
  RegisterRequestStatus.errorEmailInput: 'errorEmailInput',
  RegisterRequestStatus.errorPasswordInput: 'errorPasswordInput',
  RegisterRequestStatus.registerInit: 'registerInit',
  RegisterRequestStatus.registerSuccess: 'registerSuccess',
  RegisterRequestStatus.registerError: 'registerError',
};
