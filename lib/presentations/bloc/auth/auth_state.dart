import 'package:base_app/common/enum/enum_config.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_state.g.dart';

@CopyWith()
@JsonSerializable()
class AuthState extends Equatable {
  final AuthStatus status;
  final String token;
  final bool saveLogin;
  final String email;
  final String password;
  final List<String> roles;

  const AuthState(
      {required this.status,
      this.token = '',
      this.saveLogin = false,
      this.email = '',
      this.password = '',
      this.roles = const []});

  @override
  List<Object> get props => [status, token, saveLogin, email, password, roles];

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
  Map<String, dynamic> toJson() => _$AuthStateToJson(this);
}
