import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/use_cases/user_usecase.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class UserByRolesBloc extends HydratedBloc<UserByRolesEvent, UserByRolesState> {
  final UserUseCase userUseCase;

  UserByRolesBloc()
      : userUseCase = dI<UserUseCase>(),
        super(const UserByRolesState()) {
    on<UserByRolesEvent>((event, emit) {});
    on<GetUserByRoleEvent>(_getUserByRoleEvent);
    on<ResetUsersEvent>(_resetUsersEvent);
    on<ResetUserByRolesEvent>(_resetUserByRolesEvent);
  }

  FutureOr<void> _getUserByRoleEvent(
      GetUserByRoleEvent event, Emitter<UserByRolesState> emit) async {
    emit(state.copyWith(status: UserStatus.init));
    try {
      List<User> users = await userUseCase.getUserByRole(role: event.role);
      emit(state.copyWith(users: users, status: UserStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.fail));
    }
  }

  FutureOr<void> _resetUsersEvent(ResetUsersEvent event, Emitter<UserByRolesState> emit) async {
    emit(const UserByRolesState(status: UserStatus.unknown));
  }

  @override
  UserByRolesState? fromJson(Map<String, dynamic> json) {
    return UserByRolesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserByRolesState state) {
    return state.toJson();
  }

  FutureOr<void> _resetUserByRolesEvent(ResetUserByRolesEvent event, Emitter<UserByRolesState> emit) {
    emit(const UserByRolesState());
  }
}
