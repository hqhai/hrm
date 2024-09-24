import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/register/register_request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_state.g.dart';

const requestDefault = RegisterRequest(
    firstName: '',
    lastName: '',
    password: '',
    email: '',
    dayOfBirth: '1992-09-24T06:54:26.149Z',
    gender: 'Male');

@CopyWith()
@JsonSerializable()
class RegisterState extends Equatable {
  const RegisterState(
      {this.registerRequest = requestDefault,
      this.requestStatus = RegisterRequestStatus.init});

  final RegisterRequest registerRequest;
  final RegisterRequestStatus requestStatus;

  @override
  List<Object> get props => [registerRequest, requestStatus];

  factory RegisterState.fromJson(Map<String, dynamic> json) =>
      _$RegisterStateFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterStateToJson(this);
}
