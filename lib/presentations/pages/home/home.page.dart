import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:base_app/presentations/pages/home/popup_menu_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

final homePageRoute =
    GoRoute(path: Pages.home, builder: (context, GoRouterState state) => const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool checkOpacity = false;

  @override
  void initState() {
    if (AppConfig.getToken.isNotEmpty) {
      dI<UserBloc>().add(const GetUserInfo());
    }
    super.initState();
  }

  void selectedIndexFunction(dynamic entry) {
    setState(() {
      selectedIndex = entry.key;
      Navigator.pop(context);
    });
  }

  void logoutFunction() {
    setState(() {
      dI<AuthBloc>().add(const LogoutEvent());
      dI<RequestBloc>().add(const ResetRequestEvent());
      dI<UserBloc>().add(const ResetUserEvent());
      dI<UserByRolesBloc>().add(const ResetUsersEvent());
    });
  }

  _listener(BuildContext context, UserState state) {
    if (state.status == UserStatus.getUserInfoErrorUnauthorized) {
      logoutFunction();
    }
  }

  _opacity(bool check) {
    setState(() {
      checkOpacity = check;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, stateUser) {
        _listener(context, stateUser);
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, stateUser) {
        return Scaffold(
          appBar: AppBar(
            title: Text(titleValue(context, selectedIndex)),
            actions: [
              PopupMenuAccount(onChangeCheckOpacity: (value) => _opacity(value)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.images.icon.activate,
                  colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
                ),
                label: appLocalizations.activate,
                activeIcon: SvgPicture.asset(
                  Assets.images.icon.activate,
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.images.icon.homeSvg,
                  colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
                ),
                label: appLocalizations.home,
                activeIcon: SvgPicture.asset(
                  Assets.images.icon.homeSvg,
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.images.icon.profile,
                  colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
                ),
                label: appLocalizations.account,
                activeIcon: SvgPicture.asset(
                  Assets.images.icon.profile,
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: colors.text,
            unselectedItemColor: colors.outline,
            onTap: _onItemTapped,
          ),
          body: Opacity(
            opacity: checkOpacity ? 0.5 : 1,
            child: MenuValues.widgetOptionsUser.elementAt(selectedIndex),
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  String titleValue(BuildContext context, int index) {
    return TitleAppbarValues.listTitleAppbar(context).elementAt(index);
  }
}
