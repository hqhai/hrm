import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/use_cases/user_usecase.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserByIdBloc extends HydratedBloc<UserByIdEvent, UserByIdState> {
  final UserUseCase userUseCase;

  UserByIdBloc()
      : userUseCase = dI<UserUseCase>(),
        super(const UserByIdState()) {
    on<GetUsersByIdEvent>(_getUsersByIdEvent);
    on<GetSubtitudePersonsByIdEvent>(_getSubtitudePersonsByIdEvent);
    on<ResetUserByIdEvent>(_resetUserByIdEvent);
  }

  FutureOr<void> _getUsersByIdEvent(GetUsersByIdEvent event, Emitter<UserByIdState> emit) async {
    emit(state.copyWith(status: UserStatus.init));
    try {
      List<User> users = await userUseCase.getUserById(id: event.ids);
      emit(state.copyWith(userById: users, status: UserStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.fail));
    }
  }

  FutureOr<void> _getSubtitudePersonsByIdEvent(
      GetSubtitudePersonsByIdEvent event, Emitter<UserByIdState> emit) async {
    emit(state.copyWith(status: UserStatus.init));
    try {
      List<User> users = await userUseCase.getUserById(id: event.ids);
      emit(state.copyWith(subtitudePersons: users, status: UserStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.fail));
    }
  }

  @override
  UserByIdState? fromJson(Map<String, dynamic> json) {
    return UserByIdState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserByIdState state) {
    return state.toJson();
  }

  FutureOr<void> _resetUserByIdEvent(ResetUserByIdEvent event, Emitter<UserByIdState> emit) {
    emit(const UserByIdState());
  }
}
