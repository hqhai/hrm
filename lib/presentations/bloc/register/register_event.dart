import 'package:equatable/equatable.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailInputEvent extends RegisterEvent {
  const RegisterEmailInputEvent({
    this.email = '',
  });

  final String email;

  @override
  List<Object> get props => [
        email,
      ];
}

class RegisterNameInputEvent extends RegisterEvent {
  const RegisterNameInputEvent({
    this.firstName = '',
    this.lastName = '',
  });

  final String firstName, lastName;

  @override
  List<Object> get props => [
        firstName,
        lastName,
      ];
}

class RegisterPasswordInputEvent extends RegisterEvent {
  const RegisterPasswordInputEvent({
    this.password = '',
  });

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterGenderDateOfBirthInputEvent extends RegisterEvent {
  const RegisterGenderDateOfBirthInputEvent({
    this.gender = '',
    this.dateOfBirth = '',
  });

  final String gender;
  final String dateOfBirth;

  @override
  List<Object> get props => [gender, dateOfBirth];
}

class RegisterRequestEvent extends RegisterEvent {
  const RegisterRequestEvent({this.password = ''});

  final String password;

  @override
  List<Object> get props => [password];
}
