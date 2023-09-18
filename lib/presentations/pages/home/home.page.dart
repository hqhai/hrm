import 'package:base_app/common/routers/pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final homePageRoute = GoRoute(
    path: Pages.home,
    builder: (context, GoRouterState state) => const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
