import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/user/search/search_user_by_name_response.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/use_cases/user_usecase.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserByNameBloc extends Bloc<UserByNameEvent, UserByNameState> {
  final UserUseCase userUseCase;

  UserByNameBloc()
      : userUseCase = dI<UserUseCase>(),
        super(const UserByNameState()) {
    on<UserByNameEvent>((event, emit) {});
    on<GetUserByNameEvent>(_getUserByNameEvent);
  }

  FutureOr<void> _getUserByNameEvent(
      GetUserByNameEvent event, Emitter<UserByNameState> emit) async {
    emit(state.copyWith(status: UserStatus.init));
    try {
      SearchUserByNameResponse searchUserByNameResponse =
          await userUseCase.getUserByFullName(fullName: event.name, page: event.page);
      final List<User> newUsers = searchUserByNameResponse.users;
      if (event.name != state.name && event.page == 1) {
        emit(state.copyWith(
          usersByName: newUsers,
          countItem: searchUserByNameResponse.totalItems,
          status: UserStatus.success,
        ));
      } else {
        final List<User> users = [...state.usersByName];
        users.addAll(newUsers);
        emit(state.copyWith(
          usersByName: users,
          countItem: searchUserByNameResponse.totalItems,
          status: UserStatus.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: UserStatus.fail));
    }
  }
}
