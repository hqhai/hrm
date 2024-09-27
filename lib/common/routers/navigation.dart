import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppNavigation {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  pushWithParams<T>(context, {required String page, required T args}) {
    GoRouter.of(context).push(page);
  }

  isCurrentPage(
      page, {
        BuildContext? buildContext,
      }) {
    final context = buildContext ?? navigatorKey.currentContext!;
    final router = GoRouter.of(context);
    final GoRouterDelegate delegate = router.routerDelegate;
    final routes = delegate.currentConfiguration.routes.reversed
        .map((e) => e as GoRoute)
        .toList();
    final currentPage = routes.first;
    if (page == '/') {
      final result = currentPage.path == page;
      //developer.log('🔎 mainPage isCurrent:$result ');
      return result;
    } else {
      final result = currentPage.path.contains(page);
      //developer.log('🔎 $page isCurrent:$result ');
      return result;
    }
  }

  push(context,
      {required String page,
      String? params,
      Map<String, dynamic>? paramsQuerry,}) {
    if (params != null) {
      final urlParams = '$page/$params';
      if (paramsQuerry != null) {
        final String urlParamsQuerry =
            _navigationQuerryParams(urlParams, paramsQuerry);
        return GoRouter.of(context).push(urlParamsQuerry);
      }

      return GoRouter.of(context).push(urlParams);
    }

    if (paramsQuerry != null) {
      final String urlParamsQuerry =
          _navigationQuerryParams(page, paramsQuerry);
      return GoRouter.of(context).push(urlParamsQuerry);
    }

    return GoRouter.of(context).push(page);
  }

  pushName(context, {required String page, Map<String, dynamic>? extra}) {
    if (extra != null) {
      return GoRouter.of(context).pushNamed(page, extra: extra);
    }
    return GoRouter.of(context).pushNamed(page);
  }

  String _navigationQuerryParams(
      String baseUrl, Map<String, dynamic> paramsQuerry) {
    final String queryString = Uri(
        queryParameters: paramsQuerry
            .map((key, value) => MapEntry(key, value?.toString()))).query;
    return '$baseUrl?$queryString';
  }

  replace(context,
      {required String page,
      String? params,
      Map<String, dynamic>? paramsQuerry}) {
    if (params != null) {
      final urlParams = '$page/$params';
      if (paramsQuerry != null) {
        final String urlParamsQuerry =
            _navigationQuerryParams(urlParams, paramsQuerry);
        return GoRouter.of(context).go(urlParamsQuerry);
      }

      return GoRouter.of(context).go(urlParams);
    }

    if (paramsQuerry != null) {
      final String urlParamsQuerry =
          _navigationQuerryParams(page, paramsQuerry);
      return GoRouter.of(context).go(urlParamsQuerry);
    }
    return GoRouter.of(context).go(page);
  }

  pop(context) {
    return GoRouter.of(context).pop();
  }

  bool canPop(context){
    return GoRouter.of(context).canPop();
  }

  pushReplacementNamed(context,
      {
        required String page,
        Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters = const <String, dynamic>{},
        Object? extra,
      }) {
    GoRouter.of(context).pushReplacementNamed(
      page,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  popUtil(
      page, {
        BuildContext? buildContext,
      }) {
    final context = buildContext ?? navigatorKey.currentContext!;
    final router = GoRouter.of(context);
    final GoRouterDelegate delegate = router.routerDelegate;
    final routes = delegate.currentConfiguration.routes.reversed.toList();
    for (var i = 0; i < routes.length; i++) {
      final route = routes[i] as GoRoute;
      if (route.path == page) return;
      GoRouter.of(context).pop();
    }
  }
}
