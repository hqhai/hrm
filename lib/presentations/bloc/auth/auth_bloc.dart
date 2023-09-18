import 'dart:async';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/constants/key_constance.dart';
import 'package:base_app/common/storage/local_storage.dart';
import 'package:base_app/presentations/bloc/auth/auth_state.dart';
import 'package:base_app/presentations/bloc/user/user_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';

@lazySingleton
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(status: AuthStatus.authInitial)) {
    on<AuthEvent>((event, emit) {});
    on<CheckAuthenticated>(_checkAuthenticated);
    on<Logout>(_logOut);
  }

  FutureOr<void> _checkAuthenticated(event, emit) async {
    String userToken;
    if (event.token != null) {
      userToken = event.token!;
    } else {
      userToken = await AppLocalStorage.getData(DataKey.token) ?? "";
    }
    try {
      if (userToken.isNotEmpty) {
        AppConfig.setToken(userToken);
        dI<UserBloc>().add(const GetUserInfo());
        emit(AuthState(status: AuthStatus.loggedIn, token: userToken));
      } else {
        emit(const AuthState(status: AuthStatus.unauthentication));
      }
    } catch (e) {
      emit(const AuthState(status: AuthStatus.unauthentication));
    }
  }

  FutureOr<void> _logOut(Logout event, Emitter<AuthState> emit) async {
    emit(const AuthState(status: AuthStatus.unauthentication));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final String token = json['token'] ?? '';
    if (token.isNotEmpty) {
      return const AuthState(status: AuthStatus.loggedIn);
    }
    return const AuthState(status: AuthStatus.authInitial);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state.status == AuthStatus.loggedIn) {
      return {'token': true};
    }
    return {'token': false};
  }
}
