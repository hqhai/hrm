import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/use_cases/request_usecase.dart';
import 'package:base_app/presentations/bloc/user/user_by_manager/user_by_admin_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_manager/user_by_admin_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserByAdminBloc extends Bloc<UserByAdminEvent, UserByAdminState> {
  final RequestUseCase _requestUseCase;

  UserByAdminBloc()
      : _requestUseCase = dI<RequestUseCase>(),
        super(const UserByAdminState()) {
    on<UserByAdminEvent>((event, emit) {});
    on<GetUserByManagerEvent>(_getUserByManagerEvent);
  }

  FutureOr<void> _getUserByManagerEvent(
      GetUserByManagerEvent event, Emitter<UserByAdminState> emit) async {
    emit(state.copyWith(status: RequestStatus.getUsersInit));
    try {
      List<User> users = await _requestUseCase.getListUserByRequest(
          startDate: event.startDate, endDate: event.endDate);
      emit(state.copyWith(users: users, status: RequestStatus.getUsersSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.getUsersError));
    }
  }
}
