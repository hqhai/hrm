import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/register/register_request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_state.g.dart';

@CopyWith()
@JsonSerializable()
class RegisterState extends Equatable {
  const RegisterState(
      {this.registerRequest = const RegisterRequest(
          firstName: '', lastName: '', password: '', email: '', dayOfBirth: '', gender: ''),
      this.requestStatus = RegisterRequestStatus.init});

  final RegisterRequest registerRequest;
  final RegisterRequestStatus requestStatus;

  @override
  List<Object> get props => [registerRequest, requestStatus];

  factory RegisterState.fromJson(Map<String, dynamic> json) => _$RegisterStateFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterStateToJson(this);
}
