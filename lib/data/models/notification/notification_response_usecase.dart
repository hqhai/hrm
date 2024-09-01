import 'package:base_app/domain/entities/notification/notification_message.dart';

class NotificationResponseUserCase {
  final Map<String, NotificationMessage> items;
  final List<String> keys;
  final int totalItems;

  const NotificationResponseUserCase({
    this.items = const {},
    this.keys = const [],
    this.totalItems = 0,
  });
}
