import 'dart:async';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/auth/auth_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(status: AuthStatus.authInitial)) {
    on<AuthEvent>((event, emit) {});
    on<CheckAuthenticated>(_checkAuthenticated);
    on<LogoutEvent>(_logOut);
    on<ResetEvent>(_resetEvent);
  }

  FutureOr<void> _checkAuthenticated(CheckAuthenticated event, Emitter<AuthState> emit) async {
    String userToken, email, password;
    List<String> roles;
    if (event.loginResponse != null) {
      userToken = event.loginResponse!.accessToken;
      email = event.email;
      password = event.password;
      roles = event.loginResponse!.roles;
    } else {
      userToken = state.token;
      email = state.email;
      password = state.password;
      roles = state.roles;
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
            password: password,
            roles: roles));
      } else {
        emit(const AuthState(status: AuthStatus.unAuthentication));
      }
    } catch (e) {
      emit(const AuthState(status: AuthStatus.unAuthentication));
    }
  }

  FutureOr<void> _logOut(LogoutEvent event, Emitter<AuthState> emit) async {
    if (dI<AuthBloc>().state.saveLogin) {
      dI<UserBloc>().add(const ResetUserEvent());
      dI<UserByRolesBloc>().add(const ResetUsersEvent());
      AppConfig.setToken('');
      emit(AuthState(
          status: AuthStatus.unAuthentication, email: state.email, password: state.password));
    } else {
      AppConfig.setToken('');
      dI<UserBloc>().add(const ResetUserEvent());
      dI<UserByRolesBloc>().add(const ResetUsersEvent());
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

  void _resetEvent(ResetEvent event, Emitter<AuthState> emit) {

    emit(state.copyWith(
      token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyTmFtZSI6Iml0QGF0bGFudGljLmVkdS52biIsIkZ1bGxOYW1lIjoiSFIgSFIiLCJFbWFpbCI6Iml0QGF0bGFudGljLmVkdS52biIsIlVzZXJJZCI6IjY0REYxOTRFLTY1QUItNEI0Mi04REE5LUI1QjE3NDQ0ODlBRCIsIlN1YiI6ImJhc2VXZWJBcGlTdWJqZWN0IiwiSnRpIjoiZGI2OGMwODAtMGY0My00NGU3LTk0ODYtMzQyZmUyMThmZjk4IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiSFIiLCJSb2xlcyI6IkhSIiwiZXhwIjoxNzA0MzY0NTMxLCJpc3MiOiJiYXNlV2ViQXBpSXNzdWVyIiwiYXVkIjoiYmFzZVdlYkFwaUF1ZGllbmNlIn0.stIeNHtQuT7O5ajACVDnd4RjXOtG9KciSULDDuunZGU"
    ));
  }
}
