import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppNavigation {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  pushWithParams<T>(context, {required String page, required T args}) {
    GoRouter.of(context).push(page);
  }

  push(context,
      {required String page,
      String? params,
      Map<String, dynamic>? paramsQuerry}) {
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
}
