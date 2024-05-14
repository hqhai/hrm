import 'package:equatable/equatable.dart';

abstract class UserByAdminEvent extends Equatable {
  const UserByAdminEvent();
}

class GetUserByManagerEvent extends UserByAdminEvent {
  final String startDate;
  final String endDate;

  const GetUserByManagerEvent(
    this.startDate,
    this.endDate,
  );

  @override
  List<Object> get props => [startDate, endDate];
}
