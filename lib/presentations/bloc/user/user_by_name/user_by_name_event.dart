import 'package:equatable/equatable.dart';

abstract class UserByNameEvent extends Equatable {
  const UserByNameEvent();

  @override
  List<Object> get props => [];
}

class GetUserByNameEvent extends UserByNameEvent {
  final String name;
  final int page;

  const GetUserByNameEvent({this.name = '', this.page = 0});

  @override
  List<Object> get props => [name, page];
}
