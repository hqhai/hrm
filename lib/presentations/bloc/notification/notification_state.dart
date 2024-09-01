import 'package:base_app/domain/entities/notification/notification_message.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.g.dart';

@CopyWith()
class NotificationState extends Equatable {
  final Map<String, NotificationMessage> notifications;
  final List<String> keys;
  final int totalItems;
  final int totalItemsSent;

  const NotificationState({
    this.keys = const [],
    this.notifications = const {},
    this.totalItems = 0,
    this.totalItemsSent = 0,
  });

  @override
  List<Object> get props => [keys, notifications, totalItems];
}
