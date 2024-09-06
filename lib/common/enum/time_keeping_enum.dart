import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum EditTimekeeping {
  @JsonValue('EditTimekeeping')
  editTimekeeping('EditTimekeeping'),
  @JsonValue('Late')
  late('Late'),
  @JsonValue('Early')
  early('Early'),
  @JsonValue('')
  unknown('');

  final String name;

  const EditTimekeeping(this.name);
}

extension ConfigEditTimekeepingExtension on EditTimekeeping {
  String get configEditTimekeepingName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EditTimekeeping.editTimekeeping:
        return appLocalizations.editTimekeeping;
      case EditTimekeeping.late:
        return appLocalizations.youLater;
      case EditTimekeeping.early:
        return appLocalizations.youEarly;
      default:
        return '';
    }
  }
}
