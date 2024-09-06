import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum NotificationStatus{
  @JsonValue('Sent')
  sent('Sent'),
  @JsonValue('Read')
  read('Read'),
  @JsonValue('')
  unknown('');

  final String name;

  const NotificationStatus(this.name);

}

extension ConfigNotificationExtension on NotificationStatus {
  String get configNotificationName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case NotificationStatus.sent:
        return appLocalizations.sent;
      case NotificationStatus.read:
        return appLocalizations.read;
      default:
        return '';
    }
  }
}