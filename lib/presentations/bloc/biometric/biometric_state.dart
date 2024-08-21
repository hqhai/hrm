import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/request/login_request.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'biometric_state.g.dart';

@JsonSerializable()
class BiometricState extends Equatable {
  const BiometricState({
    this.loginRequest = const LoginRequest(username: '', password: ''),
    this.checkBiometric = false,
    this.status = BiometricEnum.notRegistered,
  });

  final LoginRequest loginRequest;
  final BiometricEnum status;
  final bool checkBiometric;

  @override
  List<Object> get props => [loginRequest, status, checkBiometric];

  factory BiometricState.fromJson(Map<String, dynamic> json) => _$BiometricStateFromJson(json);

  Map<String, dynamic> toJson() => _$BiometricStateToJson(this);
}
