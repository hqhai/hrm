import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/notification_enum.dart';
import 'package:base_app/domain/entities/notification/notification_message.dart';
import 'package:base_app/domain/use_cases/notification_usecase.dart';
import 'package:base_app/presentations/bloc/notification/notification_event.dart';
import 'package:base_app/presentations/bloc/notification/notification_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationBloc extends HydratedBloc<NotificationEvent, NotificationState> {
  final NotificationUseCase _notificationUseCase;

  NotificationBloc()
      : _notificationUseCase = dI<NotificationUseCase>(),
        super(const NotificationState()) {
    on<NotificationEvent>((event, emit) {});
    on<ChangeNotificationsEvent>(_changeNotificationsEvent);
    on<GetNotificationsEvent>(_getNotificationsEvent);
    on<ResetNotificationEvent>(_resetNotificationEvent);
  }

  FutureOr<void> _changeNotificationsEvent(
      ChangeNotificationsEvent event, Emitter<NotificationState> emit) async {
    try {
      await _notificationUseCase.changeNotificationStatus(isAll: event.isAll, ids: event.ids);
      final ids = event.ids ?? [];
      if (ids.isEmpty) {
        emit(state.copyWith(keys: [], totalItems: 0, notifications: {}, totalItemsSent: 0));
      } else {
        emit(state.copyWith(
          totalItems: state.totalItems - 1,
          totalItemsSent: state.totalItemsSent - 1,
        ));
      }
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _getNotificationsEvent(
      GetNotificationsEvent event, Emitter<NotificationState> emit) async {
    try {
      final response =
          await _notificationUseCase.getNotification(page: event.page, status: event.status);
      final newMap = response.items;
      final newKeys = response.keys;
      final totalItems = response.totalItems;
      int totalItemsSent = state.totalItemsSent;
      if (event.status == NotificationStatus.sent) {
        totalItemsSent = totalItems;
      }
      if (event.page != 1) {
        final Map<String, NotificationMessage> map = state.notifications;
        map.addAll(newMap);
        final keys = [...state.keys, ...newKeys];

        emit(state.copyWith(
            keys: keys,
            notifications: map,
            totalItems: totalItems,
            totalItemsSent: totalItemsSent));
      } else {
        emit(state.copyWith(
            keys: newKeys,
            notifications: newMap,
            totalItems: totalItems,
            totalItemsSent: totalItemsSent));
      }
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  @override
  NotificationState? fromJson(Map<String, dynamic> json) {
    return NotificationState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NotificationState state) {
    return state.toJson();
  }

  FutureOr<void> _resetNotificationEvent(ResetNotificationEvent event, Emitter<NotificationState> emit) {
    emit(const NotificationState());
  }
}
