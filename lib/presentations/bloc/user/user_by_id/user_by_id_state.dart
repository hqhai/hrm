import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user_by_id_state.g.dart';

@CopyWith()
class UserByIdState extends Equatable {
  final List<User> userById;
  final List<User> subtitudePersons;
  final UserStatus status;

  const UserByIdState({
    this.status = UserStatus.init,
    this.userById = const [],
    this.subtitudePersons = const [],
  });

  @override
  List<Object> get props => [userById, status, subtitudePersons];
}
