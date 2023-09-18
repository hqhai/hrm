import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_state.dart';
import 'package:base_app/presentations/pages/home/home.page.dart';
import 'package:base_app/presentations/pages/login/login.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final mainPageRoute = GoRoute(
    path: Pages.main,
    builder: (context, GoRouterState state) => const MainPage());

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.loggedIn) return const HomePage();
        return const LoginPage();
      },
    );
  }
}
