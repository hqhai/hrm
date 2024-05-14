import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/themes/language_cubit.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:base_app/presentations/pages/home/side_menu_tile.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final homePageRoute =
    GoRoute(path: Pages.home, builder: (context, GoRouterState state) => const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

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

  _english() {
    dI<LanguageCubit>().changeLocale('en');
    Navigator.of(context).pop();
  }

  _vietnamese() {
    dI<LanguageCubit>().changeLocale('vi');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, stateUser) {
        _listener(context, stateUser);
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, stateUser) {
        return Scaffold(
          appBar: AppBar(actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () => _vietnamese(),
                    child: const Text(
                      'Tiếng Việt',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () => _english(),
                    child: const Text(
                      'English',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
          drawer: Drawer(
            width: kIsWeb
                ? MediaQuery.of(context).size.width * 0.4
                : MediaQuery.of(context).size.width * 0.7,
            child: Container(
              color: const Color(0xff212B45),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x3_75),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blueAccent,
                              child: Icon(Icons.supervisor_account,
                                  color: Colors.white, size: SpacingUnit.x7_5),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: kIsWeb
                                      ? MediaQuery.of(context).size.width * 0.2
                                      : MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    stateUser.user.fullName,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: SpacingUnit.x4_5),
                                  ),
                                ),
                                const SizedBox(
                                  height: SpacingUnit.x1_5,
                                ),
                                SizedBox(
                                  width: kIsWeb
                                      ? MediaQuery.of(context).size.width * 0.2
                                      : MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    stateUser.user.email,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: SpacingUnit.x3_5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (stateUser.user.role == ConfigStringValues.userSystem.name)
                          ...MenuValues.menuUserSystemValues(context).asMap().entries.map(
                                (entry) => SideMenuTile(
                                  text: entry.value['text'],
                                  checkSelect: selectedIndex == entry.key,
                                  icon: entry.value['icon'],
                                  onTap: () => selectedIndexFunction(entry),
                                ),
                              ),
                        if (stateUser.user.role == ConfigStringValues.generalManager.name)
                          ...MenuValues.menuGeneralManagerValues(context).asMap().entries.map(
                                (entry) => SideMenuTile(
                                  text: entry.value['text'],
                                  checkSelect: selectedIndex == entry.key,
                                  icon: entry.value['icon'],
                                  onTap: () => selectedIndexFunction(entry),
                                ),
                              ),
                        if (stateUser.user.role == ConfigStringValues.manager.name)
                          ...MenuValues.menuManagerValues(context).asMap().entries.map(
                                (entry) => SideMenuTile(
                                  text: entry.value['text'],
                                  checkSelect: selectedIndex == entry.key,
                                  icon: entry.value['icon'],
                                  onTap: () => selectedIndexFunction(entry),
                                ),
                              ),
                        if (stateUser.user.role == ConfigStringValues.user.name)
                          ...MenuValues.menuValues(context).asMap().entries.map(
                                (entry) => SideMenuTile(
                                  text: entry.value['text'],
                                  checkSelect: selectedIndex == entry.key,
                                  icon: entry.value['icon'],
                                  onTap: () => selectedIndexFunction(entry),
                                ),
                              ),
                        SideMenuTile(
                          text: appLocalizations.logout,
                          checkSelect: false,
                          icon:
                              const Icon(Icons.logout, color: Colors.white, size: SpacingUnit.x7_5),
                          onTap: () => logoutFunction(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: _screen(stateUser),
        );
      },
    );
  }

  Widget _screen(UserState state) {
    return state.user.role != ''
        ? state.user.role == ConfigStringValues.generalManager.name
            ? MenuValues.widgetOptionsGeneralManager[selectedIndex]
            : state.user.role == ConfigStringValues.manager.name
                ? MenuValues.widgetOptionsManager[selectedIndex]
                : state.user.role == ConfigStringValues.userSystem.name
                    ? MenuValues.widgetOptionsUserSystem[selectedIndex]
                    : MenuValues.widgetOptions[selectedIndex]
        : Container();
  }
}
