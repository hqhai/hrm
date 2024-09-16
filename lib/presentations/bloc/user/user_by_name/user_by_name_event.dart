import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class UserByNameEvent extends Equatable {
  const UserByNameEvent();

  @override
  List<Object?> get props => [];
}

class GetUserByNameEvent extends UserByNameEvent {
  final String name;
  final int page;
  final Completer? completer;

  const GetUserByNameEvent({this.name = '', this.page = 1, this.completer});

  @override
  List<Object?> get props => [name, page, completer];
}

class ResetUserByNameEvent extends UserByNameEvent {
  const ResetUserByNameEvent();

  @override
  List<Object> get props => [];
}
