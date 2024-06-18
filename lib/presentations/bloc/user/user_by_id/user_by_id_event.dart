import 'package:equatable/equatable.dart';

sealed class UserByIdEvent extends Equatable {
  const UserByIdEvent();

  @override
  List<Object?> get props => [];
}

class GetUsersByIdEvent extends UserByIdEvent {
  final List<String> ids;

  const GetUsersByIdEvent({
    this.ids = const [],
  });

  @override
  List<Object?> get props => [ids];
}

class GetSubtitudePersonsByIdEvent extends UserByIdEvent {
  final List<String> ids;

  const GetSubtitudePersonsByIdEvent({
    this.ids = const [],
  });

  @override
  List<Object?> get props => [ids];
}
