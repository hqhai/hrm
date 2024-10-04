import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/notification/notification_bloc.dart';
import 'package:base_app/presentations/bloc/notification/notification_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:base_app/presentations/pages/home/avatar_system_user.dart';
import 'package:base_app/presentations/pages/home/bottom_bar.dart';
import 'package:base_app/presentations/pages/home/popup_menu_account.dart';
import 'package:base_app/presentations/pages/home/side_menu_tile.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/notification_bottom_sheet.dart';
import 'package:base_app/presentations/widgets/trash_app/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final homePageRoute = GoRoute(
    path: Pages.home,
    builder: (context, GoRouterState state) => const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndexSystem = 0, selectedIndex = 1;
  bool checkOpacity = false;

  @override
  void initState() {
    if (AppConfig.getToken.isNotEmpty) {
      dI<UserBloc>().add(const GetUserInfo());
    }
    dI<NotificationBloc>().add(const GetNotificationsEvent());
    super.initState();
  }

  void selectedIndexFunction(dynamic entry, BuildContext context) {
    setState(() {
      selectedIndexSystem = entry.key;
    });
    if (selectedIndexSystem == 3) {
      _determinePosition(context: context);
    } else if (selectedIndexSystem != 4) {
      Navigator.pop(context);
    } else {
      deleteAccountDialog(
        context,
        () {
          setState(() {
            selectedIndexSystem = 0;
            Navigator.of(context).pop(context);
          });
        },
        () {
          setState(() {
            selectedIndexSystem = 0;
          });
        },
      );
    }
  }

  Future<void> _determinePosition({required BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      LocationPermission newPermission = await Geolocator.requestPermission();
      if (newPermission == LocationPermission.denied) {
        await Geolocator.openLocationSettings();
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    if (context.mounted) {
      dI<AppNavigation>().push(
        context,
        page: Pages.mapLocation,
      );
    }
  }

  void logoutFunction() {
    dI<AuthBloc>().add(const LogoutEvent());
    dI<UserBloc>().add(const ResetUserEvent());
    dI<UserByRolesBloc>().add(const ResetUsersEvent());
  }

  void loginFunction() {
    dI<AuthBloc>().add(const LogoutEvent());
  }

  _listener(BuildContext context, UserState state) {
    if (state.status == UserStatus.unauthorized) {
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
              iconTheme: IconThemeData(color: colors.text),
              centerTitle: true,
              title: _checkRole()
                  ? null
                  : Text(
                      titleValue(context, selectedIndex),
                      style: TextStyle(
                        fontSize: SpacingUnit.x4_5,
                        color: colors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              actions: !_checkRole()
                  ? [
                      popupMenu(selectedIndex, context),
                    ]
                  : null),
          drawer: _checkRole()
              ? BlocBuilder<UserBloc, UserState>(
                  builder: (context, stateUser) {
                    return Drawer(
                      width: width * 0.7,
                      child: Container(
                        color: colors.background,
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
                                  if (dI<AuthBloc>().state.status !=
                                      AuthStatus.ignoreLogin)
                                    ...MenuValues.menuUserSystemValues(context)
                                        .asMap()
                                        .entries
                                        .map(
                                          (entry) => SideMenuTile(
                                            text: entry.value['text'],
                                            checkSelect: selectedIndexSystem ==
                                                entry.key,
                                            icon: entry.value['icon'],
                                            onTap: () => selectedIndexFunction(
                                                entry, context),
                                          ),
                                        ),
                                  if (dI<AuthBloc>().state.status ==
                                      AuthStatus.ignoreLogin)
                                    ...MenuValues.menuGuestValues(context)
                                        .asMap()
                                        .entries
                                        .map(
                                          (entry) => SideMenuTile(
                                            text: entry.value['text'],
                                            checkSelect: selectedIndexSystem ==
                                                entry.key,
                                            icon: entry.value['icon'],
                                            onTap: () => selectedIndexFunction(
                                                entry, context),
                                          ),
                                        ),
                                  if (dI<AuthBloc>().state.status ==
                                      AuthStatus.ignoreLogin)
                                    SideMenuTile(
                                      text: appLocalizations.login,
                                      checkSelect: false,
                                      icon: Icon(Icons.logout,
                                          color: colors.text,
                                          size: SpacingUnit.x7_5),
                                      onTap: () => logoutFunction(),
                                    ),
                                  if (dI<AuthBloc>().state.status !=
                                      AuthStatus.ignoreLogin)
                                    SideMenuTile(
                                      text: appLocalizations.logout,
                                      checkSelect: false,
                                      icon: Icon(Icons.logout,
                                          color: colors.text,
                                          size: SpacingUnit.x7_5),
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
              ? BottomBarDefault(
                  selectedIndex: selectedIndex,
                  onChangeSelectedIndex: (value) => _onItemTapped(value),
                )
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
    return dI<AuthBloc>()
            .state
            .roles
            .contains(ConfigRoleStringValues.userSystem.name) ||
        dI<AuthBloc>().state.status == AuthStatus.ignoreLogin;
  }

  Widget popupMenu(int selectedIndex, BuildContext context) {
    final colors = AppTheme.getColors(context);
    if (selectedIndex == 4) {
      return PopupMenuAccount(onChangeCheckOpacity: (value) => _opacity(value));
    }
    if (selectedIndex == 3) {
      return InkWell(
        onTap: () => _clickNotification(context),
        child: SvgPicture.asset(
          Assets.images.icon.notification.notificationIcon,
          colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
        ),
      );
    }
    return const SizedBox();
  }

  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  String titleValue(BuildContext context, int index) {
    return TitleAppbarValues.listTitleAppbar(context).elementAt(index);
  }

  _clickNotification(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const NotificationBottomSheet();
      },
    );
  }
}
