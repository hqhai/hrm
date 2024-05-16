import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:base_app/presentations/pages/home/side_menu_tile.dart';
import 'package:base_app/presentations/widgets/attendance/layout_calendar.dart';
import 'package:base_app/presentations/widgets/request/doing_request.widget.dart';
import 'package:base_app/presentations/widgets/request/done_request.widget.dart';
import 'package:base_app/presentations/widgets/request/recent_request.widget.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:themes/themes.dart';

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
    dI<LanguageCubit>().changeLocale(LanguageEnum.en);
    Navigator.of(context).pop();
  }

  _vietnamese() {
    dI<LanguageCubit>().changeLocale(LanguageEnum.vi);
    Navigator.of(context).pop();
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
                    child: Text(
                      LanguageEnum.vi.name,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () => _english(),
                    child: Text(
                      LanguageEnum.en.name,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
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
                  Assets.images.icon.home,
                  colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
                ),
                label: appLocalizations.home,
                activeIcon: SvgPicture.asset(
                  Assets.images.icon.home,
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.images.icon.profile,
                  colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
                ),
                label: appLocalizations.profile,
                activeIcon: SvgPicture.asset(
                  Assets.images.icon.profile,
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: colors.text,
            unselectedItemColor: colors.outline,
            onTap: _onItemTapped,
          ),
          body: /*_screen(stateUser),*/
              _widgetOptions.elementAt(_selectedIndex),
        );
      },
    );
  }

  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions = <Widget>[
    const RecentRequest(),
    const DoingRequest(),
    const DoneRequest(),
    const LayoutCalendar(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
