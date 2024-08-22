import 'package:base_app/common/utils/error_utils.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test Map Errors', (widgetTester) async {
    await widgetTester.pumpWidget(Localizations(
      delegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('vi'),
      child: Builder(
        builder: (context) => Text(
          ErrorUtils.getErrorMessage('NameNotNullOrEmpty', context: context),
        ),
      ),
    ));
  });

   testWidgets('test Map Errors en', (widgetTester) async {
    await widgetTester.pumpWidget(Localizations(
      delegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      child: Builder(
        builder: (context) => Text(
          ErrorUtils.getErrorMessage('NameNotNullOrEmpty', context: context),
        ),
      ),
    ));
  });
}
