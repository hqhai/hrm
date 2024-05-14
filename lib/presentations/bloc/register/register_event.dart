
import 'package:base_app/data/models/register/register_request.dart';
import 'package:equatable/equatable.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailInputEvent extends RegisterEvent {
  const RegisterEmailInputEvent(this.email, this.registerRequest);

  final String email;
  final RegisterRequest registerRequest;

  @override
  List<Object> get props => [email, registerRequest];
}

class RegisterNameInputEvent extends RegisterEvent {
  const RegisterNameInputEvent(this.firstName, this.lastName, this.registerRequest);

  final RegisterRequest registerRequest;
  final String firstName, lastName;

  @override
  List<Object> get props => [firstName, lastName, registerRequest, ];
}

class RegisterPasswordInputEvent extends RegisterEvent {
  const RegisterPasswordInputEvent(this.password, this.registerRequest);

  final RegisterRequest registerRequest;
  final String password;

  @override
  List<Object> get props => [password, registerRequest];
}

class RegisterRequestEvent extends RegisterEvent {
  const RegisterRequestEvent(this.password, this.registerRequest);

  final RegisterRequest registerRequest;
  final String password;

  @override
  List<Object> get props => [password, registerRequest, ];
}
