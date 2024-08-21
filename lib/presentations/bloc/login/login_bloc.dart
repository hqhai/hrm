import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/use_cases/login_usecase.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_cubit.dart';
import 'package:base_app/presentations/bloc/login/login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:base_app/data/models/response.dart';

part 'login_event.dart';

@lazySingleton
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final AuthBloc _authBloc;

  LoginBloc()
      : _loginUseCase = dI<LoginUseCase>(),
        _authBloc = dI<AuthBloc>(),
        super(const LoginState()) {
    on<RequestLogin>(_requestLogin);
    on<ValidateLogin>(_validate);
    on<StatusLogin>(_status);
    on<PassLogin>(_passWordLogin);
    on<EmailOrUserLogin>(_emailOrUserNameLogin);
    on<ChangePasswordSuccessEvent>(_changePasswordSuccessEvent);
    on<BiometricRequestLogin>(_biometricRequestLogin);
    on<CheckBiometricAccount>(_checkBiometricAccount);
  }

  FutureOr<void> _requestLogin(RequestLogin event, Emitter<LoginState> emit) async {
    if (event.username.isEmpty && event.password.isEmpty) {
      emit(state.copyWith(
          username: event.username,
          password: event.password,
          status: LoginStatus.loginAccountRequired));
      return;
    } else {
      try {
        final loginResponse =
            await _loginUseCase.login(username: event.username, password: event.password);
        _authBloc.add(CheckAuthenticated(
            loginResponse: loginResponse,
            saveLogin: event.saveLogin,
            email: event.username,
            password: event.password));
        if (loginResponse.isFirstLogin == true) {
          emit(state.copyWith(
              username: event.username,
              password: event.password,
              status: LoginStatus.firstLoginSuccess));
        } else {
          emit(state.copyWith(
              username: event.username,
              password: event.password,
              status: LoginStatus.loginSuccess));
        }
      } catch (e) {
        e as ResponseBase;
        if (e.statusCode == 403) {
          emit(state.copyWith(
              username: event.username, password: event.password, status: LoginStatus.userLocked));
        } else {
          emit(state.copyWith(
              username: event.username, password: event.password, status: LoginStatus.loginFailed));
        }
      }
    }
  }

  FutureOr<void> _validate(ValidateLogin event, Emitter<LoginState> emit) async {
    emit(LoginInitial());
    if (event.username.isNotEmpty && event.password.isNotEmpty) {
      emit(state.copyWith(status: LoginStatus.validateSuccess));
    } else {
      if (event.password.isEmpty && event.username.isEmpty) {
        BiometricEnum biometricEnum = dI<BiometricCubit>().state.status;
        if (biometricEnum == BiometricEnum.notRegistered) {
          emit(state.copyWith(
            status: LoginStatus.notRegisteredForBiometrics,
          ));
        } else {
          emit(state.copyWith(status: LoginStatus.validateFailed));
        }
      } else if (event.username.isEmpty) {
        emit(state.copyWith(status: LoginStatus.emailOrUserFalse));
      } else {
        emit(state.copyWith(status: LoginStatus.passFalse));
      }
    }
  }

  FutureOr<void> _status(StatusLogin event, Emitter<LoginState> emit) async {
    emit(LoginInitial());
    if (event.status == 200) {
      emit(state.copyWith(status: LoginStatus.statusSuccess));
    } else {
      emit(state.copyWith(status: LoginStatus.statusFalse));
    }
  }

  FutureOr<void> _emailOrUserNameLogin(EmailOrUserLogin even, Emitter<LoginState> emit) async {
    emit(LoginInitial());
    if (even.email.isNotEmpty) {
      emit(state.copyWith(status: LoginStatus.emailOrUserFalse));
    }
  }

  FutureOr<void> _passWordLogin(PassLogin even, Emitter<LoginState> emit) async {
    emit(LoginInitial());
    if (even.password.isNotEmpty) {
      emit(state.copyWith(status: LoginStatus.passFalse));
    }
  }

  FutureOr<void> _changePasswordSuccessEvent(
      ChangePasswordSuccessEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: LoginStatus.loginSuccess));
  }

  FutureOr<void> _biometricRequestLogin(
      BiometricRequestLogin event, Emitter<LoginState> emit) async {
    BiometricEnum biometricEnum = dI<BiometricCubit>().state.status;
    if (biometricEnum == BiometricEnum.notRegistered) {
      emit(state.copyWith(
        status: LoginStatus.notRegisteredForBiometrics,
      ));
    } else if (event.username.isEmpty && event.password.isEmpty) {
      emit(state.copyWith(
          username: event.username,
          password: event.password,
          status: LoginStatus.loginAccountRequired));
      return;
    } else {
      try {
        final loginResponse =
            await _loginUseCase.login(username: event.username, password: event.password);
        _authBloc.add(CheckAuthenticated(
            loginResponse: loginResponse,
            saveLogin: true,
            email: event.username,
            password: event.password));
        if (loginResponse.isFirstLogin == true) {
          emit(state.copyWith(
              username: event.username,
              password: event.password,
              status: LoginStatus.firstLoginSuccess));
        } else {
          emit(state.copyWith(
              username: event.username,
              password: event.password,
              status: LoginStatus.loginSuccess));
        }
      } catch (e) {
        e as ResponseBase;
        if (e.statusCode == 403) {
          emit(state.copyWith(status: LoginStatus.userLocked));
        } else if (e.statusCode == 401) {
          emit(state.copyWith(status: LoginStatus.wrongBiometricAccount));
        } else {
          emit(state.copyWith(status: LoginStatus.loginFailed));
        }
      }
    }
  }

  FutureOr<void> _checkBiometricAccount(
      CheckBiometricAccount event, Emitter<LoginState> emit) async {
    try {
      await _loginUseCase.checkAccountBiometric(
        username: event.username,
        password: event.password,
      );
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }
}
