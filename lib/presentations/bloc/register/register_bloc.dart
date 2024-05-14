import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/register/register_request.dart';
import 'package:base_app/domain/use_cases/user_usecase.dart';
import 'package:base_app/presentations/bloc/register/register_event.dart';
import 'package:base_app/presentations/bloc/register/register_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserUseCase userUseCase;

  RegisterBloc()
      : userUseCase = dI<UserUseCase>(),
        super(const RegisterState(
          registerRequest: RegisterRequest(firstName: '', lastName: '', password: '', email: ''),
          requestStatus: RegisterRequestStatus.init)) {
    on<RegisterEvent>((event, emit) {});
    on<RegisterEmailInputEvent>(registerEmailInputEvent);
    on<RegisterNameInputEvent>(registerNameInputEvent);
    on<RegisterPasswordInputEvent>(registerPasswordInputEvent);
    on<RegisterRequestEvent>(_registerRequestEvent);
  }

  FutureOr<void> registerEmailInputEvent(RegisterEmailInputEvent event,
      Emitter<RegisterState> emit) {
    emit(state.copyWith(requestStatus: RegisterRequestStatus.init));
    try {
      RegisterRequest registerRequest = event.registerRequest.copyWith(
        firstName: event.registerRequest.firstName,
        lastName: event.registerRequest.lastName,
        email: event.email,
        password: event.registerRequest.password,
      );
      emit(state.copyWith(
          registerRequest: registerRequest, requestStatus: RegisterRequestStatus.emailInput));
    } catch (e) {
      emit(state.copyWith(
          registerRequest: event.registerRequest,
          requestStatus: RegisterRequestStatus.errorEmailInput));
    }
  }

  FutureOr<void> registerNameInputEvent(RegisterNameInputEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(requestStatus: RegisterRequestStatus.init));
    try {
      RegisterRequest registerRequest = event.registerRequest.copyWith(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.registerRequest.email,
        password: event.registerRequest.password,
      );
      emit(state.copyWith(
          registerRequest: registerRequest, requestStatus: RegisterRequestStatus.nameInput));
    } catch (e) {
      emit(state.copyWith(
          registerRequest: event.registerRequest,
          requestStatus: RegisterRequestStatus.errorNameInput));
    }
  }

  FutureOr<void> registerPasswordInputEvent(RegisterPasswordInputEvent event,
      Emitter<RegisterState> emit) {
    emit(state.copyWith(requestStatus: RegisterRequestStatus.init));
    try {
      RegisterRequest registerRequest = event.registerRequest.copyWith(
        firstName: event.registerRequest.firstName,
        lastName: event.registerRequest.lastName,
        email: event.registerRequest.email,
        password: event.password,
      );
      emit(state.copyWith(
          registerRequest: registerRequest, requestStatus: RegisterRequestStatus.passwordInput));
    } catch (e) {
      emit(state.copyWith(
          registerRequest: event.registerRequest,
          requestStatus: RegisterRequestStatus.errorPasswordInput));
    }
  }

  FutureOr<void> _registerRequestEvent(RegisterRequestEvent event,
      Emitter<RegisterState> emit) async {
    emit(state.copyWith(requestStatus: RegisterRequestStatus.registerInit));
    try {
      RegisterRequest registerRequest = event.registerRequest.copyWith(password: event.password);
      await userUseCase.register(registerRequest: registerRequest);
      emit(state.copyWith(registerRequest: registerRequest, requestStatus: RegisterRequestStatus.registerSuccess));
    } catch (e) {
      emit(state.copyWith(requestStatus: RegisterRequestStatus.registerError));
    }
  }
}
