import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/exception/remote/remote_exception.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/error_utils.dart';
import 'package:base_app/common/utils/toast_utils.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/use_cases/request_usecase.dart';
import 'package:base_app/domain/use_cases/user_usecase.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

@lazySingleton
class UserBloc extends HydratedBloc<UserEvent, UserState> {
  final UserUseCase userUseCase;
  final RequestUseCase _requestUseCase;

  UserBloc()
      : userUseCase = dI<UserUseCase>(),
        _requestUseCase = dI<RequestUseCase>(),
        super(const UserState()) {
    on<GetUserInfo>(_getUserInfo);
    on<ChangePasswordEvent>(_changePassword);
    on<ResetUserEvent>(_resetUserEvent);
    on<ForgotPasswordEvent>(_forgotPasswordEvent);
    on<DeleteAccountEvent>(_deleteAccountEvent);
    on<UpdateProfileEvent>(_updateProfileEvent);
  }

  FutureOr<void> _getUserInfo(
      GetUserInfo event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.init));
    try {
      User user = await userUseCase.getUserInfo();
      OneSignal.login(user.id);
      OneSignal.User.addTagWithKey('UserId', user.id);
      emit(state.copyWith(user: user, status: UserStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.fail));
    }
  }

  FutureOr<void> _changePassword(
      ChangePasswordEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.init));
    try {
      bool checkChangePassword = await userUseCase.changePassword(
          newPassword: event.newPassword,
          currentPassword: event.currentPassword);
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

  FutureOr<void> _resetUserEvent(
      ResetUserEvent event, Emitter<UserState> emit) async {
    emit(const UserState(status: UserStatus.unknown));
  }

  FutureOr<void> _forgotPasswordEvent(
      ForgotPasswordEvent event, Emitter<UserState> emit) async {
    try {
      String email = await userUseCase.forgotPassword(email: event.email);
      emit(state.copyWith(email: email, errorCode: ''));
      event.completer?.complete(true);
    } catch (e) {
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      if (e is RemoteException) {
        final listErrorCode = e.serverError?.errors.map((e) => e).toList();
        if (listErrorCode != null && listErrorCode.isNotEmpty) {
          emit(state.copyWith(
            errorCode: listErrorCode.first,
          ));
          if (currentContext.mounted) {
            dI<AppNavigation>().pop(currentContext);
            ToastUtils().showError(ErrorUtils.getErrorMessage(
                listErrorCode.first,
                context: currentContext));
          }
        } else {
          emit(state.copyWith(errorCode: 'error'));
        }

        event.completer?.complete(false);
      } else {
        emit(state.copyWith(
          errorCode: 'error',
        ));
        if (currentContext.mounted) {
          dI<AppNavigation>().pop(currentContext);
          ToastUtils().showError(
              ErrorUtils.getErrorMessage('error', context: currentContext));
        }
        event.completer?.complete(false);
      }
    }
  }

  FutureOr<void> _deleteAccountEvent(
      DeleteAccountEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.init));
    try {
      await userUseCase.deleteAccount();
      dI<AuthBloc>().add(const LogoutEvent());
      emit(state.copyWith(status: UserStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.fail));
    }
  }

  FutureOr<void> _updateProfileEvent(
      UpdateProfileEvent event, Emitter<UserState> emit) async {
    try {
      if (event.file.path != File('').path) {
        String path = '';
        try {
          path = await _requestUseCase.uploadFile(
              originFile: event.file, imageData: null);
        } catch (e) {
          emit(state.copyWith(
            errorCode: 'error',
          ));
          event.completer?.complete(false);
          return;
        }
        UpdateProfileRequest updateProfileRequest =
            event.updateProfileRequest.copyWith(avatarPath: path);
        final user = await userUseCase.updateProfile(
            updateProfileRequest: updateProfileRequest);
        emit(
          state.copyWith(
            user: user,
          ),
        );
        event.completer?.complete(true);
      } else {
        User user = await userUseCase.updateProfile(
            updateProfileRequest: event.updateProfileRequest);
        emit(state.copyWith(user: user));
        event.completer?.complete(true);
      }
    } catch (e) {
      if (e is RemoteException) {
        final listErrorCode = e.serverError?.errors.map((e) => e).toList();
        if (listErrorCode != null && listErrorCode.isNotEmpty) {
          emit(state.copyWith(
            errorCode: listErrorCode.first,
          ));
        } else {
          emit(state.copyWith(
            errorCode: 'error',
          ));
        }
        event.completer?.complete(false);
      } else {
        emit(state.copyWith(
          errorCode: 'error',
        ));
        event.completer?.complete(false);
      }
    }
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toJson();
  }
}
