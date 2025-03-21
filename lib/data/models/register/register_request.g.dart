// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegisterRequestCWProxy {
  RegisterRequest firstName(String firstName);

  RegisterRequest lastName(String lastName);

  RegisterRequest gender(String gender);

  RegisterRequest dayOfBirth(String dayOfBirth);

  RegisterRequest email(String email);

  RegisterRequest password(String password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterRequest call({
    String? firstName,
    String? lastName,
    String? gender,
    String? dayOfBirth,
    String? email,
    String? password,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegisterRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegisterRequest.copyWith.fieldName(...)`
class _$RegisterRequestCWProxyImpl implements _$RegisterRequestCWProxy {
  const _$RegisterRequestCWProxyImpl(this._value);

  final RegisterRequest _value;

  @override
  RegisterRequest firstName(String firstName) => this(firstName: firstName);

  @override
  RegisterRequest lastName(String lastName) => this(lastName: lastName);

  @override
  RegisterRequest gender(String gender) => this(gender: gender);

  @override
  RegisterRequest dayOfBirth(String dayOfBirth) => this(dayOfBirth: dayOfBirth);

  @override
  RegisterRequest email(String email) => this(email: email);

  @override
  RegisterRequest password(String password) => this(password: password);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterRequest call({
    Object? firstName = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? dayOfBirth = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
  }) {
    return RegisterRequest(
      firstName: firstName == const $CopyWithPlaceholder() || firstName == null
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String,
      lastName: lastName == const $CopyWithPlaceholder() || lastName == null
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String,
      gender: gender == const $CopyWithPlaceholder() || gender == null
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as String,
      dayOfBirth:
          dayOfBirth == const $CopyWithPlaceholder() || dayOfBirth == null
              ? _value.dayOfBirth
              // ignore: cast_nullable_to_non_nullable
              : dayOfBirth as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      password: password == const $CopyWithPlaceholder() || password == null
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $RegisterRequestCopyWith on RegisterRequest {
  /// Returns a callable class that can be used as follows: `instanceOfRegisterRequest.copyWith(...)` or like so:`instanceOfRegisterRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegisterRequestCWProxy get copyWith => _$RegisterRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      dayOfBirth: json['dayOfBirth'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dayOfBirth': instance.dayOfBirth,
      'gender': instance.gender,
      'email': instance.email,
      'password': instance.password,
    };
