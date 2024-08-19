import 'package:base_app/common/utils/model_utils/color_title.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ColorAndTitle {
  static List<int> listActivate = [0, 1, 2, 3, 4, 5, 6, 7];

  static List<MapColorAndTitle> mapColorAndTitle(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final List<MapColorAndTitle> colorAndTitle = [
      MapColorAndTitle(color: colors.success, title: appLocalizations.onTime),
      MapColorAndTitle(color: colors.orange, title: appLocalizations.lateOrEarly),
      MapColorAndTitle(color: colors.error, title: appLocalizations.timekeepingError),
      MapColorAndTitle(
          color: colors.outline.withOpacity(0.3), title: appLocalizations.forgotChecking),
      MapColorAndTitle(color: colors.navy, title: appLocalizations.isRequest),
      MapColorAndTitle(color: colors.sunriseYellow, title: appLocalizations.holiday),
      MapColorAndTitle(color: colors.goldenPurple, title: appLocalizations.workOffset),
      MapColorAndTitle(color: colors.cyan, title: appLocalizations.noAttendance),
    ];
    return colorAndTitle;
  }
}
