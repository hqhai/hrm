import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/use_cases/request_usecase.dart';
import 'package:base_app/domain/use_cases/user_usecase.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase userUseCase;
  final RequestUseCase _requestUseCase;

  UserBloc()
      : userUseCase = dI<UserUseCase>(),
        _requestUseCase = dI<RequestUseCase>(),
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
    emit(state.copyWith(status: UserStatus.init));
    try {
      User user = await userUseCase.getUserInfo();
      emit(state.copyWith(user: user, status: UserStatus.success));
    } catch (e) {
      e as ResponseBase;
      if (e.statusCode == 401) {
        emit(state.copyWith(status: UserStatus.unauthorized));
        AppConfig.setToken('');
      } else {
        emit(state.copyWith(status: UserStatus.fail));
      }
    }
  }

  FutureOr<void> _changePassword(ChangePasswordEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.init));
    try {
      bool checkChangePassword = await userUseCase.changePassword(
          newPassword: event.newPassword, currentPassword: event.currentPassword);
      if (checkChangePassword) {
        emit(state.copyWith(status: UserStatus.success));
        event.completer?.complete(true);
      } else {
        emit(state.copyWith(status: UserStatus.fail));
        event.completer?.complete(false);
      }
    } catch (e) {
      emit(state.copyWith(status: UserStatus.fail));
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _resetUserEvent(ResetUserEvent event, Emitter<UserState> emit) async {
    emit(const UserState(status: UserStatus.unknown));
  }

  FutureOr<void> _forgotPasswordEvent(ForgotPasswordEvent event, Emitter<UserState> emit) async {
    try {
      String email = await userUseCase.forgotPassword(email: event.email);
      emit(state.copyWith(email: email, errorCode: ''));
      event.completer?.complete(true);
    } catch (e) {
      e as ResponseBase;
      final String? errorCode = e.errorMessages.first.errorCode;
      emit(state.copyWith(
        errorCode: errorCode,
      ));
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _deleteAccountEvent(DeleteAccountEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.init));
    try {
      await userUseCase.deleteAccount();
      emit(state.copyWith(status: UserStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.fail));
    }
  }

  FutureOr<void> _updateProfileEvent(UpdateProfileEvent event, Emitter<UserState> emit) async {
    try {
      if (event.file.path != File('').path) {
        String path = await _requestUseCase.uploadFile(originFile: event.file, imageData: null);
        UpdateProfileRequest updateProfileRequest =
            event.updateProfileRequest.copyWith(avatarPath: path);
        final user = await userUseCase.updateProfile(updateProfileRequest: updateProfileRequest);
        emit(
          state.copyWith(
            user: user,
          ),
        );
        event.completer?.complete(true);
      } else {
        User user =
            await userUseCase.updateProfile(updateProfileRequest: event.updateProfileRequest);
        emit(state.copyWith(user: user));
        event.completer?.complete(true);
      }
    } catch (e) {
      e as ResponseBase;
      if (e.errorMessages.length > 1) {
        final String? errorCode = e.errorMessages[1].errorCode;
        emit(state.copyWith(
          errorCode: errorCode,
        ));
      } else {
        final String? errorCode = e.errorMessages.first.errorCode;
        emit(state.copyWith(
          errorCode: errorCode,
        ));
      }
      event.completer?.complete(false);
    }
  }
}
