import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/use_cases/user_usecase.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase userUseCase;

  UserBloc()
      : userUseCase = dI<UserUseCase>(),
        super(const UserState()) {
    on<UserEvent>((event, emit) {});
    on<GetUserInfo>(_getUserInfo);
    on<ChangePasswordEvent>(_changePassword);
    on<ResetUserEvent>(_resetUserEvent);
    on<ForgotPasswordEvent>(_forgotPasswordEvent);
  }

  User userExample = const User(
    id: '66771508',
    fullName: 'Nguyen Van A',
    email: 'hieu@gmail.com',
    code: 'NVA',
    avatarPath: '',
    type: 'ha?',
    department: 'phong 1',
    phoneNumber: '66771508',
    role: 'GeneralManager',
    status: UserStatus.getUserInfoSuccess,
    personId: '12345678',
  );

  FutureOr<void> _getUserInfo(GetUserInfo event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.getUserInfoInit));
    try {
      User user = await userUseCase.getUserInfo();
      emit(state.copyWith(user: user, status: UserStatus.getUserInfoSuccess));
    } catch (e) {
      e as ResponseBase;
      if (e.statusCode == 401) {
        emit(state.copyWith(status: UserStatus.getUserInfoErrorUnauthorized));
      }
      else{
        emit(state.copyWith(status: UserStatus.getUserInfoError));
      }
    }
  }

  FutureOr<void> _changePassword(ChangePasswordEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.changePasswordInit));
    try {
      bool checkChangePassword = await userUseCase.changePassword(
          newPassword: event.newPassword, currentPassword: event.currentPassword);
      checkChangePassword
          ? emit(state.copyWith(status: UserStatus.changePasswordSuccess))
          : emit(state.copyWith(status: UserStatus.changePasswordError));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.changePasswordError));
    }
  }

  FutureOr<void> _resetUserEvent(ResetUserEvent event, Emitter<UserState> emit) async {
    emit(const UserState(status: UserStatus.unknown));
  }

  FutureOr<void> _forgotPasswordEvent(ForgotPasswordEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.forgotPasswordInit,));
    try {
      await userUseCase.forgotPassword(email: event.email);
      emit(state.copyWith(status: UserStatus.forgotPasswordSuccess));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.forgotPasswordError));
    }
  }
}
