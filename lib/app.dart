import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/router.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:base_app/presentations/bloc/themes/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:themes/themes.dart';
import 'package:widgets/unfocus_gesture_detector_screen_widget.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<LocalizationsDelegate<dynamic>> get _getLocalizationsDelegates {
    return const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }

  Locale? _localeResolutionCallback(locale, supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale!.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, languageCode) {
        return BlocBuilder<ThemeCubit, AppMode>(
          builder: (context, mode) {
            return KeyboardVisibilityProvider(
              child: UnfocusInkWellScreen(
                child: MaterialApp.router(
                  routerConfig: dI<AppRouters>().goRouter,
                  themeMode: ThemeMode.light,
                  theme: const AppTheme().lightTheme(context),
                  localizationsDelegates: _getLocalizationsDelegates,
                  localeResolutionCallback: _localeResolutionCallback,
                  locale: Locale.fromSubtags(languageCode: languageCode.languageCode.code),
                  supportedLocales: const [
                    Locale('en'),
                    Locale('vi') // us
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
