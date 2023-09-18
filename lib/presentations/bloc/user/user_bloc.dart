import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'user_event.dart';
part 'user_state.dart';

@lazySingleton
class UserBloc extends Bloc<UserEvent, UserState> {
  
  UserBloc() : super(UserInitial()) {
    on<GetUserInfo>(_getUserInfo);
  }

  FutureOr<void> _getUserInfo(GetUserInfo event, Emitter<UserState> emit) {
  }
}
