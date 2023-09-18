import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/login/login_bloc.dart';
import 'package:base_app/presentations/bloc/themes/theme_cubit.dart';
import 'package:base_app/presentations/bloc/user/user_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() => [
        BlocProvider<ThemeCubit>(
            create: (BuildContext context) => dI<ThemeCubit>()),
        BlocProvider<AuthBloc>(
            create: (BuildContext context) => dI<AuthBloc>()),
        BlocProvider<LoginBloc>(
            create: (BuildContext context) => dI<LoginBloc>()),
        BlocProvider<UserBloc>(
            create: (BuildContext context) => dI<UserBloc>()),
      ];
}
