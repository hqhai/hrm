import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
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
import 'package:base_app/presentations/pages/home/avatar_system_user.dart';
import 'package:base_app/presentations/pages/home/bottom_bar.dart';
import 'package:base_app/presentations/pages/home/popup_menu_account.dart';
import 'package:base_app/presentations/pages/home/popup_menu_home.dart';
import 'package:base_app/presentations/pages/home/side_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final homePageRoute =
    GoRoute(path: Pages.home, builder: (context, GoRouterState state) => const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndexSystem = 0, selectedIndex = 0;
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
      selectedIndexSystem = entry.key;
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
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, stateUser) {
        _listener(context, stateUser);
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, stateUser) {
        return Scaffold(
          appBar: AppBar(
            title: Text(titleValue(context, selectedIndex),
                style: const TextStyle(fontSize: SpacingUnit.x6_5)),
            actions: !_checkRole() ? [popupMenu(selectedIndex)] : null,
          ),
          drawer: _checkRole()
              ? BlocBuilder<UserBloc, UserState>(
                  builder: (context, stateUser) {
                    return Drawer(
                      width: width * 0.7,
                      child: Container(
                        color: colors.surface,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(SpacingUnit.x3_75),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const AvatarSystemUser(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ...MenuValues.menuUserSystemValues(context).asMap().entries.map(
                                        (entry) => SideMenuTile(
                                          text: entry.value['text'],
                                          checkSelect: selectedIndexSystem == entry.key,
                                          icon: entry.value['icon'],
                                          onTap: () => selectedIndexFunction(entry),
                                        ),
                                      ),
                                  SideMenuTile(
                                    text: appLocalizations.logout,
                                    checkSelect: false,
                                    icon: const Icon(Icons.logout,
                                        color: Colors.white, size: SpacingUnit.x7_5),
                                    onTap: () => logoutFunction(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : null,
          bottomNavigationBar: !_checkRole()
              ? BottomBarDefault(selectedIndex: selectedIndex, onChangeSelectedIndex: (value) => _onItemTapped(value),)
              : null,
          body: Opacity(
            opacity: checkOpacity ? 0.5 : 1,
            child: !_checkRole()
                ? MenuValues.widgetOptionsUser.elementAt(selectedIndex)
                : MenuValues.widgetOptionsUserSystem[selectedIndexSystem],
          ),
        );
      },
    );
  }

  bool _checkRole() {
    return dI<AuthBloc>().state.roles.contains(ConfigRoleStringValues.userSystem.name);
  }

  Widget popupMenu(int selectedIndex) {
    if (selectedIndex == 0) {
      return PopupMenuAccount(onChangeCheckOpacity: (value) => _opacity(value));
    } else if (selectedIndex == 1) {
      return PopupMenuHome(onChangeCheckOpacity: (value) => _opacity(value));
    } else {
      return PopupMenuAccount(onChangeCheckOpacity: (value) => _opacity(value));
    }
  }

  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  String titleValue(BuildContext context, int index) {
    return TitleAppbarValues.listTitleAppbar(context).elementAt(index);
  }
}
