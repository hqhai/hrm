import 'dart:async';

import 'package:base_app/common/enum/notification_enum.dart';
import 'package:equatable/equatable.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class GetNotificationsEvent extends NotificationEvent {
  final int page;
  final NotificationStatus status;
  final Completer? completer;

  const GetNotificationsEvent({
    this.page = 1,
    this.status = NotificationStatus.sent,
    this.completer,
  });

  @override
  List<Object?> get props => [status, page, completer];
}

class ChangeNotificationsEvent extends NotificationEvent {
  final List<String>? ids;
  final bool isAll;
  final Completer? completer;

  const ChangeNotificationsEvent({
    this.ids,
    this.isAll = false,
    this.completer,
  });

  @override
  List<Object?> get props => [isAll, ids, completer];
}
