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
    on<DeleteAccountEvent>(_deleteAccountEvent);
    on<UpdateProfileEvent>(_updateProfileEvent);
  }

  FutureOr<void> _getUserInfo(GetUserInfo event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.getUserInfoInit));
    try {
      User user = await userUseCase.getUserInfo();
      emit(state.copyWith(user: user, status: UserStatus.getUserInfoSuccess));
    } catch (e) {
      e as ResponseBase;
      if (e.statusCode == 401) {
        emit(state.copyWith(status: UserStatus.getUserInfoErrorUnauthorized));
      } else {
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
    emit(state.copyWith(
      status: UserStatus.forgotPasswordInit,
    ));
    try {
      await userUseCase.forgotPassword(email: event.email);
      emit(state.copyWith(status: UserStatus.forgotPasswordSuccess));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.forgotPasswordError));
    }
  }

  FutureOr<void> _deleteAccountEvent(DeleteAccountEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.deleteAccountInit));
    try {
      await userUseCase.deleteAccount();
      emit(state.copyWith(status: UserStatus.deleteAccountSuccess));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.deleteAccountError));
    }
  }

  FutureOr<void> _updateProfileEvent(UpdateProfileEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.updateProfileInit));
    try {
      await userUseCase.updateProfile(updateProfileRequest: event.updateProfileRequest);
      emit(state.copyWith(status: UserStatus.updateProfileSuccess));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.updateProfileError));
    }
  }
}
