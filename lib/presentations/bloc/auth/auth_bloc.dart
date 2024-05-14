import 'dart:async';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/auth/auth_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(status: AuthStatus.authInitial)) {
    on<AuthEvent>((event, emit) {});
    on<CheckAuthenticated>(_checkAuthenticated);
    on<LogoutEvent>(_logOut);
  }

  FutureOr<void> _checkAuthenticated(
      CheckAuthenticated event, Emitter<AuthState> emit) async {
    String userToken, email, password;
    if (event.loginResponse != null) {
      userToken = event.loginResponse!.accessToken;
      email = event.email;
      password = event.password;
    } else {
      userToken = state.token;
      email = state.email;
      password = state.password;
    }
    try {
      if (userToken.isNotEmpty) {
        AppConfig.setToken(userToken);
        dI<UserBloc>().add(const GetUserInfo());

        emit(AuthState(
            status: AuthStatus.loggedIn,
            token: userToken,
            saveLogin: event.saveLogin,
            email: email,
            password: password));
      } else {
        emit(const AuthState(status: AuthStatus.unAuthentication));
      }
    } catch (e) {
      emit(const AuthState(status: AuthStatus.unAuthentication));
    }
  }

  FutureOr<void> _logOut(LogoutEvent event, Emitter<AuthState> emit) async {
    if (dI<AuthBloc>().state.saveLogin) {
      emit(AuthState(
          status: AuthStatus.unAuthentication,
          email: state.email,
          password: state.password));
    } else {
      emit(const AuthState(status: AuthStatus.unAuthentication));
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
