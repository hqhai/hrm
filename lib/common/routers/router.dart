import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/presentations/pages/error.page.dart';
import 'package:base_app/presentations/pages/home/home.page.dart';
import 'package:base_app/presentations/pages/login/login.page.dart';
import 'package:base_app/presentations/pages/main.page.dart';
import 'package:base_app/presentations/pages/register/register.page.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'pages.dart';

@lazySingleton
class AppRouters {
  final GoRouter goRouter;

  AppRouters() : goRouter = _router;

  static GoRouter get _router => GoRouter(
      routes: routerPages,
      navigatorKey: dI<AppNavigation>().navigatorKey,
      initialLocation: '/');

  static List<GoRoute> routerPages = {
    Pages.main: mainPageRoute,
    Pages.error: errorPageRoute,
    Pages.login: loginPageRoute,
    Pages.register: registerPageRoute,
    Pages.home: homePageRoute,
  }.entries.map((entry) => entry.value).toList();
}
