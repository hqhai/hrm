import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/auth/auth_state.dart';
import 'package:base_app/presentations/bloc/login/login_bloc.dart';
import 'package:base_app/presentations/bloc/login/login_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/pages/home/home.page.dart';
import 'package:base_app/presentations/pages/login/login.page.dart';
import 'package:base_app/presentations/widgets/change_password/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final mainPageRoute =
    GoRoute(path: Pages.main, builder: (context, GoRouterState state) => const MainPage());

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    dI<AuthBloc>().add(const CheckAuthenticated());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, stateLogin) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, stateUser) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state.status == AuthStatus.loggedIn) {
                  if (stateUser.status != UserStatus.getUserInfoErrorUnauthorized) {
                    if (stateLogin.status == LoginStatus.firstLoginSuccess) {
                      return const ChangePassword();
                    }
                    return const HomePage();
                  }
                }
                return const LoginPage();
                /*return const DepartmentWidget();*/
              },
            );
          },
        );
      },
    );
  }
}
